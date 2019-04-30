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

  static let urlAPIParameter =
  "_app_id=\(APIsRuler.myAPIid)&_app_key=\(APIsRuler.myAPIKey)"
  
  // Used for the UITests
  private var task: URLSessionDataTask?
  private var session = URLSession(configuration: .default)
  
  init(session: URLSession) {
    self.session = session
  }
}

//MARK: - API call to find recipes with user ingredients
extension APIsRuler {
  func searchForRecipes(from userIngredients: String, callback: @escaping (Bool, AllRecipesRoot?) -> Void) {
    let urlSearchParameter = "&q=\(userIngredients)&requirePictures=true"
    let searchURL = URL(
      string: "https://api.yummly.com/v1/api/recipes?"
        + APIsRuler.urlAPIParameter + urlSearchParameter)!

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

//MARK: - To retrieve an image from a JSON URL parsing
extension UIImageView {
  func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
    contentMode = mode
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard
        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
        let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
        let data = data, error == nil,
        let image = UIImage(data: data)
        else { return }
      DispatchQueue.main.async() {
        self.image = image
      }
      }.resume()
  }
  
  func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
    guard let url = URL(string: link) else { return }
    downloaded(from: url, contentMode: mode)
  }
}
