//
//  SearchRecipeVC.swift
//  Reciplease
//
//  Created by Roland Lariotte on 01/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class SearchRecipeVC: UIViewController {

  @IBOutlet weak var imageRecipie: UIImageView!
  @IBOutlet weak var likeLabel: UILabel!
  @IBOutlet weak var likeImage: UIImageView!
  @IBOutlet weak var timerLabel: UILabel!
  @IBOutlet weak var timerImage: UIImageView!
  @IBOutlet weak var recipieName: UILabel!
  @IBOutlet weak var recipieIngredients: UIScrollView!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    }
  @IBAction func stepByStep(_ sender: Any) {
  }
}
