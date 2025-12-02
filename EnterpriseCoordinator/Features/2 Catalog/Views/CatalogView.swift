//
//  CatalogView.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import SwiftUI

struct CatalogView: View {
    @EnvironmentObject var app: AppCoordinator
    @ObservedObject var coordinator: TabCoordinator<CatalogRoute>
    
    var body: some View {
        List {
            Section("Категории") {
                Button("📱 Смартфоны") {
                    coordinator.push(.category(id: "1", name: "Смартфоны"))
                }
                Button("📦 Товар 789") {
                    coordinator.push(.productDetail(id: "789"))
                }
                Button("🎚️ Фильтры") {
                    coordinator.push(.filters)
                }
            }
            
            Section("Отладка") {
                Text("Path count: \(coordinator.path.count)")
                    .foregroundStyle(.secondary)
                if coordinator.path.count > 0 {
                    Button("Pop to Root") { coordinator.popToRoot() }
                }
            }
        }
        .navigationTitle("📚 Каталог")
    }
}
