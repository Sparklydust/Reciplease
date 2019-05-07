//
//  APIKeys.swift
//  Reciplease
//
//  Created by Roland Lariotte on 01/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import Foundation

func valueForAPIKey(names keyname: String) -> String {
  let filePath = Bundle.main.path(forResource: "APIKeys", ofType: "plist")
  let plist = NSDictionary(contentsOfFile: filePath!)
  let value = plist?.object(forKey: keyname) as! String
  return value
}

