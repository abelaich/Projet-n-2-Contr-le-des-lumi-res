import Foundation

struct Room: Identifiable {
    var id: String { name }
    var name: String
    var lightState: LightState
    var lightLevel: Int
    var lightPower: Int
    var lightType: LightType
    var outOfOrder: Bool
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
