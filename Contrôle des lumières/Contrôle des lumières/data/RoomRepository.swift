//
//  RoomRepository.swift
//  Contrôle des lumières
//
//  Created by Alae on 02/12/2024.
//

import Foundation

protocol RoomRepository: ObservableObject {
    var rooms: [Room] { get set } 
    func turnAllLights(on: Bool)
}
