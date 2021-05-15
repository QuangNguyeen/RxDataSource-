//
//  RecipeListCellViewModel.swift
//  FoodApp Rx
//
//  Created by Quang Nguyen on 5/11/21.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class RecipeListCellViewModel {
    var name: Driver<String>
    var calories: Driver<String>
    var isVegetarian: Driver<Bool>
    var imageData: Driver<Data>
    
    init(withRecipe recipe: Recipe) {
        name = .just(recipe.name)
        calories = .just("Total calories: \(recipe.totalCalories)")
        isVegetarian = .just(recipe.isVegetarian)
        imageData = .just(recipe.image)
    }
}
