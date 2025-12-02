//
//  ProfileRoute.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import Foundation

enum ProfileRoute: Route {
    // ✅ Старые роуты (не трогаем!)
    case settings
    case orderHistory
    case orderDetail(id: String)
    
    // ✨ НОВЫЕ роуты для UIKit и SwiftUI
    case orderHistoryUIKit              // UIKit список заказов
    case orderDetailUIKit(id: String)   // UIKit детали заказа
    case completedOrders                // SwiftUI завершенные заказы
    
    var id: String {
        switch self {
        // Старые
        case .settings: return "settings"
        case .orderHistory: return "history"
        case .orderDetail(let id): return "order-\(id)"
        
        // Новые
        case .orderHistoryUIKit: return "order-history-uikit"
        case .orderDetailUIKit(let id): return "order-detail-uikit-\(id)"
        case .completedOrders: return "completed-orders"
        }
    }
}
