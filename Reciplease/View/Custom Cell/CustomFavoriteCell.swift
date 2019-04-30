//
//  CustomFavoriteCell.swift
//  Reciplease
//
//  Created by Roland Lariotte on 01/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import FoldingCell
import UIKit

class CustomFavoriteCell: FoldingCell {
  
  @IBOutlet weak var closeCellImage: UIImageView!
  @IBOutlet weak var recipeName: UILabel!
  @IBOutlet weak var recipeInfo: UILabel!
  @IBOutlet weak var likeLabel: UILabel!
  @IBOutlet weak var timerLabel: UILabel!
  
  @IBOutlet weak var caloriesLabel: UILabel!
  @IBOutlet weak var fatLabel: UILabel!
  @IBOutlet weak var proteinLabel: UILabel!
  @IBOutlet weak var fiberLabel: UILabel!
  @IBOutlet weak var ingredientsLabel: UITextView!
  @IBOutlet weak var openCellImage: UIImageView!
    
  override func awakeFromNib() {
    foregroundView.layer.cornerRadius = 10
    foregroundView.layer.masksToBounds = true
    super.awakeFromNib()
  }
  
  override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
    let durations = [0.26, 0.2, 0.2]
    return durations[itemIndex]
  }
}
