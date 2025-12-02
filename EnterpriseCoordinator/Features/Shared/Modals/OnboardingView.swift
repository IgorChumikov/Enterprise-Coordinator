//
//  OnboardingView.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("👋")
                    .font(.system(size: 100))
                
                Text("Добро пожаловать!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                Text("Это пример онбординга")
                    .foregroundStyle(.white.opacity(0.8))
                
                Button("Начать") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.white)
                .foregroundStyle(.blue)
            }
        }
    }
}
