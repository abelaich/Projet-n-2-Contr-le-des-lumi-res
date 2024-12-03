import Foundation
import SwiftUI

struct RoomView: View {
    @Binding var room: Room
    var onUpdate: (Room) -> Void
    @State private var isEditing = false

    var body: some View {
        HStack(spacing: 10) {
            Text(room.name)
                .frame(maxWidth: .infinity, alignment: .leading)

            // Icône conditionnelle
            Image(systemName: room.lightLevel > 0 ? "lightbulb.fill" : "lightbulb.slash")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)

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
            .disabled(room.outOfOrder)

            Text("\(room.lightLevel)%")
        }
        .padding()
    }
}
