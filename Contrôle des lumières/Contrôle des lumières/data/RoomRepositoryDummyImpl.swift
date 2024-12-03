import Foundation

// Implement the RoomRepository protocol with a dummy repository
class RoomRepositoryDummyImpl: RoomRepository, ObservableObject {
    @Published var rooms = [
        Room(name: "Entrance", lightState: .on, lightLevel: 100, lightType: .led, outOfOrder: false),
        Room(name: "Office 1", lightState: .off, lightLevel: 0, lightType: .halogen, outOfOrder: false),
        Room(name: "Office 2", lightState: .off, lightLevel: 0, lightType: .halogen, outOfOrder: false),
        Room(name: "Supply Room", lightState: .outOfOrder, lightLevel: 0, lightType: .halogen, outOfOrder: true)
    ]

    // Turn all lights on or off, adjusting their level accordingly
    func turnAllLights(on: Bool) {
        for index in rooms.indices {
            if !rooms[index].outOfOrder {
                rooms[index].lightState = on ? .on : .off
                rooms[index].lightLevel = on ? 100 : 0  // Set light level to 100 when on, 0 when off
            }
        }
    }
    
    // Update a specific room with new data
    func updateRoom(_ updatedRoom: Room) {
        if let index = rooms.firstIndex(where: { $0.id == updatedRoom.id }) {
            rooms[index] = updatedRoom  // Update the room in the repository
        }
    }
}
