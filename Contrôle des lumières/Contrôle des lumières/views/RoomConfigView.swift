import SwiftUI

// Define the room configuration view
struct RoomConfigView: View {
    @Binding var room: Room  // Bind the room object

    var body: some View {
        Form {
            // Picker to select light type
            Picker("Light Type", selection: $room.lightType) {
                ForEach(LightType.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }

            // Stepper to adjust light power in lumens, disabled if room is out of order
            Stepper("Light Power (lumens): \(room.lightLevel)", value: $room.lightLevel, in: 0...100, step: 10)
                .disabled(room.outOfOrder)  // Disable if the room is out of order

            // Toggle to set the room as out of order, reset light level when activated
            Toggle("Out of Order", isOn: $room.outOfOrder)
                .onChange(of: room.outOfOrder) { newValue in
                    if newValue {
                        room.lightLevel = 0  // Reset light level to 0 if out of order
                    }
                }

            // Button to copy room details to clipboard
            Button("Copy to Clipboard") {
                UIPasteboard.general.string = "\(room.name): \(room.lightType.rawValue), \(room.lightLevel) lumens"
            }
        }
        .navigationTitle(room.name)  // Set the navigation title to the room's name
    }
}
