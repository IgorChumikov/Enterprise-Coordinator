//
//  Order.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import Foundation

struct Order: Identifiable {
    let id: String
    let date: Date
    let totalAmount: Double
    let status: OrderStatus
    let items: [OrderItem]
    
    enum OrderStatus: String {
        case pending = "В обработке"
        case completed = "Доставлен"
        case cancelled = "Отменён"
    }
}

struct OrderItem: Identifiable {
    let id: String
    let name: String
    let price: Double
    let quantity: Int
}

// Mock данные для примера
extension Order {
    static var mockOrders: [Order] {
        (1...10).map { i in
            Order(
                id: "\(i)",
                date: Date().addingTimeInterval(-TimeInterval(i * 86400)),
                totalAmount: Double(i * 1000),
                status: i % 3 == 0 ? .completed : (i % 2 == 0 ? .pending : .cancelled),
                items: [
                    OrderItem(id: "1", name: "iPhone 15 Pro", price: 89990, quantity: 1),
                    OrderItem(id: "2", name: "AirPods Pro", price: 24990, quantity: 1)
                ]
            )
        }
    }
    
    static var completedOrders: [Order] {
        mockOrders.filter { $0.status == .completed }
    }
}
