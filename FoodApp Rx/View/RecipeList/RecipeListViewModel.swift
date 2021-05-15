//
//  RecipeListViewModel.swift
//  FoodApp Rx
//
//  Created by Quang Nguyen on 5/11/21.
//

import Foundation
import RxSwift
import RxCocoa

class RecipeListViewModel {
    var dataSource = BehaviorRelay<[Recipe]>(value: [])
    
    private let defaultRecipe = [RecipeService.chickenPasta,
                                 RecipeService.baconRice,
                                 RecipeService.eggPorkRice]
    
    init(withRecipes recipes: [Recipe]) {
        if recipes.isEmpty {
            dataSource.accept(defaultRecipe)
        } else {
            dataSource.accept(recipes)
        }
    }
}
