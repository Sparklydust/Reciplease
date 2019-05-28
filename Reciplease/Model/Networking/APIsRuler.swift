//
//  APIsRuler.swift
//  Reciplease
//
//  Created by Roland Lariotte on 06/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation
import Alamofire

struct APIsRuler {

  var networkRequest: NetworkRequest = AlamofireNetworking()

  static var shared = APIsRuler()
  private init() {}

  static let myAPIid = valueForAPIKey(names: "myYummlyAPIId")
  static let myAPIKey = valueForAPIKey(names: "myYummlyAPIKey")

  static let urlAPIParameter =
  "_app_id=\(APIsRuler.myAPIid)&_app_key=\(APIsRuler.myAPIKey)"
}

//MARK: - API call to find recipes with user ingredients
extension APIsRuler {
  func searchForRecipes(from userIngredients: String, callback: @escaping (Bool, AllRecipesRoot?) -> Void) {
    let urlSearchParameter = "&q=\(userIngredients)&requirePictures=true"
    let searchURL = URL(
      string: "https://api.yummly.com/v1/api/recipes?"
        + APIsRuler.urlAPIParameter + urlSearchParameter)!

    networkRequest.request(searchURL) {
      (model: AllRecipesRoot?, error: Error?) in
      if error != nil {
        callback(false, nil)
      }
      else {
        callback(true, model)
      }
    }
  }
}

//MARK: - API call to get one recipe from from user search results
extension APIsRuler {
  func getRecipe(from recipieID: String, callback: @escaping (Bool, OneRecipeRoot?) -> Void) {
    let searchURL = URL(
      string: "https://api.yummly.com/v1/api/recipe/\(recipieID)?"
        + APIsRuler.urlAPIParameter)!

    networkRequest.request(searchURL) {
      (model: OneRecipeRoot?, error: Error?) in
      if error != nil {
        callback(false, nil)
      }
      else {
        callback(true, model)
      }
    }
  }
}
