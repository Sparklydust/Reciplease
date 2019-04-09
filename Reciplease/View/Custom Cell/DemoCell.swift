//
//  DemoCell.swift
//  FoldingCell
//
//  Created by Alex K. on 25/12/15.
//  Copyright © 2015 Alex K. All rights reserved.
//

import FoldingCell
import UIKit

class DemoCell: FoldingCell {
  
  // First Container Outlet
  @IBOutlet weak var likeLabel: UILabel!
  @IBOutlet weak var timerLabel: UILabel!
  @IBOutlet weak var firstContainerImage: UIImageView!
  @IBOutlet weak var recipeNameLabel: UILabel!
  @IBOutlet weak var recipeInfoLabel: UILabel!
  
  // Second Container Outlet
  @IBOutlet weak var caloriesLabel: UILabel!
  @IBOutlet weak var fatLabel: UILabel!
  @IBOutlet weak var proteinLabel: UILabel!
  @IBOutlet weak var fiberLabel: UILabel!
  @IBOutlet weak var ingredientsLabel: UITextView!
  @IBOutlet weak var secondContainerImage: UIImageView!
  @IBOutlet weak var buttonImage: UIButton!
  
  
  override func awakeFromNib() {
    foregroundView.layer.cornerRadius = 10
    foregroundView.layer.masksToBounds = true
    super.awakeFromNib()
  }
  
  @IBAction func buttonFavorite(_ sender: Any) {
  }
  
  override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
    let durations = [0.26, 0.2, 0.2]
    return durations[itemIndex]
  }
}

// MARK: - Actions ⚡️
extension DemoCell {
  @IBAction func buttonHandler(_: AnyObject) {
    print("tap")
  }
}
