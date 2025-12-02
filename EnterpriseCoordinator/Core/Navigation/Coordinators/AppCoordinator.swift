//
//  AppCoordinator.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import SwiftUI
import Combine

final class AppCoordinator: ObservableObject {
    @Published var selectedTab: AppTab = .home
    
    // Координаторы для каждой вкладки
    let home = TabCoordinator<HomeRoute>()
    let catalog = TabCoordinator<CatalogRoute>()
    let cart = TabCoordinator<CartRoute>()
    let profile = TabCoordinator<ProfileRoute>()
    
    // Глобальные модалки
    @Published var globalModal: AppModal?
    
    // MARK: - Межтабовая навигация
    
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
