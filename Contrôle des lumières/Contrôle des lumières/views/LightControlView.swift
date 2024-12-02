//
//  LightControlView.swift
//  Contrôle des lumières
//
//  Created by Alae on 02/12/2024.
//

import Foundation
import SwiftUI

struct LightControlView: View {
    @StateObject var repository = RoomRepository()

    var body: some View {
        VStack {
            HStack {
                Button("Turn All On") {
                    repository.turnAllLights(on: true)
                }
                Button("Turn All Off") {
                    repository.turnAllLights(on: false)
                }
            }
            .padding()
            
            List($repository.rooms) { $room in
                RoomView(room: $room)
            }
        }
    }
}
