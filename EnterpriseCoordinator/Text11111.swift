//
//  AppCoordinatorView.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import SwiftUI
import Combine


extension TabCoordinator where R == CatalogRoute {
    @ViewBuilder func build(_ route: CatalogRoute) -> some View {
        switch route {
        case .category(_, let name): CategoryView(name: name)
        case .productDetail(let id): ProductDetailView(id: id)
        case .filters: FiltersView()
        }
    }
}

extension TabCoordinator where R == CartRoute {
    @ViewBuilder func build(_ route: CartRoute) -> some View {
        switch route {
        case .checkout: CheckoutView()
        case .orderConfirmed(let id): OrderConfirmedView(id: id)
        }
    }
}

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


struct CatalogTab: View {
    @EnvironmentObject var app: AppCoordinator
    @ObservedObject var coordinator: TabCoordinator<CatalogRoute>
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            CatalogView(coordinator: coordinator)
                .navigationDestination(for: CatalogRoute.self) { route in
                    coordinator.build(route)
                }
                .sheet(item: $coordinator.sheet) { modal in
                    app.buildModal(modal)
                }
        }
    }
}

struct CartTab: View {
    @EnvironmentObject var app: AppCoordinator
    @ObservedObject var coordinator: TabCoordinator<CartRoute>
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            CartView(coordinator: coordinator)
                .navigationDestination(for: CartRoute.self) { route in
                    coordinator.build(route)
                }
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

// MARK: - Screens
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

struct CatalogView: View {
    @EnvironmentObject var app: AppCoordinator
    @ObservedObject var coordinator: TabCoordinator<CatalogRoute>
    
    var body: some View {
        List {
            Section("Категории") {
                Button("📱 Смартфоны") {
                    coordinator.push(.category(id: "1", name: "Смартфоны"))
                }
                Button("📦 Товар 789") {
                    coordinator.push(.productDetail(id: "789"))
                }
                Button("🎚️ Фильтры") {
                    coordinator.push(.filters)
                }
            }
            
            Section("Отладка") {
                Text("Path count: \(coordinator.path.count)")
                    .foregroundStyle(.secondary)
                if coordinator.path.count > 0 {
                    Button("Pop to Root") { coordinator.popToRoot() }
                }
            }
        }
        .navigationTitle("📚 Каталог")
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

// MARK: - Detail Views
struct ProductDetailView: View {
    let id: String
    @EnvironmentObject var app: AppCoordinator
    
    var body: some View {
        VStack(spacing: 20) {
            Text("📦 Товар #\(id)")
                .font(.title)
            
            Button("🛒 В корзину и перейти") {
                app.showCart()
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Товар \(id)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PromotionsView: View {
    var body: some View {
        Text("🎉 Акции и скидки")
            .font(.title)
            .navigationTitle("Акции")
    }
}

struct SearchView: View {
    let query: String
    var body: some View {
        List(1...10, id: \.self) { i in
            Text("Результат \(i): \(query)")
        }
        .navigationTitle("Поиск: \(query)")
    }
}

struct CategoryView: View {
    let name: String
    var body: some View {
        List(1...20, id: \.self) { i in
            Text("Товар \(i)")
        }
        .navigationTitle(name)
    }
}

struct FiltersView: View {
    var body: some View {
        Text("🎚️ Настройка фильтров")
            .font(.title)
            .navigationTitle("Фильтры")
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
