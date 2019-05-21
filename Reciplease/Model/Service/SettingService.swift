//
//  SettingService.swift
//  Reciplease
//
//  Created by Roland Lariotte on 13/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

class SettingService {
  private struct Keys {
    static let ingredients = "ingredients"
  }

  static var ingredients: [Any]? {
    get {
      return UserDefaults.standard.array(
        forKey: Keys.ingredients) 
    }
    set {
      UserDefaults.standard.set(
        newValue, forKey: Keys.ingredients)
    }
  }
}
