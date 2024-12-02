//
//  Room.swift
//  Contrôle des lumières
//
//  Created by Alae on 02/12/2024.
//

import Foundation

enum LightState: String, CaseIterable {
    case on = "On"
    case off = "Off"
    case outOfOrder = "Out of Order"
}

enum LightType: String, CaseIterable {
    case led = "LED"
    case halogen = "Halogen"
}

struct Room: Identifiable {
    let id = UUID()
    var name: String
    var lightState: LightState
    var lightLevel: Int
    var lightType: LightType
    var outOfOrder: Bool
}
