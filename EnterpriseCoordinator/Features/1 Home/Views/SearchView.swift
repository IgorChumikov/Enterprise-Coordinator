//
//  SearchView.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import SwiftUI

struct SearchView: View {
    let query: String
    
    var body: some View {
        List(1...10, id: \.self) { i in
            Text("Результат \(i): \(query)")
        }
        .navigationTitle("Поиск: \(query)")
    }
}
