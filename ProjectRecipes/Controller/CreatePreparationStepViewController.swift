//
//  CreatePreparationStepViewController.swift
//  ProjectRecipes
//
//  Created by Mantas Paškevičius on 2020-05-10.
//  Copyright © 2020 Mantas Paškevičius. All rights reserved.
//

import UIKit

class CreatePreparationStepViewController: UIViewController {
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var ingredientsTextField: UITextField!
    
    var recipe: Recipe?
    var preparationStep: PreparationStep?
    var saveCallback: (() -> ())?
    var recipeBrain: RecipeBrain?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = .white
    }

    
    //MARK: - Actions
    @IBAction func onSavePressed(_ sender: Any) {
        if recipeBrain != nil, let type = typeTextField.text, let name = nameTextField.text, let description = descriptionTextField.text, let ingredients = ingredientsTextField.text {
            var isNewPreparationStep = false
            if preparationStep == nil, recipe != nil {
                preparationStep = recipeBrain?.createPreparationStep(from: recipe!)
                isNewPreparationStep = true
            }
            preparationStep?.stepDescription = description
            preparationStep?.stepName = name
            preparationStep?.type = type
            preparationStep?.ingredients = ingredients
            
            if isNewPreparationStep {
                recipeBrain?.savePreparationStep(preparationStep, saveContext: false)
            } else {
                recipeBrain?.savePreparationStep(saveContext: false)
            }
            
            if saveCallback != nil {
                saveCallback!()
            }
            
            navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: - Appearance Functions
    
    private func setTextFields() {
        if let safePreparationStep = preparationStep{
            typeTextField.text = safePreparationStep.type
            nameTextField.text = safePreparationStep.stepName
            descriptionTextField.text = safePreparationStep.stepDescription
            ingredientsTextField.text = safePreparationStep.ingredients
        }
    }
}
