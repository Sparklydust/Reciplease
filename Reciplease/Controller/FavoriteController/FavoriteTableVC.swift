//
//  FavoriteTableVC.swift
//  Reciplease
//
//  Created by Roland Lariotte on 01/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class FavoriteTableVC: UIViewController {
  
  @IBOutlet weak var favoriteTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    favoriteTableView.delegate = self
    favoriteTableView.dataSource = self
    
    // Register the custom cell
    favoriteTableView.register(
      UINib(nibName: "CustomRecipeCell", bundle: nil),
      forCellReuseIdentifier: "customRecipeCell")
  }
}

//MARK: - Table View Configurations
extension FavoriteTableVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "customRecipeCell", for: indexPath) as! CustomRecipeCell
    return cell
  }
}
