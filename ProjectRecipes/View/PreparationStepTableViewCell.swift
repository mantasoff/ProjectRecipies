//
//  PreparationStepTableViewCell.swift
//  ProjectRecipes
//
//  Created by Mantas Paškevičius on 2020-05-10.
//  Copyright © 2020 Mantas Paškevičius. All rights reserved.
//

import UIKit

class PreparationStepTableViewCell: UITableViewCell {
    @IBOutlet weak var stepNameLabel: UILabel!
    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var clockImageView: UIImageView!
    @IBOutlet weak var minLabel: UILabel!
    var preparationStep: PreparationStep? {
        didSet {
            if preparationStep != nil {
                stepNameLabel.text = preparationStep?.stepName

            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        minLabel.isHidden = false
        clockImageView.isHidden = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
