//
//  COStockProfileModel.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 09/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class COStockProfileModel: NSObject {
    var stockCode = ""
    var stockCurrency = ""
    var stockPrice = 0.0
    var stockPriceDate: String?
}
//MARK: - Import Data
extension COStockProfileModel {
    func importJsonData(jsonData: JSON) {
        if let temp = jsonData[ServiceDefine.StockProfileField.Code].string {
            self.stockCode = temp
        }
        if let temp = jsonData[ServiceDefine.StockProfileField.Currency].string {
            self.stockCurrency = temp
        }
        if jsonData[ServiceDefine.StockProfileField.Price].isExists() {
            self.stockPrice = jsonData[ServiceDefine.StockProfileField.Price].doubleValue
        }
        if let temp = jsonData[ServiceDefine.StockProfileField.PriceDate].string {
            self.stockPriceDate = temp
        }
    }
}
