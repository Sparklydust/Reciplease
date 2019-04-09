//
//  APIsRuler.swift
//  Reciplease
//
//  Created by Roland Lariotte on 06/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation
import Alamofire

class APIsRuler {
  static var shared = APIsRuler()
  private init() {}
  
  static let myAPIid = valueForAPIKey(names: "myYummlyAPIId")
  static let myAPIKey = valueForAPIKey(names: "myYummlyAPIKey")
  
  static let urlAPIParameter = "/_app_id=\(myAPIid)&_app_key=\(myAPIKey)"
  static let url = URL(string: "https://api.yummly.com/v1/api/recipes?" + urlAPIParameter)!
  
  func getRecipies(parameters: [String: String], error: UIAlertController) {    Alamofire.request(APIsRuler.url, method: .get, parameters: parameters).responseJSON { (response) in
      if response.result.isSuccess {
        
      }
      else {
        _ = error
      }
    }
  }
}
