//
//  StepByStepRecipieVC.swift
//  Reciplease
//
//  Created by Roland Lariotte on 06/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class StepByStepRecipieVC: UIViewController {
  
  @IBOutlet weak var fullRecipieImage: UIImageView!
  @IBOutlet weak var fullRecipeView: UIScrollView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    swipeDownToCancelView()
  }
  
  @IBAction func backToSearch(_ sender: Any) {
  }

}

//MARK: - Swipe Down to cancel view Methods
extension StepByStepRecipieVC {
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
