import Foundation

// Define Room structure conforming to Identifiable protocol
struct Room: Identifiable {
    var id: String { name }  // Use name as a unique identifier
    var name: String
    var lightState: LightState  // Store the state of the light
    var lightLevel: Int  // Store the light level (0 to 100)
    var lightType: LightType  // Store the light type (LED or Halogen)
    var outOfOrder: Bool  // Indicates if the room's light is out of order
}

// Define possible light states
enum LightState: String, CaseIterable {
    case on = "On"
    case off = "Off"
    case outOfOrder = "Out of Order"
}

// Define possible light types
enum LightType: String, CaseIterable {
    case led = "LED"
    case halogen = "Halogen"
}
