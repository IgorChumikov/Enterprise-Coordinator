//
//  AppCoordinatorView.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import SwiftUI
import Combine



extension TabCoordinator where R == ProfileRoute {
    @ViewBuilder func build(_ route: ProfileRoute) -> some View {
        switch route {
        case .settings: SettingsView()
        case .orderHistory: OrderHistoryView()
        case .orderDetail(let id): OrderDetailView(id: id)
        }
    }
}

extension AppCoordinator {
    @ViewBuilder func buildModal(_ modal: AppModal) -> some View {
        switch modal {
        case .login: LoginView()
        case .quickView(let id): QuickView(productId: id)
        }
    }
}

struct ProfileTab: View {
    @EnvironmentObject var app: AppCoordinator
    @ObservedObject var coordinator: TabCoordinator<ProfileRoute>
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            ProfileView(coordinator: coordinator)
                .navigationDestination(for: ProfileRoute.self) { route in
                    coordinator.build(route)
                }
        }
    }
}

struct CartView: View {
    @EnvironmentObject var app: AppCoordinator
    @ObservedObject var coordinator: TabCoordinator<CartRoute>
    
    var body: some View {
        List {
            Button("💳 Оформить заказ") {
                coordinator.push(.checkout)
            }
            
            Section("Отладка") {
                Text("Path count: \(coordinator.path.count)")
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("🛒 Корзина")
    }
}

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

struct CheckoutView: View {
    @EnvironmentObject var app: AppCoordinator
    
    var body: some View {
        VStack(spacing: 20) {
            Text("💳 Оформление заказа")
                .font(.title)
            
            Button("Подтвердить заказ") {
                app.cart.push(.orderConfirmed(id: "12345"))
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Оформление")
    }
}

struct OrderConfirmedView: View {
    let id: String
    var body: some View {
        VStack(spacing: 20) {
            Text("✅")
                .font(.system(size: 80))
            Text("Заказ \(id) подтверждён!")
                .font(.title)
        }
        .navigationTitle("Успех")
    }
}

struct SettingsView: View {
    var body: some View {
        List {
            Section("Аккаунт") {
                Text("Email: user@example.com")
                Text("Имя: Иван Иванов")
            }
            
            Section("Приложение") {
                Toggle("Уведомления", isOn: .constant(true))
                Toggle("Тёмная тема", isOn: .constant(false))
            }
        }
        .navigationTitle("⚙️ Настройки")
    }
}

struct OrderHistoryView: View {
    @EnvironmentObject var app: AppCoordinator
    
    var body: some View {
        List(1...10, id: \.self) { i in
            Button(action: {
                app.profile.push(.orderDetail(id: "\(i)"))
            }) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Заказ #\(i)")
                            .font(.headline)
                        Text("01.12.2024")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    Text("₽\(i * 1000)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle("📋 История заказов")
    }
}

struct OrderDetailView: View {
    let id: String
    
    var body: some View {
        List {
            Section("Информация") {
                Text("Номер заказа: #\(id)")
                Text("Дата: 01.12.2024")
                Text("Статус: Доставлен")
            }
            
            Section("Товары") {
                Text("iPhone 15 Pro")
                Text("AirPods Pro")
            }
        }
        .navigationTitle("Заказ #\(id)")
    }
}

// MARK: - Modals
struct LoginView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("🔐")
                    .font(.system(size: 80))
                Text("Вход в аккаунт")
                    .font(.title)
                
                Button("Закрыть") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Логин")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct QuickView: View {
    let productId: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Text("👁️ Quick View")
                .font(.title)
            Text("Товар: \(productId)")
            
            Button("Закрыть") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
