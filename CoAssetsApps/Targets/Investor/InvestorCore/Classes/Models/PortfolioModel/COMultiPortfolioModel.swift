//
//  COMultiPortfolioModel.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 10/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class COMultiPortfolioModel: NSObject {
    var ongoingInvestment = [COCurrencyInvestmentModel]()
    var completeInvestment = [COCurrencyInvestmentModel]()
    var ongoingProject = 0
    var completeProject = 0
}

extension COMultiPortfolioModel {
    func importJsonData(data: JSON) {
        if let dicData = data[ServiceDefine.MultiPortfolioField.OngoingInvestment].dictionary {
            var othersData = [COCurrencyInvestmentModel]()
            for (key, subJson):(String, JSON) in dicData {
                let currencyModel = COCurrencyInvestmentModel()
                currencyModel.importJsonData(key, value: subJson)
                othersData.append(currencyModel)
            }
            ongoingInvestment = othersData
        }

        if let dicData = data[ServiceDefine.MultiPortfolioField.CompleteInvestment].dictionary {
            var othersData = [COCurrencyInvestmentModel]()
            for (key, subJson):(String, JSON) in dicData {
                let currencyModel = COCurrencyInvestmentModel()
                currencyModel.importJsonData(key, value: subJson)
                othersData.append(currencyModel)
            }
            completeInvestment = othersData
        }
        if data[ServiceDefine.MultiPortfolioField.OngoingProject].isExists() {
            self.ongoingProject = data[ServiceDefine.MultiPortfolioField.OngoingProject].intValue
        }
        if data[ServiceDefine.MultiPortfolioField.CompleteProject].isExists() {
            self.completeProject = data[ServiceDefine.MultiPortfolioField.CompleteProject].intValue
        }
    }
}

extension COMultiPortfolioModel {
    func nameOngoingProjectsImage() -> String {
        return "icon_loading"
    }
    func nameOngoingInvestmentImage() -> String {
        return "icon_money"
    }
    func nameCompletedProjectsImage() -> String {
        return "icon_home"
    }
    func nameCompletedInvestmentImage() -> String {
        return "icon_check_red"
    }
    func titleOngoingProjects() -> String {
        return m_local_string("Ongoing_Projects")
    }
    func titleOngoingInvestment() -> String {
        return m_local_string("Ongoing_Investment_Amount")
    }
    func titleCompletedProjects() -> String {
        return m_local_string("Funded_&_Completed_Projects")
    }
    func titleCompletedInvestment() -> String {
        return m_local_string("Funded_&_Completed_Investment_Amount")
    }
}
