import SwiftUI

struct LightControlView: View {
    let repository = Injector.roomRepository // Injecting the repository from Injector
    @State private var onlyLightsOn = false // Boolean for controlling the filter
    @State private var isAllOn = false

    var body: some View {
            NavigationView {
                VStack {
                    HStack {
                        Text("All Lights")
                            .font(.title2)
                            .padding()
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
                        .padding()

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
                        .padding()
                    }

                    // Toggle to filter rooms by light state
                    Toggle(isOn: $onlyLightsOn) {
                        Text("Show only rooms with lights on")
                    }
                    .padding()

                    // List of rooms filtered based on light state
                    List {
                        ForEach(repository.rooms) { room in
                            if !onlyLightsOn || room.lightState == .on {
                                RoomView(room: Binding(
                                    get: { room },
                                    set: { newRoom in
                                        // Find the index of the room and update it
                                        if let index = repository.rooms.firstIndex(where: { $0.id == newRoom.id }) {
                                            repository.rooms[index] = newRoom
                                        }
                                    }
                                ))
                            }
                        }
                    }
                }
                .navigationTitle("Rooms")
            }
        }
    }
