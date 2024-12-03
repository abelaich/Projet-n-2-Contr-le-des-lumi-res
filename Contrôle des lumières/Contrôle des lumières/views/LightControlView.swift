import SwiftUI

struct LightControlView: View {
    @StateObject var repository = RoomRepositoryDummyImpl() // Utilisation de @StateObject ici
    @State private var onlyLightsOn = false
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

                Toggle(isOn: $onlyLightsOn) {
                    Text("Show only rooms with lights on")
                }
                .padding()

                List {
                    ForEach($repository.rooms) { $room in
                        if !onlyLightsOn || room.lightState == .on {
                            RoomView(
                                room: $room,
                                onUpdate: { updatedRoom in
                                    repository.updateRoom(updatedRoom) // Mise à jour du room dans le repository
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
