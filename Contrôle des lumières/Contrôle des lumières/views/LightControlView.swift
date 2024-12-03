import SwiftUI

// Define the main view for light control
struct LightControlView: View {
    @ObservedObject var repository = Injector.roomRepository as! RoomRepositoryDummyImpl  // Observe the repository
    @State private var onlyLightsOn = false  // Toggle to filter rooms by light state
    @State private var isAllOn = false  // Track if all lights are on

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("All Lights")
                        .font(.title2)
                        .padding()

                    // Button to turn all lights on
                    Button(action: {
                        repository.turnAllLights(on: true)
                        isAllOn = true
                    }) {
                        VStack {
                            Image("light_on_purple")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                            Text("On")
                                .font(.headline)
                        }
                    }
                    .padding()

                    // Button to turn all lights off
                    Button(action: {
                        repository.turnAllLights(on: false)
                        isAllOn = false
                    }) {
                        VStack {
                            Image("light_off_purple")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                            Text("Off")
                                .font(.headline)
                        }
                    }
                    .padding()
                }

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
                        }
                    }
                }
            }
            .navigationTitle("Lights")
        }
    }
}
