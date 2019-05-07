//
//  UIImageView.swift
//  Reciplease
//
//  Created by Roland Lariotte on 04/05/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

//MARK: - To retrieve an image from a JSON URL parsing
extension UIImageView {
  func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
    contentMode = mode
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard
        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
        let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
        let data = data, error == nil,
        let image = UIImage(data: data)
        else { return }
      DispatchQueue.main.async() {
        self.image = image
      }
      }.resume()
  }
  
  func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
    guard let url = URL(string: link) else { return }
    downloaded(from: url, contentMode: mode)
  }
}
