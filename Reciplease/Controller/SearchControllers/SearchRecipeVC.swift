//
//  SearchRecipeVC.swift
//  Reciplease
//
//  Created by Roland Lariotte on 01/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class SearchRecipeVC: UIViewController, ShowsAlert {

  @IBOutlet weak var recipeImage: UIImageView!
  @IBOutlet weak var likeLabel: UILabel!
  @IBOutlet weak var likeImage: UIImageView!
  @IBOutlet weak var timerLabel: UILabel!
  @IBOutlet weak var timerImage: UIImageView!
  @IBOutlet weak var recipeName: UILabel!
  @IBOutlet weak var recipeIngredients: UITextView!

  var oneRecipe: OneRecipeRoot?
  var isFavorited = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateRigthBarButton(isFavorited)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    getRecipeInformations(from: oneRecipe)
  }
}

//MARK: - Exporter Delegation when the button is cliked
extension SearchRecipeVC {
  @IBAction func stepByStep(_ sender: Any) {
    performSegue(withIdentifier: "showRecipeVC", sender: oneRecipe)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showRecipeVC" {
      guard let destinationVC = segue.destination as? StepByStepWebVC else { return }
      guard let oneRecipe = sender as? OneRecipeRoot else { return }
      destinationVC.oneRecipe = oneRecipe
    }
  }
}

//MARK: - Method to get recipe info before displaying them
extension SearchRecipeVC {
  func getRecipeInformations(from oneRecipe: OneRecipeRoot?) {
    recipeName.text = oneRecipe?.name
    recipeIngredients.text = oneRecipe?.ingredients?.joined(separator: "\n\n ")
    likeLabel.text = "\(String(describing: oneRecipe?.rating))/5"
    timerLabel.text = "\(String(describing: (oneRecipe?.cookingTime!)! / 60))m"
    setRecipeImage(in: recipeImage, from: oneRecipe)
  }

  // Method to display the recipe image
  func setRecipeImage(in recipeImage: UIImageView, from oneRecipe: OneRecipeRoot?) {
    if let image = oneRecipe?.image?[0].hostedLargeUrl {
      recipeImage.downloaded(from: image)
    }
    else {
      recipeImage.image = UIImage(named: "noImage")
    }
  }
}

//MARK: - Setting up the right navigation bar button
extension SearchRecipeVC {
  func updateRigthBarButton(_ isFavorite: Bool) {
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    button.addTarget(self, action: #selector(favoriteDidTap), for: .touchUpInside)
    
    if isFavorite {
      button.setImage(UIImage(named: "savedStar"), for: .normal)
    }
    else {
      button.setImage(UIImage(named: "unsavedStar"), for: .normal)
    }
    let rightButton = UIBarButtonItem(customView: button)
    navigationItem.setRightBarButton(rightButton, animated: true)
  }
  
  @objc func favoriteDidTap() {
    isFavorited = !isFavorited
    if self.isFavorited {
      saveToFavorite()
    }
    else {
      unsavedFromFavorite()
    }
    updateRigthBarButton(isFavorited)
  }
}

//MARK: - Saving  or unsaving user favorite recipe with Core Data
extension SearchRecipeVC {
  func saveToFavorite() {
    
  }
  
  func unsavedFromFavorite() {
    
  }
}
