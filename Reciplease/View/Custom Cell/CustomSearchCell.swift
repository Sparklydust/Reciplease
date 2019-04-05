//
//  CustomSearchCell.swift
//  Reciplease
//
//  Created by Roland Lariotte on 03/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class CustomSearchCell: UITableViewCell {

  @IBOutlet weak var ingredientCellLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
