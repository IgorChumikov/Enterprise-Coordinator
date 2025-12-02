//
//  HomeTab.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import SwiftUI

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
                .fullScreenCover(item: $coordinator.fullScreenCover) { cover in
                    app.buildFullScreenCover(cover)
                }
        }
    }
}
