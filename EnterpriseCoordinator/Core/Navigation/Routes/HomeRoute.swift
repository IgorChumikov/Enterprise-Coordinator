//
//  HomeRoute.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import Foundation

enum HomeRoute: Route {
    case productDetail(id: String)
    case promotions
    case search(query: String)
    
    var id: String {
        switch self {
        case .productDetail(let id): return "product-\(id)"
        case .promotions: return "promotions"
        case .search(let q): return "search-\(q)"
        }
    }
}
