import SwiftUI

struct LightControlView: View {
    @ObservedObject var repository = Injector.roomRepository as! RoomRepositoryDummyImpl
    @State private var onlyLightsOn = false
    @State private var isAllOn = false

    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 20) {
                    Text("All Lights")
                        .font(.title2)
                        .padding(.trailing, 40)

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
                }
                .padding(10)

                List {
                    ForEach($repository.rooms) { $room in
                        if !onlyLightsOn || room.lightState == .on {
                            RoomView(
                                room: $room,
                                onUpdate: { updatedRoom in
                                    repository.updateRoom(updatedRoom)
                                }
                            )
                            .frame(maxWidth: .infinity)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Lights")
        }
    }
}
