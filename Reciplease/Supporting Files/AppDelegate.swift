//
//  AppDelegate.swift
//  Reciplease
//
//  Created by Roland Lariotte on 01/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

//  static var persistentContainer: NSPersistentContainer {
//    return (UIApplication.shared.delegate as! AppDelegate).persistentContainer
//  }

//  static var viewContext: NSManagedObjectContext {
//    return persistentContainer.viewContext
//  }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    return true
  }

  // MARK: - Core Data stack
//  lazy var persistentContainer: NSPersistentContainer = {
//    let container = NSPersistentContainer(name: "Reciplease")
//    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//      if let error = error as NSError? {
//        fatalError("Unresolved error \(error), \(error.userInfo)")
//      }
//    })
//    return container
//  }()

//  func saveContext() {
//    let context = persistentContainer.viewContext
//    if context.hasChanges {
//      do {
//        try context.save()
//      }
//      catch {
//        let nserror = error as NSError
//        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//      }
//    }
//  }
}
