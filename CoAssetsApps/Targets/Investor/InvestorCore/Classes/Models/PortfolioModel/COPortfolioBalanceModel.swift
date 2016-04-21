//
//  COPortfolioBalanceModel.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 10/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class COPortfolioBalanceModel: NSObject {
    var balanceAmt: Float = 0
    var currency = ""
    var updated = ""
}
//MARK: - Import data
extension COPortfolioBalanceModel {
    func importJsonData(jsonData: JSON) {
        if jsonData[ServiceDefine.PortfolioBalanceField.BalanceAmt].isExists() {
            self.balanceAmt = jsonData[ServiceDefine.PortfolioBalanceField.BalanceAmt].floatValue
        }
        if let temp = jsonData[ServiceDefine.PortfolioBalanceField.Currency].string {
            self.currency = temp
        }
        if let temp = jsonData[ServiceDefine.PortfolioBalanceField.Updated].string {
            self.updated = temp
        }
    }
    
    func currencyName() -> String {
        guard let tempArray = ResourcesHelper.readPlistFile("Currency") else {
            return ""
        }
        for item in tempArray {
            let code = item["code"] as? String
            if code == currency {
                if let name = item["name"] as? String {
                    return name
                }
            }
        }
        return ""
    }
}
