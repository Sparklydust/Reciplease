//
//  AlamofireNetworking.swift
//  Reciplease
//
//  Created by Roland Lariotte on 08/05/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkRequest {
  func request<Model: Codable>(_ url: URL, callback: @escaping(Model?, Error?) -> Void)
}

//MARK: - Setup Alamofire to use it all over Reciplease and RecipleaseTests
struct AlamofireNetworking: NetworkRequest {
  enum Error: Swift.Error {
    case noData
    case requestFailed
  }

  func request<Model: Codable>(_ url: URL, callback: @escaping(Model?, Swift.Error?) -> Void) {
    Alamofire.request(url).responseData {
      (response) in
      DispatchQueue.main.async {
        guard response.result.isSuccess else {
          return callback(nil, Error.requestFailed)
        }
        guard let data = response.data else {
          return callback(nil, Error.noData)
        }
        do {
          let responseJSON = try JSONDecoder().decode(Model.self, from: data)
          callback(responseJSON, nil)
        }
        catch {
          print(error.localizedDescription)
        }
      }
    }
  }
}
