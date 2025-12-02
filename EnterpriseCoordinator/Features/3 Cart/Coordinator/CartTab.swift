//
//  CartTab.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import SwiftUI

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
