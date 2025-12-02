//
//  ProfileView.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var app: AppCoordinator
    @ObservedObject var coordinator: TabCoordinator<ProfileRoute>
    
    var body: some View {
        List {
            Section("Меню") {
                Button("⚙️ Настройки") {
                    coordinator.push(.settings)
                }
                Button("📋 История заказов") {
                    coordinator.push(.orderHistory)
                }
            }
            
            Section("Отладка") {
                Text("Path count: \(coordinator.path.count)")
                    .foregroundStyle(.secondary)
                if coordinator.path.count > 0 {
                    Button("⬅️ Pop") { coordinator.pop() }
                    Button("🏠 Pop to Root") { coordinator.popToRoot() }
                }
            }
        }
        .navigationTitle("👤 Профиль")
    }
}
