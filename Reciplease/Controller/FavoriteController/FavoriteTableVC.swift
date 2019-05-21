//
//  FavoriteTableVC.swift
//  Reciplease
//
//  Created by Roland Lariotte on 01/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import FoldingCell
import UIKit

class FavoriteTableVC: UITableViewController, ShowsAlert {

  enum Const {
    static let closeCellHeight: CGFloat = 179
    static let openCellHeight: CGFloat = 488
    static let rowsCount = 10
  }

  var cellHeights: [CGFloat] = []
  let demoCell = CustomFavoriteCell()
  var recipeMaster: RecipeMaster?
  var index: IndexPath?
  
  var coreDataStack = CoreDataStack(modelName: RecipeService.modelName)
  
  var recipeService: RecipeService
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    self.recipeService = RecipeService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    self.recipeService = RecipeService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupCellsToBeClosed()
    _ = recipeService.fetchAllRecipes()
    reloadDataWithAnimation()
    messageShownIfNoSavedRecipe()
  }
}

//MARK: - Exporter Delegation when the button cell is cliked
extension FavoriteTableVC {
  @IBAction func moreInfoButton(_ sender: Any) {
    performSegue(withIdentifier: "goToRecipeVC", sender: recipeMaster)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "goToRecipeVC" {
      guard let destinationVC = segue.destination as? ShowIngredientsVC else { return }
      guard let recipeMaster = sender as? RecipeMaster else { return }
      destinationVC.recipeMaster = recipeMaster
    }
  }
}

// MARK: - TableView Folding Cell configurations
extension FavoriteTableVC {
  override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
    return recipeService.fetchAllRecipes().count
  }

  override func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard case let cell as CustomFavoriteCell = cell else {
      return
    }
    cell.backgroundColor = .clear

    if cellHeights[indexPath.row] == Const.closeCellHeight {
      cell.unfold(false, animated: false, completion: nil)
    } else {
      cell.unfold(true, animated: false, completion: nil)
    }
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "FoldingCell", for: indexPath) as! CustomFavoriteCell
    let durations: [TimeInterval] = [0.26, 0.2, 0.2]
    cell.durationsForExpandedState = durations
    cell.durationsForCollapsedState = durations

    setSavedRecipes(into: cell, at: indexPath)

    return cell
  }

  override func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return cellHeights[indexPath.row]
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
    if cell.isAnimating() {
      return
    }
    index = indexPath

    var duration = 0.0
    let cellIsCollapsed = cellHeights[indexPath.row] == Const.closeCellHeight
    if cellIsCollapsed {
      cellHeights[indexPath.row] = Const.openCellHeight
      cell.unfold(true, animated: true, completion: nil)
      duration = 0.5
    } else {
      cellHeights[indexPath.row] = Const.closeCellHeight
      cell.unfold(false, animated: true, completion: nil)
      duration = 0.8
    }
    UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
      tableView.beginUpdates()
      tableView.endUpdates()
    }, completion: nil)
    // Recipe to send via segue
    setRecipeMaster(at: indexPath)
  }

  func setRecipeMaster(at indexPath: IndexPath) {
    let recipes = recipeService.fetchAllRecipes()
    recipeMaster = RecipeMaster(
      name: recipes[indexPath.row].name!,
      image: recipes[indexPath.row].image!,
      ingredients: recipes[indexPath.row].ingredients!,
      timer: recipes[indexPath.row].cookingTime!,
      rating: recipes[indexPath.row].rating!,
      webUrl: recipes[indexPath.row].recipeSource!)
  }
}

//MARK: Retrieve saved recipes and setup the cells accordingly
extension FavoriteTableVC {
  func setSavedRecipes(into cell: CustomFavoriteCell, at indexPath: IndexPath) {
    let recipes = recipeService.fetchAllRecipes()
    cell.recipeName.text = recipes[indexPath.row].name
    cell.likeLabel.text = recipes[indexPath.row].rating! + "/5"
    cell.timerLabel.text = "\(Int(recipes[indexPath.row].cookingTime!)! / 60)m"
    cell.caloriesLabel.text = "\(recipes[indexPath.row].calories)"
    cell.fatLabel.text = "\(recipes[indexPath.row].fat)"
    cell.proteinLabel.text = "\(recipes[indexPath.row].protein)"
    cell.fiberLabel.text = "\(recipes[indexPath.row].fiber)"
    cell.ingredientsLabel.text = recipes[indexPath.row].ingredients
    if let image = recipes[indexPath.row].image {
      cell.closeCellImage.downloaded(from: image)
      cell.openCellImage.downloaded(from: image)
    }
  }
}

//MARK: - Unsaving recipe from favorite when the star is clicked
extension FavoriteTableVC {
  @IBAction func starFavoriteButton(_ sender: Any) {
    deleteRecipe(indexPath: index!)
  }

  func deleteRecipe(indexPath: IndexPath) {
    showsAlert(
      title: "Delete this recipe?",
      message: "You are about to remove this item from favorite!") {
        (true) in
        self.coreDataStack.mainContext.delete(self.recipeService.fetchAllRecipes()[indexPath.row])
        do {
          try self.coreDataStack.mainContext.save()
        }
        catch {
          self.showsAlert(
            title: "Error",
            message: "Recipe could not be deleted")
        }
        self.viewWillAppear(true)
        self.setupCellsToBeClosed()
        self.reloadDataWithAnimation()
    }
  }
}

//MARK: - Show VC to user if no recipe were saved
extension FavoriteTableVC {
  func messageShownIfNoSavedRecipe() {
    if recipeService.fetchAllRecipes().count == 0 {
      performSegue(withIdentifier: "messageForUser", sender: self)
    }
  }
}

//MARK: - Setting up cells when controllers open
extension FavoriteTableVC {
  func setupCellsToBeClosed() {
    cellHeights = Array(repeating: Const.closeCellHeight, count: Const.rowsCount)
    tableView.estimatedRowHeight = Const.closeCellHeight
    tableView.rowHeight = UITableView.automaticDimension
    tableView.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1)
  }

  func reloadDataWithAnimation() {
    tableView.reloadData(
      with: .simple(duration: 0.75, direction: .rotation3D(
        type: .doctorStrange), constantDelay: 0)
    )
  }
}
