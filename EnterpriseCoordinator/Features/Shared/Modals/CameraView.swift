//
//  CameraView.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import SwiftUI

struct CameraView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                HStack {
                    Button("Закрыть") {
                        dismiss()
                    }
                    .foregroundStyle(.white)
                    .padding()
                    
                    Spacer()
                }
                
                Spacer()
                
                Text("📷")
                    .font(.system(size: 100))
                
                Text("Камера")
                    .font(.title)
                    .foregroundStyle(.white)
                
                Spacer()
                
                HStack(spacing: 40) {
                    Button("📸") {
                        // Сделать фото
                    }
                    .font(.system(size: 60))
                }
                .padding(.bottom, 50)
            }
        }
    }
}
