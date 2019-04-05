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
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var timeImage: UIImageView!
  @IBOutlet weak var recipeName: UILabel!
  @IBOutlet weak var recipeInfo: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}
