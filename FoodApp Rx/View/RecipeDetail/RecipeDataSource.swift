//
//  RecipeDataSource.swift
//  FoodApp Rx
//
//  Created by Quang Nguyen on 5/14/21.
//

import Foundation
import RxDataSources
import UIKit

enum RecipeSectionModel {
    case recipe(items: [SectionItem])
}

enum SectionItem {
    case image(imageData: Data)
    case about(text: String)
    case ingredients(ingredients: [Ingredient])
}

extension RecipeSectionModel: SectionModelType {
    
    typealias Item = SectionItem
    
    var items: [SectionItem] {
        switch self {
        case .recipe(let items):
            return items.map {$0}
        }
    }
    
    init(original: RecipeSectionModel, items: [Item]) {
        switch original {
        case .recipe:
            self = .recipe(items: items)
        }
    }
}
