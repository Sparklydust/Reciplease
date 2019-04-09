//
//  SearchTableVCViewController.swift
//  Reciplease
//
//  Created by Roland Lariotte on 02/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class SearchTableVC: UIViewController {
  
  @IBOutlet weak var searchTableView: UITableView!
  
  // Unwind action from StepByStepVC
  @IBAction func unwindToSearch(segue:UIStoryboardSegue) { }
  
  override func viewDidLoad() {
        super.viewDidLoad()
    searchTableView.delegate = self
    searchTableView.dataSource = self
    
    // Register the custom cell
    searchTableView.register(
      UINib(nibName: "CustomRecipeCell", bundle: nil),
      forCellReuseIdentifier: "customRecipeCell")
    }
  
  // Perform a table view animation
  override func viewWillAppear(_ animated: Bool) {
    searchTableView.reloadData(
      with: .simple(duration: 0.75, direction: .rotation3D(
        type: .spiderMan), constantDelay: 0))
  }
  
}

//MARK: - Configure searchTableView
extension SearchTableVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "customRecipeCell", for: indexPath) as! CustomRecipeCell

    // Cell button delegate configuration
    cell.cellDelegate = self
    cell.index = indexPath
    return cell
  }
}

//MARK: - Delegate for the button cell when cliked
extension SearchTableVC: ButtonClickedDelegate {
  func cellIsClicked(index: Int) {
    performSegue(withIdentifier: "goToRecipieVC", sender: self)
  }
}
