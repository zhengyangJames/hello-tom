//
//  COAcitvityButton.swift
//  CoAssetsApps
//
//  Created by Linh NGUYEN on 3/18/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class COAcitvityButton: CORedButton {
    
    var animating = false
    var title: String?
    weak var activityIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .White
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(indicator)
        let heightCT = NSLayoutConstraint(item: indicator, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 1.0, constant: -10)
        let radioCT = NSLayoutConstraint(item: indicator, attribute: .Width, relatedBy: .Equal, toItem: indicator, attribute: .Height, multiplier: 1.0, constant: 0)
        let centerX = NSLayoutConstraint(item: indicator, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1.0, constant: 0)
        let centerY = NSLayoutConstraint(item: indicator, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0)
        indicator.addConstraints([radioCT])
        self.addConstraints([heightCT, centerX, centerY])
        self.activityIndicator = indicator
    }
    
    func startAnimating() {
        self.title = self.titleForState(.Normal)
        self.setTitle("", forState: .Normal)
        self.activityIndicator?.startAnimating()
    }
    
    func stopAnimating() {
        self.activityIndicator?.stopAnimating()
        self.setTitle(self.title, forState: .Normal)
    }
}
