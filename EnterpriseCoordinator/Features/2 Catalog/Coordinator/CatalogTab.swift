//
//  CatalogTab.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import SwiftUI

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
