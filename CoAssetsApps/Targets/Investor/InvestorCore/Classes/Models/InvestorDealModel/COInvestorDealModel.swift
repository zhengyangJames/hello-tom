//
//  InvestorDeslModel.swift
//  CoAssetsApps
//
//  Created by Macintosh HD on 3/10/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class COInvestorDealModel: NSObject {
    
    var fundedArray = [COInvestorDealDetailModel]()
    var completedArray = [COInvestorDealDetailModel]()
    var ongoingArray = [COInvestorDealDetailModel]()
}



extension COInvestorDealModel {
    func importJsonData(jsonData: JSON) {
        if let arr = jsonData[ServiceDefine.InvestorDealField.Funded].array {
            var dataArray = [COInvestorDealDetailModel]()
            for data in arr {
                let fundedJson = COInvestorDealDetailModel()
                fundedJson.importJsonData(data)
                dataArray.append(fundedJson)
            }
            self.fundedArray = dataArray
        }
        
        if let arr = jsonData[ServiceDefine.InvestorDealField.Completed].array {
            var dataArray = [COInvestorDealDetailModel]()
            for item in arr {
                let completeJson = COInvestorDealDetailModel()
                completeJson.importJsonData(item)
                dataArray.append(completeJson)
            }
            self.completedArray = dataArray
        }
        
        if let arr = jsonData[ServiceDefine.InvestorDealField.Ongoing].array {
            var dataArray = [COInvestorDealDetailModel]()
            for item in arr {
                let ongoingJson = COInvestorDealDetailModel()
                ongoingJson.importJsonData(item)
                dataArray.append(ongoingJson)
            }
            self.ongoingArray = dataArray
        }
    }
}
