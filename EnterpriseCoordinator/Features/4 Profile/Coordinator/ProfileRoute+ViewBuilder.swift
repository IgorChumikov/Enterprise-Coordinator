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
                .toolbar(.hidden, for: .tabBar)
            
        case .orderHistory:
            OrderHistoryView()
                .toolbar(.hidden, for: .tabBar)
            
        case .orderDetail(let id):
            OrderDetailView(id: id)
                .toolbar(.hidden, for: .tabBar)
        
        // ✨ НОВЫЕ роуты
        case .orderHistoryUIKit:
            OrderHistoryUIKitAssembly(coordinator: self)
                .toolbar(.hidden, for: .tabBar)
            
        case .orderDetailUIKit(let id):
            OrderDetailUIKitAssembly(coordinator: self, orderId: id)
                .toolbar(.hidden, for: .tabBar)
            
        case .completedOrders:
            CompletedOrdersView()
                .toolbar(.hidden, for: .tabBar)
        }
    }
}
