//
//  RoomConfigView.swift
//  Contrôle des lumières
//
//  Created by Alae on 02/12/2024.
//

import SwiftUI

struct RoomConfigView: View {
    @Binding var room: Room
    
    var body: some View {
        Form {
            Picker("Light Type", selection: $room.lightType) {
                ForEach(LightType.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            
            Stepper("Light Power (lumens): \(room.lightLevel)", value: $room.lightLevel, in: 0...100, step: 10)
                .disabled(room.outOfOrder) // Désactiver le Stepper si Out of Order est activé
            
            Toggle("Out of Order", isOn: $room.outOfOrder)
                .onChange(of: room.outOfOrder) { newValue in
                    if newValue {
                        room.lightLevel = 0 // Réinitialiser la lumière à 0 si la pièce est hors service
                    }
                }
            
            Button("Copy to Clipboard") {
                UIPasteboard.general.string = "\(room.name): \(room.lightType.rawValue), \(room.lightLevel) lumens"
            }
        }
        .navigationTitle(room.name)
    }
}
