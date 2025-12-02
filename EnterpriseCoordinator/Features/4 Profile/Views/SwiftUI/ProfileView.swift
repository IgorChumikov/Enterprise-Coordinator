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
            // ✅ Старые пункты меню (не изменились!)
            Section("Основное") {
                Button("⚙️ Настройки") {
                    coordinator.push(.settings)
                }
                
                Button("📋 История заказов (SwiftUI старый)") {
                    coordinator.push(.orderHistory)
                }
            }
            
            // ✨ НОВЫЕ пункты меню
            Section("Новые экраны") {
                Button("📋 История заказов (UIKit) 🆕") {
                    coordinator.push(.orderHistoryUIKit)
                }
                
                Button("✅ Завершенные заказы (SwiftUI) 🆕") {
                    coordinator.push(.completedOrders)
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
