import Foundation
import SwiftUI

// Define the Room view
struct RoomView: View {
    @Binding var room: Room  // Bind the room object from the parent view
    var onUpdate: (Room) -> Void  // Closure to notify the parent of room updates
    @State private var isEditing = false  // State to manage editing mode

    var body: some View {
        HStack(spacing: 16) {  // Adjusted spacing for consistency
            // Display the room's name, aligned to the left
            Text(room.name)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)  // Fix the position to the left

            // Conditionally display the warning or light icon based on the room's status
            if room.outOfOrder {
                // Show warning icon if the room is out of order
                Image("warning_purple")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)  // Fixed size
            } else {
                // Show light icon based on light level (on or off)
                Image(room.lightLevel > 0 ? "light_on_purple" : "light_off_purple")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)  // Fixed size
            }

            // Slider to adjust light intensity, disabled if the room is out of order
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
            .disabled(room.outOfOrder)  // Disable slider if room is out of order
            .frame(width: 70)  // Set a fixed width for the slider

            // Display the light level percentage
            Text("\(room.lightLevel)%")
                .font(.subheadline)
                .foregroundColor(.gray)

            // Navigation button for room configuration
            NavigationLink(destination: RoomConfigView(room: $room)) {
                Image("settings_purple")  // Show settings icon
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)  // Fixed size
            } .buttonStyle(PlainButtonStyle())
        }
        .frame(maxWidth: .infinity)  // Ensure the HStack takes the full available width

    }
}
