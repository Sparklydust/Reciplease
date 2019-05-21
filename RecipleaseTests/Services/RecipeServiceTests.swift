//
//  RecipeServiceTests.swift
//  RecipleaseTests
//
//  Created by Roland Lariotte on 16/05/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import XCTest
@testable import Reciplease
import CoreData

class RecipeServiceTests: XCTestCase {
  
  var recipeService: RecipeService!
  var coreDataStack: CoreDataStack!
  
  override func setUp() {
    super.setUp()
    coreDataStack = FakeCoreDataStack()
    recipeService = RecipeService(
      managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
  }
  
  override func tearDown() {
    recipeService = nil
    coreDataStack = nil
    super.tearDown()
  }
  
  //MARK: - Adding a recipe
  func testAddRecipe() {
    let recipe = recipeService.addRecipe(
      name: "Taco Stuffed Shells",
      ingredients: "12 ounces jumbo pasta shells",
      webURL: URL(fileURLWithPath: "https://dinnerthendessert.com"),
      timer: "1800", rating: "3",
      image: URL(fileURLWithPath: "https://lh3.googleusercontent.com"),
      calories: 255.72, fat: 17.55, fiber: 20.35, protein: 1.28)
    
    XCTAssertNotNil(recipe, "Recipe should not be nil")
    XCTAssertTrue(recipe?.name == "Taco Stuffed Shells")
    XCTAssertTrue(recipe?.ingredients == "12 ounces jumbo pasta shells")
    XCTAssertTrue(recipe?.recipeSource == URL(fileURLWithPath: "https://dinnerthendessert.com"))
    XCTAssertTrue(recipe?.cookingTime == "1800")
    XCTAssertTrue(recipe?.rating == "3")
    XCTAssertTrue(recipe?.image == URL(fileURLWithPath: "https://lh3.googleusercontent.com"))
    XCTAssertTrue(recipe?.calories == 255.72)
    XCTAssertTrue(recipe?.fat == 17.55)
    XCTAssertTrue(recipe?.fiber == 20.35)
    XCTAssertTrue(recipe?.protein == 1.28)
  }
  
  //MARK: - Saving a recipe after adding one
  func testRootContextIsSavedAfterAddingRecipe() {
    // Create a background context to do the work
    let derivedContext = coreDataStack.newDerivedContext()
    recipeService = RecipeService(managedObjectContext: derivedContext, coreDataStack: coreDataStack)
    
    // Create a text expectation linked to a notification
    expectation(forNotification: .NSManagedObjectContextDidSave, object: coreDataStack.mainContext) {
      (notification) -> Bool in
      return true
    }
    
    // Add recipe inside a perform block on the derived context
    derivedContext.perform {
      let recipe = self.recipeService.addRecipe(
        name: "Taco Stuffed Shells",
        ingredients: "12 ounces jumbo pasta shells",
        webURL: URL(fileURLWithPath: "https://dinnerthendessert.com"),
        timer: "1800", rating: "3",
        image: URL(fileURLWithPath: "https://lh3.googleusercontent.com"),
        calories: 255.72, fat: 17.55, fiber: 20.35, protein: 1.28)
      XCTAssertNotNil(recipe)
    }
    
    // Then
    waitForExpectations(timeout: 2.0) { (error) in
      XCTAssertNil(error, "Save did not occur")
    }
  }
  
  func testDeleteRecipe() {
    _ = recipeService.addRecipe(
      name: "Taco Stuffed Shells",
      ingredients: "12 ounces jumbo pasta shells",
      webURL: URL(fileURLWithPath: "https://dinnerthendessert.com"),
      timer: "1800", rating: "3",
      image: URL(fileURLWithPath: "https://lh3.googleusercontent.com"),
      calories: 255.72, fat: 17.55, fiber: 20.35, protein: 1.28)

    var fetchedRecipe = recipeService.fetchAllRecipes()

    XCTAssertNotNil(fetchedRecipe, "Recipe should exist")

    recipeService.deleteRecipe(fetchedRecipe[0])
    fetchedRecipe = recipeService.fetchAllRecipes()

    XCTAssertEqual(fetchedRecipe, [], "Should be equal to an empty array of Recipe")
  }
  
  func testFetchAllRecipe() {
    _ = recipeService.addRecipe(
      name: "Taco Stuffed Shells",
      ingredients: "12 ounces jumbo pasta shells",
      webURL: URL(fileURLWithPath: "https://dinnerthendessert.com"),
      timer: "1800", rating: "3",
      image: URL(fileURLWithPath: "https://lh3.googleusercontent.com"),
      calories: 255.72, fat: 17.55, fiber: 20.35, protein: 1.28)
    
    _ = recipeService.addRecipe(
      name: "Pasta Cream and Bacon",
      ingredients: "4 bacon slices",
      webURL: URL(fileURLWithPath: "https://dinnerthendessert.com"),
      timer: "2674", rating: "4",
      image: URL(fileURLWithPath: "https://lh3.googleusercontent.com"),
      calories: 290.72, fat: 12.23, fiber: 14.47, protein: 1.15)
    
    let fetchedRecipe = recipeService.fetchAllRecipes()
    
    XCTAssertNotNil(fetchedRecipe, "Recipe should exist")
    XCTAssertEqual(fetchedRecipe.count, 2)
  }
}
