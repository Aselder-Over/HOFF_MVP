//
//  File.swift
//  HOFF_MVP
//
//  Created by Асельдер on 14.09.2020.
//  Copyright © 2020 Асельдер. All rights reserved.
//

import Foundation

struct MenuItem: Codable {
    
    var items: [Product]
    let relatedCategories: [RelatedCategories]
    let categoryName: String
    
    struct Product: Codable {

        let id, name: String
        let image: String
        var isFavorite: Bool
        let prices: Prices
        let isBestPrice: Bool
        let articul: String
//        let rating: Double?
//        let numberOfReviews: Int
        let statusText: String
    }

    struct Prices: Codable {
        let new, old: Int
    }

    struct RelatedCategories: Codable {
        let name, id : String
    }
}
