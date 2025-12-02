//
//  OrderHistoryUIKitAssembly.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import SwiftUI

struct OrderHistoryUIKitAssembly: UIViewControllerRepresentable {
    let coordinator: TabCoordinator<ProfileRoute>
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = OrderHistoryUIKitViewController()
        viewController.coordinator = coordinator
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Update if needed
    }
}
