//
//  ProjectView.swift
//  CoAssets-Agent
//
//  Created by Linh NGUYEN on 12/12/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class ProjectView: COTabView {
    weak var parentController: OfferDetailsController!
    @IBOutlet weak var webView: UIWebView!
    
    func reloadData() {
        webView.loadHTMLString(parentController.offerModel.projectDesc, baseURL: nil)
    }
}
