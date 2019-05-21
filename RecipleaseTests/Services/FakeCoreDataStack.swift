//
//  TestCoreDataStack.swift
//  RecipleaseTests
//
//  Created by Roland Lariotte on 16/05/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Reciplease
import Foundation
import CoreData

class FakeCoreDataStack: CoreDataStack {
  
  convenience init() {
    self.init(modelName: "Reciplease")
  }

  override init(modelName: String) {
    super.init(modelName: modelName)
    
    let persistentStoreDescription =
      NSPersistentStoreDescription()
    persistentStoreDescription.type = NSInMemoryStoreType
    
    let container = NSPersistentContainer(name: modelName)
    container.persistentStoreDescriptions =
      [persistentStoreDescription]
    
    container.loadPersistentStores {
      (storeDescription, error) in
      if let error = error as NSError? {
        fatalError(
          "Unresolved error \(error), \(error.userInfo)")
      }
    }
    self.storeContainer = container
  }
}
