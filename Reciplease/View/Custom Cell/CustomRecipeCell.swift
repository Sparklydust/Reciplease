//
//  CustomRecipeCell.swift
//  Reciplease
//
//  Created by Roland Lariotte on 01/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class CustomRecipeCell: UITableViewCell {
  
  @IBOutlet weak var cellImage: UIImageView!
  @IBOutlet weak var likeLabel: UILabel!
  @IBOutlet weak var likeImage: UIImageView!
  @IBOutlet weak var timerLabel: UILabel!
  @IBOutlet weak var timerImage: UIImageView!
  @IBOutlet weak var recipeName: UILabel!
  @IBOutlet weak var recipeInfo: UILabel!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var likeAndTimerView: UIView!

  //var index: IndexPath?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    activityIndicator.isHidden = true
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func triggerActivityIndicator(_ action: Bool) {
    activityIndicator.isHidden = !action
    recipeInfo.isHidden = action
    recipeName.isHidden = action
    likeAndTimerView.isHidden = action
  }
}
