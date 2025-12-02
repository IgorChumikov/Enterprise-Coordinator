//
//  TabCoordinator.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import SwiftUI
import Combine

// MARK: - Generic Tab Coordinator
final class TabCoordinator<R: Route>: ObservableObject {
    @Published var path = NavigationPath()
    @Published var sheet: AppModal?
    
    func push(_ route: R) { path.append(route) }
    func pop() { if !path.isEmpty { path.removeLast() } }
    func popToRoot() { path.removeLast(path.count) }
    func presentSheet(_ sheet: AppModal) { self.sheet = sheet }
    func dismissSheet() { sheet = nil }
}

// MARK: - Main App Coordinator
final class AppCoordinator: ObservableObject {
    @Published var selectedTab: AppTab = .home
    
    var home = TabCoordinator<HomeRoute>()
    var catalog = TabCoordinator<CatalogRoute>()
    var cart = TabCoordinator<CartRoute>()
    var profile = TabCoordinator<ProfileRoute>()
    
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
