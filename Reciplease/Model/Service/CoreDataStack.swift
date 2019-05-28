//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Roland Lariotte on 16/05/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation
import CoreData

open class CoreDataStack {
  static var shared = CoreDataStack(modelName: RecipeService.modelName)

  let modelName: String

  public init(modelName: String) {
    self.modelName = modelName
  }

  public lazy var mainContext: NSManagedObjectContext = {
    return self.storeContainer.viewContext
  }()

  public lazy var storeContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: self.modelName)
    container.loadPersistentStores { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container
  }()

  public func newDerivedContext() -> NSManagedObjectContext {
    let context = storeContainer.newBackgroundContext()
    return context
  }

  public func saveContext(_ context: NSManagedObjectContext) {
    if context != mainContext {
      saveDerivedContext(context)
      return
    }
    context.perform {
      do {
        try context.save()
      }
      catch let error as NSError {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
  }

  public func saveDerivedContext(_ context: NSManagedObjectContext) {
    context.perform {
      do {
        try context.save()
      }
      catch let error as NSError {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
      self.saveContext(self.mainContext)
    }
  }
}
