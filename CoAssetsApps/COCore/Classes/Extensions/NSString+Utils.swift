//
//  NSStringExtension.swift
//  CoAssets-Agent
//
//  Created by Linh NGUYEN on 12/12/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import Foundation
import UIKit

extension NSString {
    
    func urlEncode () -> String {
        let customAllowedSet =  NSCharacterSet(charactersInString:":/?#[]@!$&'()*+,;=").invertedSet
        return self.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!.stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)!
    }
    
    func urlDecode () -> String {
        return self.stringByRemovingPercentEncoding!
    }
    
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
}
