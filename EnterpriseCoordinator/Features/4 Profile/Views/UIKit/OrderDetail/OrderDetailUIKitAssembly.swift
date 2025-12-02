//
//  OrderDetailUIKitAssembly.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import SwiftUI

struct OrderDetailUIKitAssembly: UIViewControllerRepresentable {
    let coordinator: TabCoordinator<ProfileRoute>
    let orderId: String
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = OrderDetailUIKitViewController()
        viewController.coordinator = coordinator
        viewController.orderId = orderId
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Update if needed
    }
}
