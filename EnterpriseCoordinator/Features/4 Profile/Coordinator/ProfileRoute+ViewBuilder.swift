//
//  ProfileRoute+ViewBuilder.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import SwiftUI

extension TabCoordinator where R == ProfileRoute {
    @ViewBuilder
    func build(_ route: ProfileRoute) -> some View {
        switch route {
        // ✅ Старые роуты (работают как раньше!)
        case .settings:
            SettingsView()
            
        case .orderHistory:
            OrderHistoryView()
            
        case .orderDetail(let id):
            OrderDetailView(id: id)
        
        // ✨ НОВЫЕ роуты
        case .orderHistoryUIKit:
            OrderHistoryUIKitAssembly(coordinator: self)
            
        case .orderDetailUIKit(let id):
            OrderDetailUIKitAssembly(coordinator: self, orderId: id)
            
        case .completedOrders:
            CompletedOrdersView()
        }
    }
}
