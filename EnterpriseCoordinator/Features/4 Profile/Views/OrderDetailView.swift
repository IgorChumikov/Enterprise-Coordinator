//
//  OrderDetailView.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import SwiftUI

struct OrderDetailView: View {
    let id: String
    
    var body: some View {
        List {
            Section("Информация") {
                Text("Номер заказа: #\(id)")
                Text("Дата: 01.12.2024")
                Text("Статус: Доставлен")
            }
            
            Section("Товары") {
                Text("iPhone 15 Pro")
                Text("AirPods Pro")
            }
        }
        .navigationTitle("Заказ #\(id)")
    }
}
