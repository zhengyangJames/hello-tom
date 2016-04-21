//
//  COInvestoeDealDetailModel.swift
//  CoAssetsApps
//
//  Created by Macintosh HD on 3/10/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class COInvestorDealDetailModel: NSObject {
    var dealOngoingNextPayoutDate = ""
    var dealOngoingCurrency = ""
    var dealOngoingInvestAmount = 0.0
    var dealOngoingNextPayoutAmount = 0.0
    var dealOngoingPotentialReturnAmount = 0.0
    var dealOngoingPotentialReturnPercent = 0.0
    var dealOngoingProjectName = ""
    var dealOngoingStatus: CODealDetailStatusModel?
    var dealOngoingPaymentInstruction = ""
    var dealOngoingContractInstruction = ""
}

extension COInvestorDealDetailModel {
    func importJsonData(jsonData: JSON) {
        
        if jsonData[ServiceDefine.InvestorDealDetailField.DealOngoingNextPayoutDate].isExists() {
            if let temp = jsonData[ServiceDefine.InvestorDealDetailField.DealOngoingNextPayoutDate].string {
                self.dealOngoingNextPayoutDate = temp
            }
            if let temp = jsonData[ServiceDefine.InvestorDealDetailField.DealOngoingNextPayoutDate].int {
                self.dealOngoingNextPayoutDate = String(temp)
            }
        }
        
        if let temp = jsonData[ServiceDefine.InvestorDealDetailField.DealOngoingCurrency].string {
            self.dealOngoingCurrency = temp
        }
        
        if let temp = jsonData[ServiceDefine.InvestorDealDetailField.DealOngoingInvestAmount].double {
            self.dealOngoingInvestAmount = temp
        }
        
        if let temp = jsonData[ServiceDefine.InvestorDealDetailField.DealOngoingNextPayoutAmount].double {
            self.dealOngoingNextPayoutAmount = temp
        }
        
        if let temp = jsonData[ServiceDefine.InvestorDealDetailField.DealOngoingPotentialReturnAmount].double {
            self.dealOngoingPotentialReturnAmount = temp
        }
        
        if let temp = jsonData[ServiceDefine.InvestorDealDetailField.DealOngoingPotentialReturnPercent].double {
            self.dealOngoingPotentialReturnPercent = temp
        }
        
        if let temp = jsonData[ServiceDefine.InvestorDealDetailField.DealOngoingProjectName].string {
            self.dealOngoingProjectName = temp
        }
        
        if let _ = jsonData[ServiceDefine.InvestorDealDetailField.DealOngoingStatus].dictionary {
            let status = CODealDetailStatusModel()
            status.importJsonData(jsonData[ServiceDefine.InvestorDealDetailField.DealOngoingStatus])
            self.dealOngoingStatus = status
        }
        
        if let temp = jsonData[ServiceDefine.InvestorDealDetailField.DealOngoingPaymentInstruction].string {
            self.dealOngoingPaymentInstruction = temp
        }
        
        if let temp = jsonData[ServiceDefine.InvestorDealDetailField.DealOngoingContractInstruction].string {
            self.dealOngoingContractInstruction = temp
        }
        
    }
}
