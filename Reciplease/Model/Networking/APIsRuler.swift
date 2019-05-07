//
//  APIsRuler.swift
//  Reciplease
//
//  Created by Roland Lariotte on 06/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkRequest {
  func request<Data: Codable>(url: URL, method: HTTPMethod, callback: @escaping(Data?) -> Void)
}

//struct AlamofireNetworkRequest: NetworkRequest {
//  func request<Data>(url: URL, method: HTTPMethod, callback: @escaping(Data?) -> Void) {
//    Alamofire.request(url, method: .get).responseData { (response) in
//      DispatchQueue.main.async {
//        guard response.result.isSuccess else {
//          print("\(String(describing: response.result.error))")
//          return
//        }
//        guard let data = response.data else {
//          print("\(String(describing: response.result.error))")
//          return
//        }
//        do {
//          let responseJSON = try JSONDecoder().decode(OneRecipeRoot.self, from: data)
//          callback(responseJSON)
//        }
//        catch {
//          print(error.localizedDescription)
//        }
//      }
//    }
//  }
//}

//
//
//class FakeNetworkRequest: NetworkRequest {
//
//  var response: HTTPURLResponse?
//  var bodyData: Data?
//
//  init(response: HTTPURLResponse?, bodyData: Data?) {
//    self.response = response
//    self.bodyData = bodyData
//  }
//  
//  func request<Data: Codable>(url: String, completionHandler: (Bool, Data?) -> Void) {
//
//    guard let data = bodyData else {
//      return completionHandler(false, nil)
//      }
//    let object = try! JSONDecoder().decode(Data.self, from: data)
//    return completionHandler(true, object)
//  }
//}


// APIsRuler.shared.networkRequest = FakeNetworkRequest(data: nil, error: nil)


struct APIsRuler {
  
  //var networkRequest: NetworkRequest = AlamofireNetworkRequest()
  
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
    
    // networkRequest.get(searchURL) { (model, error) in
    // TO DO CODE
    // }
    
    Alamofire.request(searchURL, method: .get).responseJSON {
      (response) in
      DispatchQueue.main.async {
        guard response.result.isSuccess else {
          print("\(String(describing: response.result.error))")
          return
        }
        guard let data = response.data else {
          print("\(String(describing: response.result.error))")
          return
        }
        do {
          let responseJSON = try JSONDecoder().decode(AllRecipesRoot.self, from: data)
          callback(true, responseJSON)
        }
        catch {
          print(error.localizedDescription)
        }
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
    
    Alamofire.request(searchURL, method: .get).responseJSON {
      (response) in
      DispatchQueue.main.async {
        guard response.result.isSuccess else {
          print("\(String(describing: response.result.error))")
          return
        }
        guard let data = response.data else {
          print("\(String(describing: response.result.error))")
          return
        }
        do {
          let responseJSON = try JSONDecoder().decode(OneRecipeRoot.self, from: data)
          callback(true, responseJSON)
        }
        catch {
          print(error.localizedDescription)
        }
      }
    }
  }
}
