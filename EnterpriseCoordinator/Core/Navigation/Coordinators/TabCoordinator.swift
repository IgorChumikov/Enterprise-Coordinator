//
//  TabCoordinator.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import SwiftUI
import Combine

final class TabCoordinator<R: Route>: ObservableObject {
    @Published var path = NavigationPath()
    @Published var sheet: AppModal?
    
    func push(_ route: R) {
        path.append(route)
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func presentSheet(_ sheet: AppModal) {
        self.sheet = sheet
    }
    
    func dismissSheet() {
        sheet = nil
    }
}
