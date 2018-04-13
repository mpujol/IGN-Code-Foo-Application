//
//  WebView.swift
//  IGN Code Foo 2018 - App
//
//  Created by Michael Pujol on 4/9/18.
//  Copyright © 2018 Michael Pujol. All rights reserved.
//

import UIKit

class ContentWebViewController: UIViewController, UIWebViewDelegate {

    var contentURL: URL?
    
    override func viewDidLoad() {
       
        self.view.backgroundColor = .black
        setUpViews()
        if let url = contentURL {
            webView.loadRequest(URLRequest(url: url))
        }
    }

    lazy var webView: UIWebView = {
        let wv = UIWebView(frame: .zero)
        wv.translatesAutoresizingMaskIntoConstraints = false
        wv.backgroundColor = .black
        wv.delegate = self
        return wv
    }()
    
    func setUpViews() {
        self.view.addSubview(webView)
        self.view.addConstraintsWithFormat(format: "H:|[v0]|", views: webView)
        self.view.addConstraintsWithFormat(format: "V:|[v0]|", views: webView)
        
    }
        
}
