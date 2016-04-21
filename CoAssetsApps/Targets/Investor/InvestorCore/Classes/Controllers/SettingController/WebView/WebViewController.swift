//
//  WebViewController.swift
//  CoAssetsApps
//
//  Created by Macintosh HD on 3/3/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class WebViewController: BaseViewController {
    
    @IBOutlet weak private var webView: UIWebView!
    var webLink: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadWebView()
    }
    
    private func setupUI() {
        setupRightNavigation()
        if let _ = self.presentingViewController {
            setupLeftNavigation()
        } else {
            self.hiddenCustomBackButton()
        }
    }
    
    deinit {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
}

//MARK: Private
extension WebViewController {
    private func setupRightNavigation() {
        let safari = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action,
            target: self, action: "actionLoadSF:")
        self.navigationItem.rightBarButtonItem = safari
    }
    
    private func setupLeftNavigation() {
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
        backButton.setImage(UIImage(named: "icon_back"), forState: UIControlState.Normal)
        backButton.addTarget(self, action: "actionBack", forControlEvents: UIControlEvents.TouchUpInside)
        let barButton = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    func loadWebView() {
        if let myWebLink = webLink, url = NSURL(string: myWebLink) {
            let request = NSURLRequest(URL: url)
            webView.delegate = self
            webView.loadRequest(request)
        }
    }
    
}

//MARK: Action
extension WebViewController {
    func actionLoadSF(sender: AnyObject) {
        if let myWebLink = webLink, url = NSURL(string: myWebLink) {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    func actionBack() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

//MARK: UIWebViewDelegate
extension WebViewController: UIWebViewDelegate {
    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        if webView.loading == false {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
}
