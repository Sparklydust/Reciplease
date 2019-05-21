//
//  MockURLProtocol.swift
//  RecipleaseTests
//
//  Created by Roland Lariotte on 06/05/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation
import Alamofire
@testable import Reciplease

//MARK: - Setup a fake Alamofire call for testing purposes
struct FakeNetworkRequest: NetworkRequest {
  enum Error: Swift.Error {
    case noData
    case requestFailed
  }
  
  var data: Data?
  var error: Error?
  
  func request<Model: Codable>(_ url: URL, callback: @escaping (Model?, Swift.Error?) -> Void) {
    if let error = error {
      return callback(nil, error)
    }
    guard let data = data else {
      return callback(nil, Error.noData)
    }
    do {
      let fakeResponseJSON = try JSONDecoder().decode(Model.self, from: data)
      callback(fakeResponseJSON, nil)
    }
    catch {
      callback(nil, error)
    }
  }
}
