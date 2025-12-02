//
//  OrderHistoryView.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import SwiftUI

struct OrderHistoryView: View {
    @EnvironmentObject var app: AppCoordinator
    
    var body: some View {
        List(1...10, id: \.self) { i in
            Button(action: {
                app.profile.push(.orderDetail(id: "\(i)"))
            }) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Заказ #\(i)")
                            .font(.headline)
                        Text("01.12.2024")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    Text("₽\(i * 1000)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle("📋 История заказов")
    }
}
