//
//  AppCoordinatorView.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import SwiftUI
import Combine

//  ContentView.swift (единственный файл проекта)
//  TabCoordinatorApp – ПРАВИЛЬНО работающая версия
//  Работает на iOS 17+

// MARK: - Tabs
enum AppTab: String, CaseIterable, Identifiable {
    case home, catalog, cart, profile
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .home: "Главная"
        case .catalog: "Каталог"
        case .cart: "Корзина"
        case .profile: "Профиль"
        }
    }
    
    var icon: String {
        switch self {
        case .home: "house.fill"
        case .catalog: "square.grid.2x2.fill"
        case .cart: "cart.fill"
        case .profile: "person.fill"
        }
    }
}

// MARK: - Type-Safe Routes
protocol Route: Hashable, Identifiable {
    var id: String { get }
}

enum HomeRoute: Route {
    case productDetail(id: String)
    case promotions
    case search(query: String)
    
    var id: String {
        switch self {
        case .productDetail(let id): "product-\(id)"
        case .promotions: "promotions"
        case .search(let q): "search-\(q)"
        }
    }
}

enum CatalogRoute: Route {
    case category(id: String, name: String)
    case productDetail(id: String)
    case filters
    
    var id: String {
        switch self {
        case .category(let id, _): "cat-\(id)"
        case .productDetail(let id): "product-\(id)"
        case .filters: "filters"
        }
    }
}

enum CartRoute: Route {
    case checkout
    case orderConfirmed(id: String)
    
    var id: String {
        switch self {
        case .checkout: "checkout"
        case .orderConfirmed(let id): "confirmed-\(id)"
        }
    }
}

enum ProfileRoute: Route {
    case settings
    case orderHistory
    case orderDetail(id: String)
    
    var id: String {
        switch self {
        case .settings: "settings"
        case .orderHistory: "history"
        case .orderDetail(let id): "order-\(id)"
        }
    }
}

// MARK: - Modals
enum AppModal: Identifiable {
    case login
    case quickView(productId: String)
    
    var id: String {
        switch self {
        case .login: "login"
        case .quickView(let id): "quick-\(id)"
        }
    }
}

// MARK: - Generic Tab Coordinator
final class TabCoordinator<R: Route>: ObservableObject {
    @Published var path = NavigationPath()
    @Published var sheet: AppModal?
    
    func push(_ route: R) {
        path.append(route)
    }
    
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func presentSheet(_ sheet: AppModal) { self.sheet = sheet }
    func dismissSheet() { sheet = nil }
}

// MARK: - Main App Coordinator
final class AppCoordinator: ObservableObject {
    @Published var selectedTab: AppTab = .home
    
    // Каждая вкладка имеет СВОЙ координатор
    let home = TabCoordinator<HomeRoute>()
    let catalog = TabCoordinator<CatalogRoute>()
    let cart = TabCoordinator<CartRoute>()
    let profile = TabCoordinator<ProfileRoute>()
    
    @Published var globalModal: AppModal?
    
    func showProduct(id: String) {
        selectedTab = .home
        home.popToRoot()
        home.push(.productDetail(id: id))
    }
    
    func showCart() {
        selectedTab = .cart
    }
    
    func showGlobalModal(_ modal: AppModal) {
        globalModal = modal
    }
}

// MARK: - View Builders
extension TabCoordinator where R == HomeRoute {
    @ViewBuilder func build(_ route: HomeRoute) -> some View {
        switch route {
        case .productDetail(let id): ProductDetailView(id: id)
        case .promotions: PromotionsView()
        case .search(let q): SearchView(query: q)
        }
    }
}

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

// MARK: - Main Coordinator View
struct AppCoordinatorView: View {
    @StateObject private var coordinator = AppCoordinator()
    
    var body: some View {
        TabView(selection: $coordinator.selectedTab) {
            HomeTab(coordinator: coordinator.home)
                .tabItem { Label(AppTab.home.title, systemImage: AppTab.home.icon) }
                .tag(AppTab.home)
            
            CatalogTab(coordinator: coordinator.catalog)
                .tabItem { Label(AppTab.catalog.title, systemImage: AppTab.catalog.icon) }
                .tag(AppTab.catalog)
            
            CartTab(coordinator: coordinator.cart)
                .tabItem { Label(AppTab.cart.title, systemImage: AppTab.cart.icon) }
                .tag(AppTab.cart)
            
            ProfileTab(coordinator: coordinator.profile)
                .tabItem { Label(AppTab.profile.title, systemImage: AppTab.profile.icon) }
                .tag(AppTab.profile)
        }
        .environmentObject(coordinator)
        .sheet(item: $coordinator.globalModal) { coordinator.buildModal($0) }
    }
}

// MARK: - Tab Contents
struct HomeTab: View {
    @EnvironmentObject var app: AppCoordinator
    @ObservedObject var coordinator: TabCoordinator<HomeRoute>
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            HomeView(coordinator: coordinator)
                .navigationDestination(for: HomeRoute.self) { route in
                    coordinator.build(route)
                }
                .sheet(item: $coordinator.sheet) { modal in
                    app.buildModal(modal)
                }
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
