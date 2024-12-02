//
//  RoomRepository.swift
//  Contrôle des lumières
//
//  Created by Alae on 02/12/2024.
//

import Foundation

class RoomRepository: ObservableObject {
    @Published var rooms = [
        Room(name: "Entrance", lightState: .on, lightLevel: 100, lightType: .led, outOfOrder: false),
        Room(name: "Office 1", lightState: .off, lightLevel: 0, lightType: .halogen, outOfOrder: false),
        Room(name: "Office 2", lightState: .off, lightLevel: 0, lightType: .halogen, outOfOrder: false),
        Room(name: "Supply Room", lightState: .outOfOrder, lightLevel: 0, lightType: .halogen, outOfOrder: true)
    ]

    func turnAllLights(on: Bool) {
        for index in rooms.indices {
            if !rooms[index].outOfOrder { // Si la pièce n'est pas défectueuse
                rooms[index].lightState = on ? .on : .off
                rooms[index].lightLevel = on ? 100 : 0
            }
        }
    }
}
