//
//  UserHelperVC.swift
//  Reciplease
//
//  Created by Roland Lariotte on 30/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

class UserHelperVC: UIViewController {

  @IBOutlet weak var helperMessageLabel: UILabel!
  
  override func viewDidLoad() {
        super.viewDidLoad()
      setHelperMessage()
    }
  
  func setHelperMessage() {
    helperMessageLabel.text = """
    You don't have any saved recipe.
    
    
    To add your first one, search recipes using ingredients and save the one you like by clicking on the star icon found in the details screen.
    
    
    Bon Apétit!
    """
  }
}
