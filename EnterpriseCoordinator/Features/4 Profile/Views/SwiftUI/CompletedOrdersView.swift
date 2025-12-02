//
//  CompletedOrdersView.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import SwiftUI

struct CompletedOrdersView: View {
    let orders = Order.completedOrders
    
    var body: some View {
        List(orders) { order in
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Заказ #\(order.id)")
                        .font(.headline)
                    Spacer()
                    Text("✅ \(order.status.rawValue)")
                        .font(.caption)
                        .foregroundStyle(.green)
                }
                
                Text(order.date, style: .date)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text("₽\(Int(order.totalAmount))")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            .padding(.vertical, 4)
        }
        .navigationTitle("✅ Завершенные заказы")
        .navigationBarTitleDisplayMode(.inline)
    }
}
