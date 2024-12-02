//
//  RoomView.swift
//  Contrôle des lumières
//
//  Created by Alae on 02/12/2024.
//
import Foundation
import SwiftUI

struct RoomView: View {
    @Binding var room: Room // Lier la pièce à cette vue
    @State private var tempLightLevel: Double
    
    init(room: Binding<Room>) {
            _room = room
            _tempLightLevel = State(initialValue: Double(room.wrappedValue.lightLevel))
        }

    var body: some View {
        HStack(spacing: 16) {
            Text(room.name)
                .frame(maxWidth: .infinity, alignment: .leading)

            // Affichage de l'icône de la lampe selon l'état de l'éclairage
            Image(systemName: room.lightState == .on ? "lightbulb.fill" : room.lightState == .off ? "lightbulb" : "lightbulb.slash")
                .foregroundColor(room.lightState == .on ? .yellow : .gray)

            // Slider pour ajuster le niveau d'éclairage, désactivé si la pièce est défectueuse
            Slider(value: $tempLightLevel, in: 0...100, step: 1)
                            .disabled(room.outOfOrder) // Désactiver si la pièce est en panne
                            .onChange(of: tempLightLevel) { newValue in
                                room.lightLevel = Int(newValue) // Mettre à jour la valeur de lightLevel
                            }

            Text("\(room.lightLevel)%")
        }
        .padding()
    }
}

