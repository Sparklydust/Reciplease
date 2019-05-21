//
//  GetAllRecipesTestCase.swift
//  RecipleaseTests
//
//  Created by Roland Lariotte on 25/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

@testable import Reciplease
import UIKit
import XCTest

class GetAllRecipesTestCase: XCTestCase {
  
  var apiRuler: APIsRuler!
  
  override func setUp() {
    super.setUp()
    apiRuler = APIsRuler.shared
    //apiRuler.networkRequest = FakeNetworkRequest()
  }
  
  override func tearDown() {
    apiRuler = nil
    super.tearDown()
  }
  
  func test() {
    
  }
}
