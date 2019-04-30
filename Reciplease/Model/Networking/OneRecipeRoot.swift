//
//  OneRecipeSearch.swift
//  Reciplease
//
//  Created by Roland Lariotte on 12/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

struct OneRecipeRoot: Codable {
  let nutrition: [NutritionEstimate]?
  let image: [ImageFounder]?
  let name: String?
  let recipe: Source?
  let ingredients: [String]?
  let cookingTime, rating: Int?

  private enum CodingKeys: String, CodingKey {
    case nutrition = "nutritionEstimates"
    case image = "images"
    case name
    case recipe = "source"
    case ingredients = "ingredientLines"
    case cookingTime = "totalTimeInSeconds"
    case rating
  }

  struct ImageFounder: Codable {
    let hostedLargeUrl: URL
  }

  struct NutritionEstimate: Codable {
    let attribute: String
    let value: Double
  }

  struct Source: Codable {
    let sourceRecipeUrl: URL
  }
}
