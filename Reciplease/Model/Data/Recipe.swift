//
//  Recipe.swift
//  Reciplease
//
//  Created by Roland Lariotte on 20/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import CoreData

class Recipe: NSManagedObject {
  
  // Used to fetch user saved recipe from Core Data
  static var all: [Recipe] {
    let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
    guard let recipes = try? AppDelegate.viewContext.fetch(request) else {
      return []
    }
    return recipes
  }
}
