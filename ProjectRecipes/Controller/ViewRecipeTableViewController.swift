//
//  ViewRecipeTableViewController.swift
//  ProjectRecipes
//
//  Created by Mantas Paškevičius on 2020-05-09.
//  Copyright © 2020 Mantas Paškevičius. All rights reserved.
//

import UIKit

class ViewRecipeTableViewController: UITableViewController {
    
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var oneStarImageView: UIImageView!
    @IBOutlet weak var twoStarImageView: UIImageView!
    @IBOutlet weak var threeStarImageView: UIImageView!
    @IBOutlet weak var fourStarImageView: UIImageView!
    @IBOutlet weak var fiveStarImageView: UIImageView!
    
    var recipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "PreparationStepTableViewCell", bundle: nil), forCellReuseIdentifier: K.cellNames.preparationStepCellName)
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = .white
        setTextLabels()
        tableView.rowHeight = 48
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellNames.preparationStepCellName, for: indexPath)
        return cell
    }
    
    //MARK: - View Appearance Functions
    
    private func setStartImages(to difficulty: Int16) {
        switch difficulty {
        case 1..<2:
            oneStarImageView.image = UIImage(systemName: K.images.filledStar)
            twoStarImageView.image = UIImage(systemName: K.images.star)
            threeStarImageView.image = UIImage(systemName: K.images.star)
            fourStarImageView.image = UIImage(systemName: K.images.star)
            fiveStarImageView.image = UIImage(systemName: K.images.star)
        case 2..<3:
            oneStarImageView.image = UIImage(systemName: K.images.filledStar)
            twoStarImageView.image = UIImage(systemName: K.images.filledStar)
            threeStarImageView.image = UIImage(systemName: K.images.star)
            fourStarImageView.image = UIImage(systemName: K.images.star)
            fiveStarImageView.image = UIImage(systemName: K.images.star)
        case 3..<4:
            oneStarImageView.image = UIImage(systemName: K.images.filledStar)
            twoStarImageView.image = UIImage(systemName: K.images.filledStar)
            threeStarImageView.image = UIImage(systemName: K.images.filledStar)
            fourStarImageView.image = UIImage(systemName: K.images.star)
            fiveStarImageView.image = UIImage(systemName: K.images.star)
        case 4..<5:
            oneStarImageView.image = UIImage(systemName: K.images.filledStar)
            twoStarImageView.image = UIImage(systemName: K.images.filledStar)
            threeStarImageView.image = UIImage(systemName: K.images.filledStar)
            fourStarImageView.image = UIImage(systemName: K.images.filledStar)
            fiveStarImageView.image = UIImage(systemName: K.images.star)
        case 5:
            oneStarImageView.image = UIImage(systemName: K.images.filledStar)
            twoStarImageView.image = UIImage(systemName: K.images.filledStar)
            threeStarImageView.image = UIImage(systemName: K.images.filledStar)
            fourStarImageView.image = UIImage(systemName: K.images.filledStar)
            fiveStarImageView.image = UIImage(systemName: K.images.filledStar)
        default:
            oneStarImageView.image = UIImage(systemName: K.images.star)
            twoStarImageView.image = UIImage(systemName: K.images.star)
            threeStarImageView.image = UIImage(systemName: K.images.star)
            fourStarImageView.image = UIImage(systemName: K.images.star)
            fiveStarImageView.image = UIImage(systemName: K.images.star)
        }
    }
    
    private func setTextLabels() {
        if recipe != nil {
            title = recipe?.name
            shortDescriptionLabel.text = recipe?.shortDesc ?? ""
            lengthLabel.text = "\(recipe?.timeToMake ?? 0) min"
            setStartImages(to: recipe?.difficulty ?? 0)
        }
    }

}
