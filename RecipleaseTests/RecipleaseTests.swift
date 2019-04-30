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
  
  var uiImageFromUrl: UIImageView!
  let imageURL =
  "https://lh3.googleusercontent.com/USKRmdJjXBC8VyjuuHbNevBzn_ymAypE2dn6dJM_7xIl9jWpfiDlrK0Bq04ChLc5WoeDM7JjdrvgFuJgAnN9mHc=s360"
  
  // Reset CalculatorLogic after each test
  override func setUp() {
    super.setUp()
    uiImageFromUrl = UIImageView()
  }
  
  //MARK: - Testing UIImage Extension
  func testUIImageExtensionToThatNetworkAnImageWithItsURL() {
    uiImageFromUrl.downloaded(from: imageURL)
  }
  
  func testUIImageExtensionToThatNetworkAnImageWithItsStringURL() {
    uiImageFromUrl.downloaded(from: String(imageURL))
  }
}
