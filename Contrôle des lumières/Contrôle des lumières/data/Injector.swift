//
//  Injector.swift
//  Contrôle des lumières
//
//  Created by Alae on 02/12/2024.
//

import Foundation

class Injector {
    static let roomRepository: any RoomRepository = RoomRepositoryDummyImpl()
}
