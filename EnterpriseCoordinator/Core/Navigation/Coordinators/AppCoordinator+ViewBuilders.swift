//
//  AppCoordinator+ViewBuilders.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import SwiftUI

// MARK: - Modal Builders
extension AppCoordinator {
    @ViewBuilder
    func buildModal(_ modal: AppModal) -> some View {
        switch modal {
        case .login:
            LoginView()
        case .quickView(let id):
            QuickView(productId: id)
        }
    }
    
    // ✨ Full Screen Cover Builder
    @ViewBuilder
    func buildFullScreenCover(_ cover: AppFullScreenCover) -> some View {
        switch cover {
        case .onboarding:
            OnboardingView()
        case .camera:
            CameraView()
        case .videoPlayer(let url):
            VideoPlayerView(url: url)
        }
    }
}
