//
//  ViewController.swift
//  ProjectRecipes
//
//  Created by Mantas Paškevičius on 2020-05-06.
//  Copyright © 2020 Mantas Paškevičius. All rights reserved.
//

import UIKit
import SwipeCellKit

class ViewController: UIViewController {
    @IBOutlet weak var recipeTableView: UITableView!
    let recipeBrain = RecipeBrain()
    var selectedRecipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeTableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: K.cellNames.recipeCellName)
        recipeTableView.dataSource = self
        recipeTableView.delegate = self
        recipeBrain.readRecipes()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segues.recipesToCreate {
            let createRecipeViewController = segue.destination as! CreateRecipeViewController
            createRecipeViewController.recipeBrain = recipeBrain
            createRecipeViewController.onSavedClickCallback = reloadList(with:)
        }
        
        if segue.identifier == K.segues.recipeToView {
            let viewRecipeTableViewControler = segue.destination as! ViewRecipeTableViewController
            if selectedRecipe != nil {
                viewRecipeTableViewControler.recipe = selectedRecipe
            }
        }
    }
    
    func reloadList(with newRecipe: Recipe) {
        recipeTableView.reloadData()
    }
}

//MARK: - ViewController UITableView Extensions

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeBrain.recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellNames.recipeCellName, for: indexPath) as! RecipeTableViewCell
        cell.recipe = recipeBrain.recipes[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRecipe = recipeBrain.recipes[indexPath.row]
        performSegue(withIdentifier: K.segues.recipeToView, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


//MARK: - SwipeTableViewDelegate Extension
extension ViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.recipeBrain.deleteRecipe(self.recipeBrain.recipes[indexPath.row])
            self.recipeTableView.reloadData()
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")
        
        return [deleteAction]
    }
}
