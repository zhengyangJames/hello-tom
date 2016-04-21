//
//  COInvestmentDashboardModel.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 09/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class COInvestmentDashboardModel: NSObject {
    var ongoing = 0.0
    var funded = 0.0
    var completed = 0.0
    var realised = 0.0
    var potential = 0.0

}
//MARK: - Import Data
extension COInvestmentDashboardModel {
    func importJsonData(jsonData: JSON) {
        if jsonData[ServiceDefine.InvestmentDashboardField.OngoingInvestment].isExists() {
            self.ongoing = jsonData[ServiceDefine.InvestmentDashboardField.OngoingInvestment]
                .doubleValue
        }
        if jsonData[ServiceDefine.InvestmentDashboardField.FundedInvestment].isExists() {
            self.funded = jsonData[ServiceDefine.InvestmentDashboardField.FundedInvestment]
                .doubleValue
        }
        if jsonData[ServiceDefine.InvestmentDashboardField.CompletedInvestment].isExists() {
            self.completed = jsonData[ServiceDefine.InvestmentDashboardField.CompletedInvestment]
                .doubleValue
        }
        if jsonData[ServiceDefine.InvestmentDashboardField.RealisedPayouts].isExists() {
            self.realised = jsonData[ServiceDefine.InvestmentDashboardField.RealisedPayouts]
                .doubleValue
        }
        if jsonData[ServiceDefine.InvestmentDashboardField.PotentialPayouts].isExists() {
            self.potential = jsonData[ServiceDefine.InvestmentDashboardField.PotentialPayouts]
                .doubleValue
        }
    }
}
