//
//  PreparationStepTableViewController.swift
//  ProjectRecipes
//
//  Created by Mantas Paškevičius on 2020-05-10.
//  Copyright © 2020 Mantas Paškevičius. All rights reserved.
//

import UIKit

class PreparationStepTableViewController: UITableViewController {
    
    var recipeBrain: RecipeBrain?
    var recipe: Recipe?
    var preparationSteps: [PreparationStep] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "PreparationStepTableViewCell", bundle: nil), forCellReuseIdentifier: K.cellNames.preparationStepCellName)
        
        if recipeBrain != nil, recipe != nil {
            preparationSteps = recipeBrain!.readPreparationStepsFromRecipe(from: recipe!)
            tableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = .white
        tableView.rowHeight = 48
    }
    
    //MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if preparationSteps.count == 0 {
            return 1
        }
        return preparationSteps.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellNames.preparationStepCellName, for: indexPath) as! PreparationStepTableViewCell
        
        if preparationSteps.count == 0 {
            cell.stepNameLabel.text = "No preparation steps found. 😢"
        } else {
            cell.preparationStep = preparationSteps[indexPath.row]
        }
        
        return cell
    }

    //MARK: - Callback functions
    func onPreparationStepSaved() {
        preparationSteps = recipeBrain!.readPreparationStepsFromRecipe(from: recipe!)
        tableView.reloadData()
    }
    
    //MARK: - Navigation Functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segues.preparationStepViewToCreate {
            let createPreparationStepViewController = segue.destination as! CreatePreparationStepViewController
            createPreparationStepViewController.recipe = recipe
            createPreparationStepViewController.saveCallback = onPreparationStepSaved
            createPreparationStepViewController.recipeBrain = recipeBrain
        }
    }
}
