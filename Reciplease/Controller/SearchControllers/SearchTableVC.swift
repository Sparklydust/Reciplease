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
  var allRecipes: AllRecipesRoot?
  
  override func viewDidLoad() {
    super.viewDidLoad()
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
extension SearchTableVC: CustomRecipeCellDelegate {
  func cellIsClicked(index: Int) {
    recipeID = (allRecipes?.matches[index].id)!
    
    if recipeID.isEmpty {
      showsAlert(
        title: "Network Error",
        message: "The chosen recipe ID is not valid, please select another one")
    }
    else {
      //API call made at this point
      APIsRuler.shared.getRecipe(from: recipeID) {
        (success, oneRecipe) in
        if success, let oneRecipe = oneRecipe {
          self.performSegue(withIdentifier: "goToRecipeVC", sender: oneRecipe)
        }
      }
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "goToRecipeVC" {
      guard  let destinationVC = segue.destination as? SearchRecipeVC else { return }
      guard let oneRecipe = sender as? OneRecipeRoot else { return }
      destinationVC.oneRecipe = oneRecipe
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
    
    // Cell button delegate configuration
    cell.cellDelegate = self
    cell.index = indexPath
    cell.activityIndicator.isHidden = true
    
    getAllRecipestoBeDisplayed(
      into: cell, from: allRecipes, at: cell.index!)
    
    return cell
  }
}

//MARK: - Setttings the appearance of the cell after networking process
extension SearchTableVC {
  func getAllRecipestoBeDisplayed(into cell: CustomRecipeCell, from allRecipes: AllRecipesRoot?, at indexPath: IndexPath) {
    setRecipeImage(in: cell.cellImage, from: allRecipes, at: indexPath)
    cell.recipeName.text = allRecipes?.matches[indexPath.row].name
    cell.recipeInfo.text = allRecipes?.matches[indexPath.row].ingredients?.joined(separator: ", ")
    cell.likeLabel.text = "\(String(describing: allRecipes?.matches[indexPath.row].rating))/5"
    cell.timerLabel.text = "\(String(describing: (allRecipes?.matches[indexPath.row].cookingTime)! / 60))m"
  }
  
  // Method to display the recipe image
  func setRecipeImage(in recipeImage: UIImageView, from allRecipes: AllRecipesRoot?, at indexPath: IndexPath) {
    if let image = allRecipes?.matches[indexPath.row].image?[0] {
      recipeImage.downloaded(from: image)
    }
    else {
      recipeImage.image = UIImage(named: "noImage")
    }
  }
}
