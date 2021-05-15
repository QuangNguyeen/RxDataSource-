//
//  RecipeService.swift
//  FoodApp Rx
//
//  Created by Quang Nguyen on 5/11/21.
//

import Foundation
import UIKit


class RecipeService {
    static let chickenPasta = Recipe(name: "Chicken Pasta",
                                     ingredients: [IngredientService.chickenBreast,
                                                   IngredientService.pasta,
                                                   IngredientService.garlic,
                                                   IngredientService.parsley],
                                     totalCalories: 450,
                                     image: #imageLiteral(resourceName: "chickenPasta").jpegData(compressionQuality: 0.95) ?? Data())
    
    static let baconRice = Recipe(name: "Rice with bacon",
                                  ingredients: [IngredientService.bacon,
                                                IngredientService.rice,
                                                IngredientService.pepper],
                                  totalCalories: 490,
                                  image: #imageLiteral(resourceName: "baconRice").jpegData(compressionQuality: 0.95) ?? Data())
    
    static let eggPorkRice = Recipe(name: "Rice with pork and eggs",
                                    ingredients: [IngredientService.pork,
                                                  IngredientService.rice,
                                                  IngredientService.eggs,
                                                  IngredientService.parsley],
                                    totalCalories: 540,
                                    image: #imageLiteral(resourceName: "eggPorkRice").jpegData(compressionQuality: 0.95) ?? Data())
}
