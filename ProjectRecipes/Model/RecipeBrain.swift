//
//  RecipeBrain.swift
//  ProjectRecipes
//
//  Created by Mantas Paškevičius on 2020-05-06.
//  Copyright © 2020 Mantas Paškevičius. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class RecipeBrain {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var recipes: [Recipe] = []
    var preparationSteps: [PreparationStep] = []
    
    func saveRecipe(from newRecipe: Recipe? = nil) {
        do {
            if let safeRecipe = newRecipe {
                self.recipes.append(safeRecipe)
            }
            try context.save()
        } catch {
            print("Error when saving recipe: \(error)")
        }
    }
    
    func readRecipes(with request: NSFetchRequest<Recipe> = Recipe.fetchRequest()) {
        do {
            self.recipes = try context.fetch(request)
        } catch {
            print("Error when reading recipes: \(error)")
        }
    }
    
    func createRecipe() -> Recipe {
        let newRecipe = Recipe(context: context)
        newRecipe.id = UUID().uuidString
        return newRecipe
    }
    
    func deleteRecipe(_ recipeToRemove: Recipe) {
        recipes = recipes.filter({ (recipe) -> Bool in
            if recipe.id == recipeToRemove.id {
                return false
            }
            return true
        })
        context.delete(recipeToRemove)
        saveRecipe()
    }
    
    func createPreparationStep(from recipe: Recipe) -> PreparationStep {
        let newPreparationStep = PreparationStep(context: context);
        let lastRecipePreparationNo = getRecipesLastPreparationStepNo(from: recipe)
        newPreparationStep.no = Int16(lastRecipePreparationNo + 1)
        newPreparationStep.parentRecipe = recipe
        return newPreparationStep
    }
    
    func getRecipesLastPreparationStepNo(from recipe: Recipe) -> Int{
        let request: NSFetchRequest<PreparationStep> = PreparationStep.fetchRequest()
        request.predicate = NSPredicate(format: "parentRecipe.id MATCHES %@", String(recipe.id!))
        var preparationSteps: [PreparationStep] = []
        
        do {
            preparationSteps = try context.fetch(request)
        } catch {
            print("Error when fetching recipe requests: \(error)")
        }
        
        var largestNo = 0
        preparationSteps.forEach { (preparationStep) in
            if preparationStep.no > largestNo {
                largestNo = Int(preparationStep.no)
            }
        }
        
        return largestNo
    }
    
    func savePreparationStep(_ newPreparationStep: PreparationStep? = nil, saveContext: Bool) {
        do {
            if newPreparationStep != nil {
                preparationSteps.append(newPreparationStep!)
            }
            if saveContext {
               try context.save()
            }
        } catch {
            print("Error when fetching preparation steps: \(error)")
        }
    }
    
    func readPreparationStepsFromRecipe(from recipe: Recipe) -> [PreparationStep] {
        let request: NSFetchRequest<PreparationStep> = PreparationStep.fetchRequest()
        request.predicate = NSPredicate(format: "parentRecipe.id MATCHES %@", recipe.id!)
        do {
             preparationSteps = try context.fetch(request)
        } catch {
            print("Error when fetching preparation steps: \(error)")
        }
        
        return preparationSteps
    }
    
    func revertCoreDataChanges() {
        context.undo()
    }
}
