//
//  AddIngredientsVC.swift
//  Reciplease
//
//  Created by Roland Lariotte on 01/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit
import TableViewReloadAnimation

class AddIngredientsVC: UIViewController {
  
  @IBOutlet weak var ingredientsTableView: UITableView!
  @IBOutlet weak var userInput: UITextField!
  
  var ingredientArray = ["Chicken", "Pasta", "Vegetables", "Chicken", "Pasta", "Vegetables", "Chicken", "Pasta", "Vegetables", "Chicken", "Pasta", "Vegetables", "Chicken", "Pasta", "Vegetables", "Chicken", "Pasta", "Vegetables"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    userInput.delegate = self
    
    // Register the custom cell
    ingredientsTableView.register(
      UINib(nibName: "CustomSearchCell", bundle: nil),
      forCellReuseIdentifier: "customSearchCell")
  }
  
  // Perform a table view animation
  override func viewWillAppear(_ animated: Bool) {
    ingredientsTableView.reloadData(
      with: .simple(duration: 0.75, direction: .rotation3D(
        type: .captainMarvel), constantDelay: 0))
  }
  
  //MARK: - Clear user input
  @IBAction func clearIngredients(_ sender: Any) {
    deleteAllAlert()
  }
  
  @IBAction func searchForRecipies(_ sender: Any) {
    performSegue(withIdentifier: "goToNextVC", sender: self)
  }
  
}

//MARK: - Configure ingredientsTableView
extension AddIngredientsVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ingredientArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "customSearchCell", for: indexPath) as! CustomSearchCell
    cell.ingredientCellLabel.text = "- " + ingredientArray[indexPath.row]
    return cell
  }
}

//MARK: - Adding new ingredients methods
extension AddIngredientsVC {
  @IBAction func addIngredient(_ sender: Any) {
    if userInput.text!.isEmpty {
      noEntryAlert()
    }
    else {
      newIngredientAdded()
    }
  }
  
  func newIngredientAdded() {
    ingredientArray.insert(userInput.text!.capitalized, at: 0)
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
      ingredientArray.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
}

//MARK: - Alert methods
extension AddIngredientsVC {
  func deleteAllAlert() {
    let deleteAlert = UIAlertController(
      title: "Deleting All?",
      message: "You can delete one element by swaping left on it",
      preferredStyle: .alert)
    deleteAlert.addAction(UIAlertAction(
      title: "OK",
      style: .default, handler: { (action) in
        
        self.ingredientArray = [String]()
        self.userInput.text! = ""
        self.ingredientsTableView.reloadData()
    }))
    deleteAlert.addAction(UIAlertAction(
      title: "Cancel",
      style: .cancel, handler: nil))
    present(deleteAlert, animated: true, completion: nil)
  }
  
  func noEntryAlert() {
    let noEntryAlert = UIAlertController(
      title: "No Entry!",
      message: "You must enter an ingredient to add one",
      preferredStyle: .alert)
    noEntryAlert.addAction(UIAlertAction(
      title: "OK", style: .cancel, handler: nil))
    present(noEntryAlert, animated: true, completion: nil)
  }
  
  
  func networkingError() {
    let networkAlert = UIAlertController(
      title: "Network Error",
      message: "There was an error loading data",
      preferredStyle: .alert)
    networkAlert.addAction(UIAlertAction(
      title: "OK", style: .cancel, handler: nil))
    present(networkAlert, animated: true, completion: nil)
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
