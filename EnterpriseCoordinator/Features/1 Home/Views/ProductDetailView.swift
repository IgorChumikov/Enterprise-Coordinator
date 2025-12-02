//
//  ProductDetailView.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import SwiftUI

struct ProductDetailView: View {
    let id: String
    @EnvironmentObject var app: AppCoordinator
    
    var body: some View {
        VStack(spacing: 20) {
            Text("📦 Товар #\(id)")
                .font(.title)
            
            Button("🛒 В корзину и перейти") {
                app.showCart()
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Товар \(id)")
        .navigationBarTitleDisplayMode(.inline)
    }
}
