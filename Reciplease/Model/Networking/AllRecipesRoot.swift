//
//  Recipe.swift
//  Reciplease
//
//  Created by Roland Lariotte on 09/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation
import UIKit

struct AllRecipesRoot: Codable {
  let matches: [Matches]

  struct Matches: Codable {
    let name: String?
    let image: [URL]?
    let ingredients: [String]?
    let id: String?
    let cookingTime: Int?
    let rating: Int?

    private enum CodingKeys: String, CodingKey {
      case name = "recipeName"
      case image = "smallImageUrls"
      case ingredients
      case id
      case cookingTime = "totalTimeInSeconds"
      case rating
    }
  }
}
