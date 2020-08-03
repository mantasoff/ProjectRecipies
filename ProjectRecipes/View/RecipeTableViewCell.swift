//
//  RecipeTableViewCell.swift
//  ProjectRecipes
//
//  Created by Mantas Paškevičius on 2020-05-06.
//  Copyright © 2020 Mantas Paškevičius. All rights reserved.
//

import UIKit
import SwipeCellKit

class RecipeTableViewCell: SwipeTableViewCell {
    @IBOutlet weak var recipeNameTextField: UILabel!
    @IBOutlet weak var shortDescriptionTextField: UILabel!
    @IBOutlet weak var minutesToMakeTextField: UILabel!
    
    var recipe: Recipe? {
        didSet {
            recipeNameTextField.text = recipe?.name
            shortDescriptionTextField.text = recipe?.shortDesc
            minutesToMakeTextField.text = "\(recipe?.timeToMake ?? 0) min"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
