//
//  UIViewExtension.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/16/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    class func awakeFromNib(nibName: String, bundle: NSBundle? = nil) -> UIView? {
        return UINib(nibName: nibName, bundle: bundle)
            .instantiateWithOwner(nil, options: nil)[0] as? UIView
    }
    
    class func awakeFromNib(bundle: NSBundle? = nil) -> UIView? {
        return UINib(nibName: self.className, bundle: bundle)
            .instantiateWithOwner(nil, options: nil)[0] as? UIView
    }
}
