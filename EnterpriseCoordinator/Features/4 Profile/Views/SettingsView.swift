//
//  SettingsView.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            Section("Аккаунт") {
                Text("Email: user@example.com")
                Text("Имя: Иван Иванов")
            }
            
            Section("Приложение") {
                Toggle("Уведомления", isOn: .constant(true))
                Toggle("Тёмная тема", isOn: .constant(false))
            }
        }
        .navigationTitle("⚙️ Настройки")
    }
}
