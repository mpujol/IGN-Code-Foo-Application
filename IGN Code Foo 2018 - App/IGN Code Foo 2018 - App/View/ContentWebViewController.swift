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
       
        
        
        setUpViews()
        
        if let url = URL(string: "http://www.ign.com/videos/2018/03/27/far-cry-5-walkthrough-story-mission-the-cleansing") {
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
    
    var dismissButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(ContentWebViewController.dismissButtonPressed(sender:)), for: .touchUpInside)
        button.setTitle("Dismiss", for: .normal)
        button.setTitleColor(.white, for: UIControlState.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func dismissButtonPressed(sender: UIButton!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUpViews() {
        
        self.view.addSubview(webView)
        self.view.addSubview(dismissButton)
        
        self.view.addConstraintsWithFormat(format: "H:|[v0]|", views: webView)
        self.view.addConstraintsWithFormat(format: "V:|-[v0]-[v1(60)]-|", views: webView,dismissButton)
        
        self.view.addConstraints([NSLayoutConstraint(item: dismissButton, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.5, constant: 0)])
        self.view.addConstraints([NSLayoutConstraint(item: dismissButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)])
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {

    }

    func webViewDidFinishLoad(_ webView: UIWebView) {

    }
    
}
