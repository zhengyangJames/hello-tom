//
//  COOfferProjectFunInfo.swift
//  CoAssetsApps
//
//  Created by TruongVO07 on 3/8/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class COOfferProjectFunInfo: NSObject {
    var currentFundedAmount = 0.0
    var dayLeft = ""
    var goal = 0.0
    var neededAmount = 0.0
}

extension COOfferProjectFunInfo {
    var currentDesc: String {
        let str = FormattedHelper.formartDecimalFromNSNumber(NSNumber(double: currentFundedAmount))
        return "$" + str!
    }
    
    var totalDesc: String {
        let str = FormattedHelper.formartDecimalFromNSNumber(NSNumber(double: neededAmount))
        return m_local_string("OF") + "$" + str!
    }
    
    var goalDesc: String {
        let goalString = FormattedHelper.formartFoatValueWithPortfolio(NSNumber(double: goal)) + "%"
        return goalString + m_local_string("GOAL")
    }
    
    var goalValue: String {
        if goal == 0.0 {
            return ""
        } else {
            return "\(goal)"
        }
    }
}

extension COOfferProjectFunInfo {
    func importJsonData(jsonData: JSON) {
        if jsonData[ServiceDefine.ProjectFunInfoField.CurrentFundedAmount].isExists() {
            self.currentFundedAmount = jsonData[ServiceDefine.ProjectFunInfoField.CurrentFundedAmount].doubleValue
        }
        
        if let temp = jsonData[ServiceDefine.ProjectFunInfoField.DayLeft].string {
            self.dayLeft = temp
        }
        
        if jsonData[ServiceDefine.ProjectFunInfoField.Goal].isExists() {
            self.goal = jsonData[ServiceDefine.ProjectFunInfoField.Goal].doubleValue
        }
        
        if jsonData[ServiceDefine.ProjectFunInfoField.NeededAmount].isExists() {
            self.neededAmount = jsonData[ServiceDefine.ProjectFunInfoField.NeededAmount].doubleValue
        }
    }

}
