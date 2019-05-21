//
//  AddIngredientsVC.swift
//  Reciplease
//
//  Created by Roland Lariotte on 01/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit
import TableViewReloadAnimation

class AddIngredientsVC: UIViewController, ShowsAlert {

  @IBAction func unwindToAddIngredientsVC(segue:UIStoryboardSegue) { }

  @IBOutlet weak var ingredientsTableView: UITableView!
  @IBOutlet weak var userInput: UITextField!
  @IBOutlet weak var searchRecipeButton: UIButton!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

  var ingredients = [String]()

  override func viewDidLoad() {
    super.viewDidLoad()
    userInput.delegate = self
    activityIndicator.isHidden = true

    // Retrieve and set user saved ingredients
    if let loadedIngredients = SettingService.ingredients {
      ingredients = loadedIngredients as! [String]
    }

    // Register the custom cell
    ingredientsTableView.register(
      UINib(nibName: "CustomSearchCell", bundle: nil),
      forCellReuseIdentifier: "customSearchCell")
  }

  // To Perform a table view animation
  override func viewWillAppear(_ animated: Bool) {
    ingredientsTableView.reloadData(
      with: .simple(duration: 0.75, direction: .rotation3D(
        type: .captainMarvel), constantDelay: 0))
  }

  //MARK: - Exporter Delegation to SearchTableVC
  @IBAction func searchForRecipies(_ sender: Any) {
    if ingredients.isEmpty {
      showsAlert(
        title: "No Ingredients",
        message: "Please, make sure you have added ingredients in your list")
    }
    else {
      triggerActivityIndicator(true)
      //API call made at this point
      APIsRuler.shared.searchForRecipes(from: ingredients.joined(separator: "+")) {
        (success, allRecipes) in
        self.triggerActivityIndicator(false)
        if success, let allRecipes = allRecipes {
          self.performSegue(withIdentifier: "goToNextVC", sender: allRecipes)
        }
      }
    }
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let destinationVC = segue.destination as? SearchTableVC else { return }
    guard let allRecipes = sender as? AllRecipesRoot else { return }
    destinationVC.allRecipes = allRecipes
  }
}

//MARK: - Configure ingredientsTableView
extension AddIngredientsVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ingredients.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: "customSearchCell", for: indexPath) as! CustomSearchCell
    cell.ingredientCellLabel.text = "- " + ingredients[indexPath.row]
    return cell
  }
}

//MARK: - Adding new ingredients methods
extension AddIngredientsVC {
  @IBAction func addIngredient(_ sender: Any) {
    if userInput.text!.isEmpty {
      showsAlert(
        title: "No Entry",
        message: "Enter an ingredient"
      )
    }
    else {
      newIngredientAdded()
    }
  }

  func newIngredientAdded() {
    ingredients.insert(userInput.text!.capitalized, at: 0)
    SettingService.ingredients = ingredients
    ingredientsTableView.reloadData()
    userInput.text = ""
  }
}

//MARK: - Method to delete one row at a time
extension AddIngredientsVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView,
                 commit editingStyle: UITableViewCell.EditingStyle,
                 forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      ingredients.remove(at: indexPath.row)
      SettingService.ingredients = ingredients
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
}

//MARK: - Dismiss keyboard Methods
extension AddIngredientsVC: UITextFieldDelegate {
  // When tapp on screen
  @IBAction func dismissKeyboard(_ sender: Any) {
    userInput.resignFirstResponder()
  }

  // When done is clicked on keyboard
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    userInput.resignFirstResponder()
    return true
  }
}

//MARK: - Activity Indicator and Button Actions
extension AddIngredientsVC {
  func triggerActivityIndicator(_ action: Bool) {
    activityIndicator.isHidden = !action
    searchRecipeButton.isHidden = action
  }
}

//MARK: - Clear user input
extension AddIngredientsVC {
  @IBAction func clearIngredients(_ sender: Any) {
    showsAlert(
      title: "Deleting All?",
      message: "Delete one element by swaping left on it") {
        (true) in
        self.clearAllIngredients()
    }
  }

  func clearAllIngredients() {
    ingredients = [String]()
    userInput.text! = ""
    ingredientsTableView.reloadData()
    SettingService.ingredients = [String]()
  }
}
