//
//  CODealDetailStatusModel.swift
//  CoAssetsApps
//
//  Created by Macintosh HD on 3/10/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class CODealDetailStatusModel: NSObject {
    var dealOngoingStatusIsPaid = false
    var dealOngoingStatusIsSigned = false
}

extension CODealDetailStatusModel {
    func importJsonData(jsonData: JSON) {
        if jsonData[ServiceDefine.InvestorDetailStatusField.DealOngoingStatusIsPaid].isExists() {
            self.dealOngoingStatusIsPaid = jsonData[ServiceDefine.InvestorDetailStatusField.DealOngoingStatusIsPaid].boolValue
        }
        
        if jsonData[ServiceDefine.InvestorDetailStatusField.DealOngoingStatusIsSigned].isExists() {
            self.dealOngoingStatusIsSigned = jsonData[ServiceDefine.InvestorDetailStatusField.DealOngoingStatusIsSigned].boolValue
        }
    }
}
