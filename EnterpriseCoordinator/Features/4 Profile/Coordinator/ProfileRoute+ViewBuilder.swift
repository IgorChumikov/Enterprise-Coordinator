//
//  ProfileRoute+ViewBuilder.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import Foundation

import SwiftUI

extension TabCoordinator where R == ProfileRoute {
    @ViewBuilder
    func build(_ route: ProfileRoute) -> some View {
        switch route {
        case .settings:
            SettingsView()
        case .orderHistory:
            OrderHistoryView()
        case .orderDetail(let id):
            OrderDetailView(id: id)
        }
    }
}
