import SwiftUI

struct RoomConfigView: View {
    @Binding var room: Room  // Bind the room object

    var body: some View {
        Form {
            Picker("Light Type", selection: $room.lightType) {
                ForEach(LightType.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }

            HStack {
                Text(room.name)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if room.outOfOrder {
                    Image("warning_purple")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                } else {
                    Image(room.lightLevel > 0 ? "light_on_purple" : "light_off_purple")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                
                Slider(
                    value: Binding(
                        get: { Double(room.lightLevel) },
                        set: { newValue in
                            room.lightLevel = Int(newValue)
                            room.lightState = room.lightLevel > 0 ? .on : .off
                        }
                    ),
                    in: 0...100,
                    step: 1
                )
                .disabled(room.outOfOrder)
                .frame(width: 70)
            }
                Stepper("Light Power (lumens): \(room.lightPower)", value: $room.lightPower, in: 1000...10000, step: 100)
                    .disabled(room.outOfOrder)

                Toggle("Out of Order", isOn: $room.outOfOrder)
                    .onChange(of: room.outOfOrder) { newValue in
                        if newValue {
                            room.lightLevel = 0
                        }
                    }

            Button("Copy to Clipboard") {
                let clipboardText = "\(room.name): \(room.lightType.rawValue), \(room.lightLevel) light level, \(room.lightPower) lumens"
                ClipboardHelper.copyToClipboard(text: clipboardText)
            }
            
        }
        .navigationTitle(room.name)
    }
}
