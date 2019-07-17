//
//  OrderOrderViewController.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit
import WebKit
import KarteTracker

class OrderViewController: UIViewController, OrderViewInput {
    weak var webView: WKWebView!
    
    var output: OrderViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWebView()
        output.viewIsReady()
    }


    // MARK: OrderViewInput
    func setupInitialState() {
        webView.navigationDelegate = self
        
        let baseURL = URL(string: "\(Configuration.webContentHostingURL)/order.html")!
        let url = KarteTrackerJsUtil.URLByAppendingUserSyncQueryParameter(appKey: KarteTracker.shared.appKey, url: baseURL)
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    private func configureWebView() {
        let webView = WKWebView(frame: .zero)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        
        view.addSubview(webView)
        
        self.webView = webView
        self.view.topAnchor.constraint(equalToSystemSpacingBelow: webView.topAnchor, multiplier: 0).isActive = true
        self.view.leftAnchor.constraint(equalToSystemSpacingAfter: webView.leftAnchor, multiplier: 0).isActive = true
        self.view.bottomAnchor.constraint(equalToSystemSpacingBelow: webView.bottomAnchor, multiplier: 0).isActive = true
        self.view.rightAnchor.constraint(equalToSystemSpacingAfter: webView.rightAnchor, multiplier: 0).isActive = true
    }
}

extension OrderViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.request.url?.path == "/complete.html" {
            output.tapOrderCompleteButton()
            decisionHandler(.cancel)
            return
        }
        
        if navigationAction.request.url?.fragment == "continue" {
            output.tapContinueShoppingButton()
            decisionHandler(.cancel)
            return
        }
        
        decisionHandler(.allow)
    }
}
