//
//  AppCoordinatorView.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import SwiftUI

struct AppCoordinatorView: View {
    @StateObject private var coordinator = AppCoordinator()
    
    var body: some View {
        TabView(selection: $coordinator.selectedTab) {
            HomeTab(coordinator: coordinator.home)
                .tabItem {
                    Label(AppTab.home.title, systemImage: AppTab.home.icon)
                }
                .tag(AppTab.home)
            
            CatalogTab(coordinator: coordinator.catalog)
                .tabItem {
                    Label(AppTab.catalog.title, systemImage: AppTab.catalog.icon)
                }
                .tag(AppTab.catalog)
            
            CartTab(coordinator: coordinator.cart)
                .tabItem {
                    Label(AppTab.cart.title, systemImage: AppTab.cart.icon)
                }
                .tag(AppTab.cart)
            
            ProfileTab(coordinator: coordinator.profile)
                .tabItem {
                    Label(AppTab.profile.title, systemImage: AppTab.profile.icon)
                }
                .tag(AppTab.profile)
        }
        .environmentObject(coordinator)
        .sheet(item: $coordinator.globalModal) { modal in
            coordinator.buildModal(modal)
        }
        .fullScreenCover(item: $coordinator.globalFullScreenCover) { cover in
                   coordinator.buildFullScreenCover(cover)
               }
    }
}
