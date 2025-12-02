//
//  AppTab.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import Foundation

enum AppTab: String, CaseIterable, Identifiable {
    case home, catalog, cart, profile
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .home: return "Главная"
        case .catalog: return "Каталог"
        case .cart: return "Корзина"
        case .profile: return "Профиль"
        }
    }
    
    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .catalog: return "square.grid.2x2.fill"
        case .cart: return "cart.fill"
        case .profile: return "person.fill"
        }
    }
}
