//
//  RecipeDataTests.swift
//  RecipleaseTests
//
//  Created by Roland Lariotte on 26/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import XCTest
import CoreData
@testable import Reciplease

class RecipeCoreDataTests: XCTestCase {
  func testRecipeShowAllWhenCalculatePropertyIsCalled() {
    let allSavedRecipes = Recipe.all
    
    XCTAssertNotNil(allSavedRecipes)
  }
}
