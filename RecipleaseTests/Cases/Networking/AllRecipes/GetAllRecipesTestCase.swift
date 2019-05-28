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

  func testGetAllRecipesShouldPostFailedCallbackIfError() {
    sut.networkRequest = FakeNetworkRequest(
      data: nil,
      error: FakeNetworkRequest.Error.noData)

    let expectation = XCTestExpectation(description: "Wait for expectation")
    sut.searchForRecipes(from: "ingredients") {
      (success, allRecipes) in

      XCTAssertFalse(success)
      XCTAssertNil(allRecipes?.matches)
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.1)
  }

  func testGetAllRecipesShouldPostFailedCallbackIfNoData() {
    sut.networkRequest = FakeNetworkRequest(
      data: nil,
      error: nil)

    let expectation = XCTestExpectation(description: "Wait for expectation")
    sut.searchForRecipes(from: "ingredients") {
      (success, allRecipes) in

      XCTAssertFalse(success)
      XCTAssertNil(allRecipes?.matches)
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.1)
  }

  func testGetAllRecipesShouldPostFailedCallbackIfIncorrectData() {
    sut.networkRequest = FakeNetworkRequest(
      data: FakeResponseData.APIsRulerIncorrectData,
      error: nil)

    let expectation = XCTestExpectation(description: "Wait for expectation")
    sut.searchForRecipes(from: "ingredients") {
      (success, allRecipes) in

      XCTAssertFalse(success)
      XCTAssertNil(allRecipes?.matches)
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.1)
  }

  func testGetAllRecipesShouldPostSuccessCallbackAndCorrectData() {
    sut.networkRequest = FakeNetworkRequest(
      data: FakeResponseData.allRecipesCorrectData,
      error: nil)

    let expectation = XCTestExpectation(description: "Wait for expectation")
    sut.searchForRecipes(from: "ingredients") {
      (success, allRecipes) in

      let name = "Salmon and Asparagus Pasta Salad"
      let rating = 4

      XCTAssertTrue(success)
      XCTAssertNotNil(allRecipes?.matches)
      XCTAssertEqual(name, allRecipes?.matches[0].name)
      XCTAssertEqual(rating, allRecipes?.matches[0].rating)
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.1)
  }
}
