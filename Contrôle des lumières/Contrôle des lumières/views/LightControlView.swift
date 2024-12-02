import SwiftUI

struct LightControlView: View {
    @StateObject var roomRepository = RoomRepository() // Your Room Repository
    @State private var isAllOn = false // Boolean for controlling all lights

    var body: some View {
        NavigationView {
            VStack {
                // Buttons to control all lights
                HStack {
                    // Mini title for All Lights section
                    Text("All Lights")
                        .font(.title2)
                        .padding()
                    
                    Button(action: {
                        roomRepository.turnAllLights(on: true) // Turn all lights on
                        isAllOn = true
                    }) {
                        Image("light_on_purple") // Your image for 'on'
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                    }
                    .padding()

                    Button(action: {
                        roomRepository.turnAllLights(on: false) // Turn all lights off
                        isAllOn = false
                    }) {
                        Image("light_off_purple") // Your image for 'off'
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                    }
                    .padding()
                }

                List {
                    ForEach($roomRepository.rooms) { $room in
                        RoomView(room: $room)
                    }
                }
            }
            .navigationTitle("Lights")
        }
    }
}

struct LightsView_Previews: PreviewProvider {
    static var previews: some View {
        LightControlView()
    }
}
