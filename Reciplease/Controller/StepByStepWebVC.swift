//
//  StepByStepRecipieVC.swift
//  Reciplease
//
//  Created by Roland Lariotte on 06/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit
import WebKit

class StepByStepWebVC: UIViewController, ShowsAlert {

  var webView: WKWebView!
  var recipeMaster: RecipeMaster?

  override func loadView() {
    webViewConfiguration()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Reciplease"
    guard let myURL = recipeMaster?.webUrl else {
      showsAlert(
        title: "No URL",
        message: "Sorry but this recipe doesn't have a valid URL, \nplease select another one")
      return
    }
    let myRequest = URLRequest(url: myURL)
    webView.load(myRequest)
  }
}

//MARK: - Web View Configuration
extension StepByStepWebVC: WKNavigationDelegate {
  func webViewConfiguration() {
    let webConfiguration = WKWebViewConfiguration()
    webView = WKWebView(frame: .zero, configuration: webConfiguration)
    webView.allowsBackForwardNavigationGestures = true
    webView.uiDelegate = self as? WKUIDelegate
    view = webView
  }
}
