//
//  COCurrencyInvestmentModel.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 14/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class COCurrencyInvestmentModel: NSObject {
    var currency = ""
    var amount: Double = 0
}
extension COCurrencyInvestmentModel {
    func importJsonData(key: String, value: JSON) {
         self.currency = key
        if let amount = value.double {
            self.amount = amount
        }
    }
}
