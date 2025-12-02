//
//  CategoryView.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import SwiftUI

struct CategoryView: View {
    let name: String
    
    var body: some View {
        List(1...20, id: \.self) { i in
            Text("Товар \(i)")
        }
        .navigationTitle(name)
    }
}
