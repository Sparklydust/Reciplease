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

  var recipe: Recipe?
  var isFavorited = false
  var recipeMaster = RecipeMaster()
  
  var recipeService: RecipeService

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    self.recipeService = RecipeService(
      managedObjectContext: CoreDataStack.shared.mainContext, coreDataStack: CoreDataStack.shared)
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    self.recipeService = RecipeService(
      managedObjectContext: CoreDataStack.shared.mainContext, coreDataStack: CoreDataStack.shared)
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Reciplease"
    getRecipeInformations(from: recipeMaster)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    wasRecipeFavorited()
    updateRigthBarButton(isFavorited)
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
    likeLabel.text = "\(recipeMaster.rating ?? "0")/5"
    timerLabel.text = "\(Int(recipeMaster.timer!)! / 60)m"
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

  //Check if the recipe was once favorited and saved
  func wasRecipeFavorited() {
    isFavorited = false
    for recipe in recipeService.fetchAllRecipes() {
      if recipe.name == recipeMaster.name {
        isFavorited = true
        break
      }
    }
  }
}

//MARK: - Saving  or unsaving user's favorite recipe with Core Data
extension ShowIngredientsVC {
  func saveToFavorite(_ recipeMaster: RecipeMaster) {
    _ = recipeService.addRecipe(
      name: recipeMaster.name ?? "No name",
      ingredients: recipeMaster.ingredients ?? "No Ingredients to show",
      webURL: recipeMaster.webUrl ?? URL(fileURLWithPath: "no url"),
      timer: String(recipeMaster.timer ?? "0"),
      rating: String(recipeMaster.rating ?? "0"),
      image: recipeMaster.image ?? URL(fileURLWithPath: "no url"),
      calories: recipeMaster.calories ?? 0,
      fat: recipeMaster.fat ?? 0,
      fiber: recipeMaster.fiber ?? 0,
      protein: recipeMaster.protein ?? 0
    )
  }

  func unsavedFromFavorite() {
    for recipe in recipeService.fetchAllRecipes() {
      if recipe.name == recipeMaster.name {
        recipeService.deleteRecipe(recipe)
        self.recipe = nil
      }
    }
  }
}
