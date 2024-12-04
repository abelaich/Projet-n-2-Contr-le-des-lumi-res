import Foundation
import SwiftUI

struct RoomView: View {
    @Binding var room: Room  // Bind the room object from the parent view
    var onUpdate: (Room) -> Void  // Closure to notify the parent of room updates
    @State private var isEditing = false  // State to manage editing mode

    var body: some View {
        HStack(spacing: 16) {  // Adjusted spacing for consistency
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
                        onUpdate(room)  // Notify parent of the updated room
                    }
                ),
                in: 0...100,
                step: 1
            )
            .disabled(room.outOfOrder)
            .frame(width: 70)

            Text("\(room.lightLevel)%")
                .font(.subheadline)
                .foregroundColor(.gray)

            NavigationLink(destination: RoomConfigView(room: $room)) {
                Image("settings_purple")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .frame(maxWidth: .infinity)
    }
}

