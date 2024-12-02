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

            // Affichage des images selon l'état de l'éclairage
            Image(room.lightState == .on ? "light_on_purple" : room.lightState == .off ? "light_off_purple" : "warning_purple")
                            .resizable() // redimensionner l'image si nécessaire
                            .scaledToFit()
                            .frame(width: 24, height: 24) // Ajuste la taille de l'image


            // Slider pour ajuster le niveau d'éclairage, désactivé si la pièce est défectueuse
            Slider(value: $tempLightLevel, in: 0...100, step: 1)
                            .disabled(room.outOfOrder) // Désactiver si la pièce est en panne
                            .onChange(of: tempLightLevel) { newValue in
                                room.lightLevel = Int(newValue) // Mettre à jour la valeur de lightLevel
                            }

            Text("\(room.lightLevel)%")
            
            Button(action: {
                            
                        }) {
                            Image("settings_purple")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
        }
        .padding()
    }
}

