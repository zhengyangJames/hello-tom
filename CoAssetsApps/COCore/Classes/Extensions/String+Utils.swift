//
//  StringExtension.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/25/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import Foundation
import UIKit
extension String {
    
    init(htmlEncodedString: String) {
        let encodedData = htmlEncodedString.dataUsingEncoding(NSUTF8StringEncoding)!
        let attributedOptions: [String: AnyObject] = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding
        ]
        
        var attributedString: NSAttributedString?
        
        do {
            attributedString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
        } catch {
            print(error)
        }
        
        self.init(attributedString!.string)
    }
    
    func substring(from: Int) -> String {
        return self.substringFromIndex(self.startIndex.advancedBy(from))
    }
    
    var length: Int {
        return self.characters.count
    }
    
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
    static func className(aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).componentsSeparatedByString(".").last!
    }
    
    func trimmingCharacters(stringWillTrim: String) -> String {
        let characterSet: NSCharacterSet = NSCharacterSet(charactersInString: stringWillTrim )
        return self.stringByTrimmingCharactersInSet( characterSet )
            .stringByReplacingOccurrencesOfString( " ", withString: "" ) as String
    }
}
