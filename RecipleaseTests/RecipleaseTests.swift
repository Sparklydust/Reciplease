//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Roland Lariotte on 01/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

@testable import Reciplease
import UIKit
import XCTest

class RecipleaseTests: XCTestCase {
  
  var addIngredientsVC: AddIngredientsVC!
  
  override func setUp() {
    super.setUp()
    addIngredientsVC = AddIngredientsVC()
  }
  
  override func tearDown() {
    super.tearDown()
    addIngredientsVC = nil
  }
  
  func test() {
  }
}
