import Foundation
import SwiftUI


import Foundation
import SwiftUI

struct RoomView: View {
    @Binding var room: Room // Lier directement avec la vue parent
    var onUpdate: (Room) -> Void // Closure pour signaler les mises à jour (onUpdate est utilisé pour informer le parent)
    @State private var isEditing = false

    var body: some View {
        HStack(spacing: 10) {
            // Nom de la pièce avec alignement à gauche
            Text(room.name)
                .frame(maxWidth: .infinity, alignment: .leading)

            // Affichage de l'icône en fonction de l'état de la pièce
            if room.outOfOrder {
                // Si la pièce est défaillante, afficher l'icône de warning
                Image("warning_purple") // Icône de warning
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            } else {
                // Sinon, afficher l'icône de lumière en fonction du niveau
                Image(room.lightLevel > 0 ? "light_on_purple" : "light_off_purple") // Icône de lumière
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }

            // Slider pour ajuster l'intensité lumineuse
            Slider(
                value: Binding(
                    get: { Double(room.lightLevel) },
                    set: { newValue in
                        room.lightLevel = Int(newValue)
                        room.lightState = room.lightLevel > 0 ? .on : .off
                        onUpdate(room) // Signale au parent que la valeur a changé
                    }
                ),
                in: 0...100,
                step: 1
            )
            .disabled(room.outOfOrder) // Désactive si la pièce est défectueuse

            // Affichage du pourcentage de la lumière
            Text("\(room.lightLevel)%")

            // Bouton de navigation pour la configuration de la pièce
            NavigationLink(destination: RoomConfigView(room: $room)) {
                Image("settings_purple") // Icône pour les paramètres
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
        }
        .padding()
    }
}
