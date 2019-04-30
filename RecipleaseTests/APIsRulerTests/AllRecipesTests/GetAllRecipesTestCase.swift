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
  func testGetAllRecipesWithAlamofireShouldSucced() {
    // Given
    //let apiSRuler = APIsRuler(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))

    // When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    APIsRuler.shared.searchForRecipes(from: "pasta+tomatoes+cheese+salmon") {
      (success, allRecipesFound) in

      // Then
      XCTAssertTrue(success)
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 5.0)
  }
}
