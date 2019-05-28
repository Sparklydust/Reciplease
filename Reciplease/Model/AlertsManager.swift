//
//  AlertsManager.swift
//  Reciplease
//
//  Created by Roland Lariotte on 13/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit

protocol ShowsAlert {}

extension ShowsAlert where Self: UIViewController {
  func showsAlert(title: String,
                  message: String,
                  completion: @escaping (_ result: Bool) -> Void) {
    let deleteAlert = UIAlertController(
      title: title,
      message: message,
      preferredStyle: .alert)
    deleteAlert.addAction(UIAlertAction(
      title: "OK",
      style: .default, handler: { (action) in
        completion(true)
    }))
    deleteAlert.addAction(UIAlertAction(
      title: "Cancel",
      style: .cancel, handler: nil))
    present(deleteAlert, animated: true, completion: nil)
  }
}

extension ShowsAlert where Self: UIViewController {
  func showsAlert(title: String, message: String) {
    let noEntryAlert = UIAlertController(
      title: title,
      message: message,
      preferredStyle: .alert)
    noEntryAlert.addAction(UIAlertAction(
      title: "OK", style: .cancel, handler: nil))
    present(noEntryAlert, animated: true, completion: nil)
  }
}

extension UIViewController {
  func alert(title: String, message: String) {
    let noEntryAlert = UIAlertController(
      title: title,
      message: message,
      preferredStyle: .alert)
    noEntryAlert.addAction(UIAlertAction(
      title: "OK", style: .cancel, handler: nil))
    present(noEntryAlert, animated: true, completion: nil)
  }
}
