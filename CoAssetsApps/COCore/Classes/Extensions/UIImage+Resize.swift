//
//  UIImageExtenstion.swift
//  CoAssets-Agent
//
//  Created by TruongVO07 on 12/14/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func resizeToNewSize(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.drawInRect(CGRectMake(0, 0, size.width, size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
