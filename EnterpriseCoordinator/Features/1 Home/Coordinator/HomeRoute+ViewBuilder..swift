//
//  HomeRoute+ViewBuilder..swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import SwiftUI

extension TabCoordinator where R == HomeRoute {
    @ViewBuilder
    func build(_ route: HomeRoute) -> some View {
        switch route {
        case .productDetail(let id):
            ProductDetailView(id: id)
        case .promotions:
            PromotionsView()
        case .search(let q):
            SearchView(query: q)
        }
    }
}
