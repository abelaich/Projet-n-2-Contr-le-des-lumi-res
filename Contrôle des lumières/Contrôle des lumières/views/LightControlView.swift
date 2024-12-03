import SwiftUI

// Define the main view for light control
struct LightControlView: View {
    @ObservedObject var repository = Injector.roomRepository as! RoomRepositoryDummyImpl  // Observe the repository
    @State private var onlyLightsOn = false  // Toggle to filter rooms by light state
    @State private var isAllOn = false  // Track if all lights are on

    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 20) {  // Petit espace entre chaque élément
                    // Texte "All Lights"
                    Text("All Lights")
                        .font(.title2)
                        .padding(.trailing, 40)  // Petit espace à droite du bouton "On"
                    // Bouton pour allumer toutes les lumières
                    Button(action: {
                        repository.turnAllLights(on: true)
                        isAllOn = true
                    }) {
                        VStack {
                            Image("light_on_purple")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            Text("On")
                                .font(.headline)
                        }
                    }
                    .padding(.trailing, 4)  // Petit espace à droite du bouton "On"

                    // Bouton pour éteindre toutes les lumières
                    Button(action: {
                        repository.turnAllLights(on: false)
                        isAllOn = false
                    }) {
                        VStack {
                            Image("light_off_purple")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            Text("Off")
                                .font(.headline)
                        }
                    }
                    .padding(.leading, 4)  // Petit espace à gauche du bouton "Off"
                }
                .frame(maxWidth: .infinity)  // La HStack prend toute la largeur disponible
                .padding(10)  // Padding global autour de la HStack

                
                // List of rooms with light control
                List {
                    ForEach($repository.rooms) { $room in
                        // Only show rooms with lights on if filter is active
                        if !onlyLightsOn || room.lightState == .on {
                            RoomView(
                                room: $room,
                                onUpdate: { updatedRoom in
                                    repository.updateRoom(updatedRoom)  // Update room in repository
                                }
                            )
                            .frame(maxWidth: .infinity)  // Ensure the RoomView takes up full width
                        }
                    }
                }
                .frame(maxWidth: .infinity)  // Ensure the List takes up full width
                .listStyle(PlainListStyle())  // Use PlainListStyle for better control over layout
            }
            .frame(maxWidth: .infinity)  // Ensure the VStack takes up full width
            .navigationTitle("Lights")
        }
    }
}
