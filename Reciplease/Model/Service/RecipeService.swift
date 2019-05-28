//
//  RecipeService.swift
//  Reciplease
//
//  Created by Roland Lariotte on 16/05/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation
import CoreData

final class RecipeService {

  // MARK: Properties
  let managedObjectContext: NSManagedObjectContext
  let coreDataStack: CoreDataStack

  static let modelName = "Reciplease"

  // MARK: Initializers
  public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
    self.managedObjectContext = managedObjectContext
    self.coreDataStack = coreDataStack
  }
}

// MARK: Add a recipe
extension RecipeService {
  func addRecipe(name: String, ingredients: String,
                 webURL: URL, timer: String,
                 rating: String, image: URL,
                 calories: Double, fat: Double,
                 fiber: Double, protein: Double) -> Recipe? {

    let recipe = Recipe(context: managedObjectContext)

    recipe.name = name
    recipe.ingredients = ingredients
    recipe.recipeSource = webURL
    recipe.cookingTime = timer
    recipe.rating = rating
    recipe.image = image
    recipe.calories = calories
    recipe.fat = fat
    recipe.fiber = fiber
    recipe.protein = protein

    coreDataStack.saveContext(managedObjectContext)

    return recipe
  }
}

//MARK: Fetch all recipe
extension RecipeService {
  func fetchAllRecipes() -> [Recipe] {
    let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
    guard let recipes = try? managedObjectContext.fetch(fetchRequest) else {
      return []
    }
    return recipes
  }
}

//MARK: - Delete a recipe
extension RecipeService {
  func deleteRecipe(_ recipe: NSManagedObject) {
    managedObjectContext.delete(recipe)
    coreDataStack.saveContext(managedObjectContext)
  }
}
