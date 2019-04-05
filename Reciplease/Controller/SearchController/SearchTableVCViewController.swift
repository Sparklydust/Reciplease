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
  
  override func viewDidLoad() {
        super.viewDidLoad()
    searchTableView.delegate = self
    searchTableView.dataSource = self
    
    // Register the custon cell
    searchTableView.register(
      UINib(nibName: "CustomRecipeCell", bundle: nil),
      forCellReuseIdentifier: "customRecipeCell")
    }
  
}

//MARK: - Configure searchTableView
//TODO: Change the numberOfRowsInSection
extension SearchTableVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "customRecipeCell", for: indexPath) as! CustomRecipeCell
    return cell
  }
}
