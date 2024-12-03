import Foundation

// Define the RoomRepository protocol
protocol RoomRepository: ObservableObject {
    var rooms: [Room] { get set }  // Store a list of rooms
    func turnAllLights(on: Bool)  // Function to turn all lights on or off
}
