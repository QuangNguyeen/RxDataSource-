//
//  RecipeViewModel.swift
//  FoodApp Rx
//
//  Created by Quang Nguyen on 5/14/21.
//

import Foundation
import RxSwift
import RxCocoa

class RecipeViewModel {
    
    let bag = DisposeBag()
    
    var dataSource: Driver<Recipe>
    var sectionModels: Driver<[RecipeSectionModel]> = .just([])
    
    init(withRecipe recipe: Recipe) {
        dataSource = .just(recipe)
    }
}

extension RecipeViewModel {
    
    func initSectionModel(withRecipe recipe: Recipe) {
        sectionModels = .just(setupSections(recipe: recipe))
    }
    
    func setupSections(recipe: Recipe) -> [RecipeSectionModel] {
        let dataSource: [RecipeSectionModel] = [
            .recipe(items: [
                .image(imageData: recipe.image),
                .about(text: "Total calories: \(recipe.totalCalories)"),
                .about(text: isVegetarianCell(recipe.isVegetarian)),
                .ingredients(ingredients: recipe.ingredients)
            ])
        ]
        return dataSource
    }
    
    func isVegetarianCell(_ isVegetarian: Bool) -> String {
        if isVegetarian {
            return "Vegetarian recipe"
        } else {
            return "Non-Vegetarian recipe"
        }
    }
}
