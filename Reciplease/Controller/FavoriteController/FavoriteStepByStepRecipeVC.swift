//
//  FavoriteStepByStepRecipeVC.swift
//  Reciplease
//
//  Created by Roland Lariotte on 08/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class FavoriteIngredientsVC: UIViewController {
  
  @IBOutlet weak var imageLabel: UIImageView!
  @IBOutlet weak var recipeName: UILabel!
  @IBOutlet weak var RecipeLabel: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    swapBetweenTabBars()
  }
  
  @IBAction func StepByStepRecipe(_ sender: Any) {
    performSegue(withIdentifier: "showWebVC", sender: self)
  }
  
  @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
    if sender.direction == .right {
      
    }
  }

  func swapBetweenTabBars() {
    let rightSwipe = UISwipeGestureRecognizer(
      target: self, action: #selector(handleSwipes(_:)))
    rightSwipe.direction = .right
    self.view.addGestureRecognizer(rightSwipe)
  }
}
