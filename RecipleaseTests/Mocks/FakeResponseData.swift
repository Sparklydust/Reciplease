//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Roland Lariotte on 28/05/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

import Foundation

class FakeResponseData {
  static let APIsRulerIncorrectData = "erreur".data(using: .utf8)!

  static var allRecipesCorrectData: Data {
    let bundle = Bundle(for: FakeResponseData.self)
    let url = bundle.url(forResource: "AllRecipes", withExtension: "json")
    let data = try! Data(contentsOf: url!)
    return data
  }

  static var oneRecipeCorrectData: Data {
    let bundle = Bundle(for: FakeResponseData.self)
    let url = bundle.url(forResource: "OneRecipe", withExtension: "json")
    let data = try! Data(contentsOf: url!)
    return data
  }
}
