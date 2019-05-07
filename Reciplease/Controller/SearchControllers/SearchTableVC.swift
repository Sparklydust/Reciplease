//
//  SearchTableVCViewController.swift
//  Reciplease
//
//  Created by Roland Lariotte on 02/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class SearchTableVC: UIViewController, ShowsAlert {
  
  @IBOutlet weak var searchTableView: UITableView!
  
  // Unwind action from StepByStepVC
  @IBAction func unwindToSearch(segue:UIStoryboardSegue) { }
  
  var recipeID = ""
  var customCell = CustomRecipeCell()
  var recipeMaster: RecipeMaster?
  
  var allRecipes: AllRecipesRoot?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Reciplease"
    searchTableView.delegate = self
    searchTableView.dataSource = self
    
    // Register the custom cell
    searchTableView.register(
      UINib(nibName: "CustomRecipeCell", bundle: nil),
      forCellReuseIdentifier: "customRecipeCell")
  }
  
  // To perform a table view animation
  override func viewWillAppear(_ animated: Bool) {
    searchTableView.reloadData(
      with: .simple(duration: 0.75, direction: .rotation3D(
        type: .spiderMan), constantDelay: 0))
  }
}

//MARK: - Exporter Delegation when the button cell is cliked
extension SearchTableVC {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "goToRecipeVC" {
      guard let destinationVC = segue.destination as? ShowIngredientsVC else { return }
      guard let recipeMaster = sender as? RecipeMaster else { return }
      destinationVC.recipeMaster = recipeMaster
    }
  }
}

//MARK: - Configure searchTableView
extension SearchTableVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ((allRecipes?.matches.count)!)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: "customRecipeCell", for: indexPath) as! CustomRecipeCell
    
    getAllRecipesToBeDisplayed(
      into: cell, from: allRecipes, at: indexPath)
    
    return cell
  }
  
  // Action for when the cell is cliked
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let indexOfCell = indexPath.row
    let recipe = allRecipes?.matches[indexOfCell]
    let cell = tableView.cellForRow(at: indexPath)
    let customCell = cell as? CustomRecipeCell
    
    recipeID = (recipe?.id)!
    if recipeID.isEmpty {
      showsAlert(
        title: "Network Error",
        message: "The chosen recipe ID is not valid, please select another one")
    }
    else {
      //API call made at this point
      customCell?.triggerActivityIndicator(true)
      APIsRuler.shared.getRecipe(from: recipeID) {
        [weak self, weak customCell] (success, oneRecipe) in
        customCell?.triggerActivityIndicator(false)
        if success, let oneRecipe = oneRecipe {
          self?.createMasterRecipe(with: oneRecipe)
          self?.performSegue(withIdentifier: "goToRecipeVC", sender: self!.recipeMaster)
        }
      }
    }
  }
}

//MARK: - Setttings the appearance of the cell after networking process
extension SearchTableVC {
  func getAllRecipesToBeDisplayed(into cell: CustomRecipeCell, from allRecipes: AllRecipesRoot?, at indexPath: IndexPath) {
    setRecipeImage(in: cell.cellImage, from: allRecipes, at: indexPath)
    guard let match = allRecipes?.matches[indexPath.row] else { return }
    cell.recipeName.text = match.name
    cell.recipeInfo.text = match.ingredients?.joined(separator: ", ")
    cell.likeLabel.text = "\(match.rating ?? 0)/5"
    cell.timerLabel.text = "\((match.cookingTime ?? 0) / 60)m"
  }
  
  // Method to display the recipe image in HD format
  func setRecipeImage(in recipeImage: UIImageView, from allRecipes: AllRecipesRoot?, at indexPath: IndexPath) {
    if let image = allRecipes?.matches[indexPath.row].image?[0].absoluteString {
      let HDimage = image.replacingOccurrences(of: "=s90", with: "=s360")
      recipeImage.downloaded(from: HDimage)
    }
    else {
      recipeImage.image = UIImage(named: "noImage")
    }
  }
}

//MARK: - Creating the master recipe object to use within controllers
extension SearchTableVC {
  func createMasterRecipe(with oneRecipe: OneRecipeRoot) {
    recipeMaster = RecipeMaster(
      name: oneRecipe.name ?? "no name",
      image: oneRecipe.image?[0].hostedLargeUrl ?? URL(fileURLWithPath: "www.perdu.com"),
      ingredients: oneRecipe.ingredients?.joined(separator: "\n\n") ?? "No Ingredients to show",
      timer: String(oneRecipe.cookingTime ?? 0),
      rating: String(oneRecipe.rating ?? 0),
      webUrl: oneRecipe.recipe?.sourceRecipeUrl ?? URL(fileURLWithPath: "www.perdu.com"),
      calories: oneRecipe.nutrition?.first { $0.attribute == "ENERC_KCAL" }?.value ?? 0,
      fat: oneRecipe.nutrition?.first { $0.attribute == "FAT" }?.value ?? 0,
      fiber: oneRecipe.nutrition?.first { $0.attribute == "PROCNT" }?.value ?? 0,
      protein: oneRecipe.nutrition?.first { $0.attribute == "FIBTG" }?.value ?? 0
    )
  }
}
