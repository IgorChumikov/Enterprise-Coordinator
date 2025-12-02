//
//  HomeView.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var app: AppCoordinator
    @ObservedObject var coordinator: TabCoordinator<HomeRoute>
    
    var body: some View {
        List {
            Section("Навигация") {
                Button("📦 Товар 123") {
                    coordinator.push(.productDetail(id: "123"))
                }
                Button("🎉 Акции") {
                    coordinator.push(.promotions)
                }
                Button("🔍 Поиск iPhone") {
                    coordinator.push(.search(query: "iPhone"))
                }
            }
            
            Section("Модалки") {
                Button("📄 Quick View 456") {
                    coordinator.presentSheet(.quickView(productId: "456"))
                }
                Button("🔐 Глобальный логин") {
                    app.showGlobalModal(.login)
                }
            }
            
            Section("Межтабовая навигация") {
                Button("🛒 Перейти в корзину") {
                    app.showCart()
                }
                Button("📱 Deep link → Товар 999") {
                    app.showProduct(id: "999")
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
        .navigationTitle("🏠 Главная")
    }
}
