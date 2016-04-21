//
//  StringHelper.swift
//  CoAssetsApps
//
//  Created by Tony Tuong on 3/10/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class StringHelper: NSObject {
    
    static func widthOfString(str: String, font: UIFont) -> CGFloat {
        var str_ = str
        if str_.isEmpty == true {
            str_ = ""
        }
        let attribute = NSDictionary(object: font, forKey: NSFontAttributeName)
        return NSAttributedString(string: str_, attributes: attribute as? [String : AnyObject]).size().width
    }
    
    static func encodeCharacter(urlString: String, characterEncode: String) -> String {
        guard let urlEncode = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet(charactersInString: characterEncode).invertedSet) else { return urlString }
        return urlEncode
    }
    
}
