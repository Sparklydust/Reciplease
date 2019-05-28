//
//  GetOneRecipeTestCase.swift
//  RecipleaseTests
//
//  Created by Roland Lariotte on 25/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

@testable import Reciplease
import UIKit
import XCTest

class GetOneRecipeTestCase: XCTestCase {

  var sut: APIsRuler!
  var networkRequest: NetworkRequest!

  override func setUp() {
    super.setUp()
    sut = APIsRuler.shared
  }

  override func tearDown() {
    networkRequest = nil
    sut = nil
    super.tearDown()
  }

  func testGetOneRecipesShouldPostFailedCallbackIfError() {
    sut.networkRequest = FakeNetworkRequest(
      data: nil,
      error: FakeNetworkRequest.Error.noData)

    let expectation = XCTestExpectation(description: "Wait for expectation")
    sut.getRecipe(from: "recipeID") {
      (success, oneRecipe) in

      XCTAssertFalse(success)
      XCTAssertNil(oneRecipe)
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.1)
  }

  func testGetOneRecipeShouldPostFailedCallbackIfNoData() {
    sut.networkRequest = FakeNetworkRequest(
      data: nil,
      error: nil)

    let expectation = XCTestExpectation(description: "Wait for expectation")
    sut.getRecipe(from: "recipeID") {
      (success, oneRecipe) in

      XCTAssertFalse(success)
      XCTAssertNil(oneRecipe)
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.1)
  }

  func testGetOneRecipeShouldPostFailedCallbackIfIncorrectData() {
    sut.networkRequest = FakeNetworkRequest(
      data: FakeResponseData.APIsRulerIncorrectData,
      error: nil)

    let expectation = XCTestExpectation(description: "Wait for expectation")
    sut.getRecipe(from: "recipeID") {
      (success, oneRecipe) in

      XCTAssertFalse(success)
      XCTAssertNil(oneRecipe)
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.1)
  }

  func testGetOneRecipeShouldPostSuccessCallbackAndCorrectData() {
    sut.networkRequest = FakeNetworkRequest(
      data: FakeResponseData.oneRecipeCorrectData,
      error: nil)

    let expectation = XCTestExpectation(description: "Wait for expectation")
    sut.getRecipe(from: "recipeID") {
      (success, oneRecipe) in

      let name = "Tomato and Smoked Salmon Pasta"
      let rating = 3

      XCTAssertTrue(success)
      XCTAssertNotNil(oneRecipe)
      XCTAssertEqual(name, oneRecipe?.name)
      XCTAssertEqual(rating, oneRecipe?.rating)
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.1)
  }
}
