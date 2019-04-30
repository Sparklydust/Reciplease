//
//  SearchRecipeVC.swift
//  Reciplease
//
//  Created by Roland Lariotte on 01/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class ShowIngredientsVC: UIViewController, ShowsAlert {
  
  @IBOutlet weak var recipeImage: UIImageView!
  @IBOutlet weak var likeLabel: UILabel!
  @IBOutlet weak var likeImage: UIImageView!
  @IBOutlet weak var timerLabel: UILabel!
  @IBOutlet weak var timerImage: UIImageView!
  @IBOutlet weak var recipeName: UILabel!
  @IBOutlet weak var recipeIngredients: UITextView!
  
  var isFavorited = false
  var recipe: Recipe?
  let savedRecipes = Recipe.all
  var recipeMaster = RecipeMaster()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateRigthBarButton(isFavorited)
    getRecipeInformations(from: (recipeMaster))
  }
}
  
//MARK: - Exporter Delegation when the button is cliked
extension ShowIngredientsVC {
  @IBAction func stepByStep(_ sender: Any) {
    performSegue(withIdentifier: "showWebVC", sender: recipeMaster)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showWebVC" {
      guard let destinationVC = segue.destination as? StepByStepWebVC else { return }
      guard let recipeMaster = sender as? RecipeMaster else { return }
      destinationVC.recipeMaster = recipeMaster
    }
  }
}

//MARK: - Method to get recipe info before displaying them
extension ShowIngredientsVC {
  
  func getRecipeInformations(from recipeMaster: RecipeMaster) {
    recipeName.text = recipeMaster.name
    recipeIngredients.text = recipeMaster.ingredients
    likeLabel.text = "\(String(describing: recipeMaster.rating))/5"
    timerLabel.text = "\(Int(recipeMaster.timer ?? "0")! / 60)m"
    setRecipeImage(in: recipeImage, from: recipeMaster)
  }
  
  func setRecipeImage(in recipeImage: UIImageView, from recipeMaster: RecipeMaster) {
    if let image = recipeMaster.image {
      recipeImage.downloaded(from: image)
    }
    else {
      recipeImage.image = UIImage(named: "noImage")
    }
  }
}

//MARK: - Setting up the right navigation bar button
extension ShowIngredientsVC {
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
  // Actions for when the star is clicked
  @objc func favoriteDidTap() {
    isFavorited = !isFavorited
    if self.isFavorited {
      saveToFavorite(recipeMaster)
    }
    else {
      unsavedFromFavorite()
    }
    updateRigthBarButton(isFavorited)
  }
}

//MARK: - Saving  or unsaving user's favorite recipe with Core Data
extension ShowIngredientsVC {
  func saveToFavorite(_ recipeMaster: RecipeMaster) {
    if recipe == nil {
      recipe = Recipe(context: AppDelegate.viewContext)
    }
    saveUserRecipe(into: recipe!, from: recipeMaster)
    print(recipe)
  }
  
  func unsavedFromFavorite() {
    guard let recipe = recipe else { return }
    AppDelegate.viewContext.delete(recipe)
    self.recipe = nil
    saveChangesInCoreData(
      unless: "Data could not be unsaved")
  }
  
  // Saving oneRecipe into a Recipe Object
  func saveUserRecipe(into recipe: Recipe, from recipeMaster: RecipeMaster) {
    recipe.name = recipeMaster.name ?? "No name"
    recipe.ingredients = recipeMaster.ingredients ?? "No Ingredients to show"
    recipe.recipeSource = recipeMaster.webUrl
    recipe.cookingTime = String(recipeMaster.timer!)
    recipe.rating = String(recipeMaster.rating!)
    recipe.image = recipeMaster.image
    
    recipe.calories = recipeMaster.calories!
    recipe.fat = recipeMaster.fat!
    recipe.fiber = recipeMaster.fiber!
    recipe.protein = recipeMaster.protein!

    saveChangesInCoreData(
      unless: "This recipe could not be saved!")
  }
  
  // Save to Core Data or show alert
  func saveChangesInCoreData(unless message: String) {
    do {
      try AppDelegate.viewContext.save()
    }
    catch {
      showsAlert(title: "Error", message: message)
      isFavorited = false
    }
  }
}
