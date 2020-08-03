//
//  CreateRecipeViewController.swift
//  ProjectRecipes
//
//  Created by Mantas Paškevičius on 2020-05-07.
//  Copyright © 2020 Mantas Paškevičius. All rights reserved.
//

import UIKit

class CreateRecipeViewController: UIViewController {
    
    var recipeBrain: RecipeBrain?
    var newRecipe: Recipe? {
        didSet {
            nameTextField.text = newRecipe?.name
            minutesTextField.text = "\(newRecipe?.timeToMake ?? 0)"
            difficultySlider.value = Float(newRecipe?.difficulty ?? 0)
            shortDescriptionTextField.text = newRecipe?.shortDesc
        }
    }
    var onSavedClickCallback: ((_ newRecipe: Recipe) -> ())?
    var saved: Bool = false
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var minutesTextField: UITextField!
    @IBOutlet weak var difficultySlider: UISlider!
    @IBOutlet weak var shortDescriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if recipeBrain == nil {
            recipeBrain = RecipeBrain()
        }
        
        if newRecipe == nil {
            newRecipe = recipeBrain?.createRecipe()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if !saved {
            recipeBrain?.revertCoreDataChanges()
        }
    }
    
    
    //MARK: - Action
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if let name = nameTextField.text, let minutes = Int16(minutesTextField.text!), let shortDescription = shortDescriptionTextField.text {
            
            newRecipe?.name = name
            newRecipe?.timeToMake = minutes
            newRecipe?.shortDesc = shortDescription
            newRecipe?.difficulty = Int16(difficultySlider.value)
            recipeBrain?.saveRecipe(from: newRecipe!)
            if onSavedClickCallback != nil, newRecipe != nil {
                onSavedClickCallback!(newRecipe!)
            }
            saved = true
            navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: - Navigation Functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segues.recipeViewToPreparationSteps {
            let preparationStepTableViewController = segue.destination as! PreparationStepTableViewController
            preparationStepTableViewController.recipe = newRecipe
            preparationStepTableViewController.recipeBrain = recipeBrain
        }
    }

}
