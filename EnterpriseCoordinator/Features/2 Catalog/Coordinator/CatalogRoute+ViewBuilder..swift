//
//  CatalogRoute+ViewBuilder..swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import SwiftUI

import SwiftUI

extension TabCoordinator where R == CatalogRoute {
    @ViewBuilder
    func build(_ route: CatalogRoute) -> some View {
        switch route {
        case .category(_, let name):
            CategoryView(name: name)
        case .productDetail(let id):
            ProductDetailView(id: id)
        case .filters:
            FiltersView()
        }
    }
}
