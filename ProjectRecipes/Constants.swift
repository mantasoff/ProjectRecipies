//
//  Constants.swift
//  ProjectRecipes
//
//  Created by Mantas Paškevičius on 2020-05-07.
//  Copyright © 2020 Mantas Paškevičius. All rights reserved.
//

import Foundation

struct K {
    struct cellNames {
        static let recipeCellName = "RecipeCellName"
        static let preparationStepCellName = "PreparationStepCellName"
    }
    
    struct segues {
        static let recipesToCreate = "RecipesToCreate"
        static let recipeToView = "RecipeToView"
        static let preparationStepViewToCreate = "preparationStepViewToCreate"
        static let recipeViewToPreparationSteps = "recipeViewToPreparationSteps"
    }
    
    struct images {
        static let star = "star"
        static let filledStar = "star.fill"
    }
    static let preparationStepTypes: [String] = ["Preparation", "Cutting", "Season", "Wait", "Cook", "Boil", "Serve", "Pour", "Add"]
}
