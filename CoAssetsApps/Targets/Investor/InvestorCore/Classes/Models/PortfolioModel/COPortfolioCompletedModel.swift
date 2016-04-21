//
//  COPortfolioCompletedModel.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 10/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class COPortfolioCompletedModel: NSObject {
    var keyComplete = ""
    var valueComplete: Float = 0
}

extension COPortfolioCompletedModel {
    func importJsonData(jsonData: JSON) {
        if let temp = jsonData[ServiceDefine.PortfolioCompleteField.Key].string {
            self.keyComplete = temp
        }
        
        if jsonData[ServiceDefine.PortfolioCompleteField.Value].isExists() {
            self.valueComplete = jsonData[ServiceDefine.PortfolioCompleteField.Value].floatValue
        }
    }
    func importWith(key: String?, value: String?) {
        if let key = key {
            self.keyComplete = key
        }
        if let value = value {
            self.valueComplete = Float(value)!
        }
    }
}
