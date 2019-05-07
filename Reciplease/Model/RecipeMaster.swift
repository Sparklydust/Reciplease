//
//  RecipeEssential.swift
//  Reciplease
//
//  Created by Roland Lariotte on 27/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

// A Recipe struct to be used all over the app
struct RecipeMaster {
  var name: String?
  var image: URL?
  var ingredients: String?
  var timer: String?
  var rating: String?
  var webUrl: URL?
  var calories: Double?
  var fat: Double?
  var fiber: Double?
  var protein: Double?
  
  init() { }
  
  init(name: String, image: URL, ingredients: String,
       timer: String, rating: String, webUrl: URL) {
    self.name = name
    self.image = image
    self.ingredients = ingredients
    self.timer = timer
    self.rating = rating
    self.webUrl = webUrl
  }
  
  init(name: String, image: URL, ingredients: String, timer: String, rating: String,
       webUrl: URL, calories: Double, fat: Double, fiber: Double, protein: Double) {
    self.name = name
    self.image = image
    self.ingredients = ingredients
    self.timer = timer
    self.rating = rating
    self.webUrl = webUrl
    self.calories = calories
    self.fat = fat
    self.fiber = fiber
    self.protein = protein
  }
}
