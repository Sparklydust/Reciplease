//
//  AddIngredientsVC.swift
//  Reciplease
//
//  Created by Roland Lariotte on 01/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class AddIngredientsVC: UIViewController {
  
  @IBOutlet weak var ingredientsTableView: UITableView!
  
  
  let ingredientArray = ["Chicken", "Pasta", "Vegetables"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Register the custon cell
    ingredientsTableView.register(
      UINib(nibName: "CustomSearchCell", bundle: nil),
      forCellReuseIdentifier: "customSearchCell")
  }
  
}

//MARK: - Configure ingredientsTableView
extension AddIngredientsVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ingredientArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "customSearchCell", for: indexPath) as! CustomSearchCell
    cell.ingredientCellLabel.text = "- " + ingredientArray[indexPath.row]
    return cell
  }
}
