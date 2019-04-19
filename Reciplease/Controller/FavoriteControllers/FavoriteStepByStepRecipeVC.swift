//
//  FavoriteStepByStepRecipeVC.swift
//  Reciplease
//
//  Created by Roland Lariotte on 08/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class FavoriteStepByStepRecipeVC: UIViewController {
  
  @IBOutlet weak var imageLabel: UIImageView!
  @IBOutlet weak var RecipeLabel: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    swipeDownToCancelView()
  }
  
  @IBAction func backToFavorite(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}

//MARK: - Swipe Down to cancel view Methods
extension FavoriteStepByStepRecipeVC {
  @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
    if sender.direction == .down {
      dismiss(animated: true, completion: nil)
    }
  }
  
  func swipeDownToCancelView() {
    let swipeToCancel = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
    swipeToCancel.direction = .down
    self.view.addGestureRecognizer(swipeToCancel)
  }
}
