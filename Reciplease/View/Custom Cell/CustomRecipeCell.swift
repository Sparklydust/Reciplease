//
//  CustomRecipeCell.swift
//  Reciplease
//
//  Created by Roland Lariotte on 01/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

protocol ButtonClickedDelegate {
  func cellIsClicked(index: Int)
}

class CustomRecipeCell: UITableViewCell {
  
  @IBOutlet weak var cellImage: UIImageView!
  @IBOutlet weak var likeLabel: UILabel!
  @IBOutlet weak var likeImage: UIImageView!
  @IBOutlet weak var timerLabel: UILabel!
  @IBOutlet weak var timerImage: UIImageView!
  @IBOutlet weak var recipeName: UILabel!
  @IBOutlet weak var recipeInfo: UILabel!
  
  var cellDelegate: ButtonClickedDelegate?
  var index: IndexPath?
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  @IBAction func cellButton(_ sender: Any) {
    cellDelegate?.cellIsClicked(index: index!.row)
  }
}
