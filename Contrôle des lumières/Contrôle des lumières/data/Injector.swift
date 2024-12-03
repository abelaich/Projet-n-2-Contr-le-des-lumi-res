import Foundation

// Injector class to provide the room repository instance
class Injector {
    static let roomRepository: any RoomRepository = RoomRepositoryDummyImpl()  // Provide a RoomRepository instance
}
