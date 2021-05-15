//
//  Recipe.swift
//  FoodApp Rx
//
//  Created by Quang Nguyen on 5/11/21.
//

import Foundation
import RxDataSources

struct Recipe: Codable {
    var name: String
    var ingredients: [Ingredient]
    var totalCalories: Int
    var image: Data
    var isVegetarian: Bool {
        return !ingredients.contains { $0.isVegetarian == false }
    }
}

extension Recipe: Hashable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.name == rhs.name &&
            lhs.ingredients == rhs.ingredients &&
            lhs.totalCalories == rhs.totalCalories &&
            lhs.image == rhs.image &&
            lhs.isVegetarian == rhs.isVegetarian
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(ingredients)
        hasher.combine(totalCalories)
        hasher.combine(image)
        hasher.combine(isVegetarian)
    }
    
}

extension Recipe: IdentifiableType {
    var identity: String {
        return self.name
    }
    
    typealias identity = String
}

