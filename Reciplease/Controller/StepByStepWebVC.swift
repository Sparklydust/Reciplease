//
//  StepByStepRecipieVC.swift
//  Reciplease
//
//  Created by Roland Lariotte on 06/04/2019.
//  Copyright © 2019 Roland Lariotte. All rights reserved.
//

import UIKit
import WebKit

class StepByStepWebVC: UIViewController {

  var webView: WKWebView!
  var oneRecipe: OneRecipeRoot?

  override func loadView() {
    webViewConfiguration()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    print(oneRecipe?.recipe?.sourceRecipeUrl ?? "")
    
    let myURL = URL(string: "https://eatinginstantly.com/instant-pot-taco-pasta/")
    let myRequest = URLRequest(url: myURL!)
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
