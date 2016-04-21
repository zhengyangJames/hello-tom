//
//  COProfileInvestor.swift
//  CoAssetsApps
//
//  Created by Macintosh HD on 3/8/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class COInvestorProfileModel: NSObject {
    var investorType = "NRM"
    var projectType = "DEV"
    var countryPreference = ""
    var country = ""
    var duration = 0
    var targetAnnualizeReturn = 0
    var investment = 0
    var currencyPrference = "SGD"
    var descriptions = ""
    var website = ""
    var investmentBudget = "1000"
    var investorList: [InvestorListModel] {
        guard let arrayPlist = ResourcesHelper.readPlistFile("InvestorType") else {
            return []
        }
        let jsonData = JSON(arrayPlist)
        guard let array = jsonData.array else {
            return []
        }
        var items = [InvestorListModel]()
        for json in array {
            items.append(InvestorListModel(json: json))
        }
        return items
    }
    var projectList: [ProjectListModel] {
        guard let arrayPlist = ResourcesHelper.readPlistFile("ProjectType") else {
            return []
        }
        let jsonData = JSON(arrayPlist)
        guard let array = jsonData.array else {
            return []
        }
        var items = [ProjectListModel]()
        for json in array {
            items.append(ProjectListModel(json: json))
        }
        return items
    }
    var currenceList: [CurrencyListModel] {
        guard let arrayPlist = ResourcesHelper.readPlistFile("Currency") else {
            return []
        }
        let jsonData = JSON(arrayPlist)
        guard let array = jsonData.array else {
            return []
        }
        var items = [CurrencyListModel]()
        for json in array {
            items.append(CurrencyListModel(json: json))
        }
        return items
    }
}

//MARK: Filter List 
extension COInvestorDealDetailModel {
    
    private func getNameForType(list: [AnyObject], type: String) -> String {
        if let newList = list as? [CurrencyListModel] {
            let arrayData = newList.filter { $0.code == type.uppercaseString }
            return arrayData[0].name
        } else if let newList = list as? [ProjectListModel] {
            let arrayData = newList.filter { $0.code == type.uppercaseString }
            return arrayData[0].name
        } else if let newList = list as? [InvestorListModel] {
            let arrayData = newList.filter { $0.code == type.uppercaseString }
            return arrayData[0].name
        }
        return ""
    }
    
    private func getTypeForName(list: [AnyObject], name: String) -> String {
        if let newList = list as? [CurrencyListModel] {
            let arrayData = newList.filter { $0.name == name }
            return arrayData[0].code
        } else if let newList = list as? [ProjectListModel] {
            let arrayData = newList.filter { $0.name == name }
            return arrayData[0].code
        } else if let newList = list as? [InvestorListModel] {
            let arrayData = newList.filter { $0.name == name }
            return arrayData[0].code
        }
        return ""
    }
    
    
}

//MARK: Sub Model
class InvestorListModel {
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.code = json["code"].stringValue
    }
    var name: String!
    var code: String!
    
    func stringFormat() -> String {
        return  String("\(name)")
    }
}

class ProjectListModel {
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.code = json["code"].stringValue
    }
    var name: String!
    var code: String!
    
    
    func stringFormat() -> String {
        return  String("\(name)")
    }
}

class CurrencyListModel {
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.code = json["code"].stringValue
    }
    init(code: String, name: String) {
        self.code = code
        self.name = name
    }
    var name: String!
    var code: String!
    
    func stringFormat() -> String {
        return  String("\(name)")
    }
}

//MARK: Import Data To MODEL
extension COInvestorProfileModel {
    func importJsonData(jsonData: JSON) {
        if let temp = jsonData[ServiceDefine.UserProfileInvestorField.InvestorType].string {
            self.investorType = temp
        }
        
        if let temp = jsonData[ServiceDefine.UserProfileInvestorField.project].string {
            self.projectType = temp
        }
        
        if let arrCountries = jsonData[ServiceDefine.UserProfileInvestorField.countries].array {
            var projectlistPreference = String()
            for item in arrCountries {
                if projectlistPreference == "" {
                    projectlistPreference = item.description
                } else {
                    projectlistPreference = projectlistPreference + "," + item.description
                }
            }
            self.countryPreference = projectlistPreference
        }
    
        if let temp = jsonData[ServiceDefine.UserProfileInvestorField.country].string {
            self.country = temp
        }
        
        if let temp = jsonData[ServiceDefine.UserProfileInvestorField.duration].int {
            self.duration = temp
        }
        
        if let temp = jsonData[ServiceDefine.UserProfileInvestorField.target].int {
            self.targetAnnualizeReturn = temp
        }
        
        if let temp = jsonData[ServiceDefine.UserProfileInvestorField.investmentBudget].int {
            self.investment = temp
        }
        
        if let temp = jsonData[ServiceDefine.UserProfileInvestorField.CurrencyPreference].string {
            self.currencyPrference = temp
        }
        
        if let temp = jsonData[ServiceDefine.UserProfileInvestorField.descriptions].string {
            self.descriptions = temp
        }
        
        if let temp = jsonData[ServiceDefine.UserProfileInvestorField.website].string {
            self.website = temp
        }

    }
    
    func getNameForCode(type: ServiceDefine.InvestorListType) -> String {
        switch type {
            case .TypeInvestor : for item in investorList where item.code == investorType { return item.name }
            case .TypeCurrency : for item in currenceList where item.code == currencyPrference { return item.name }
            case .TypeProject : for item in projectList where item.code == projectType { return item.name }
        }
        return ""
    }
    
    func getCodeForName(type: ServiceDefine.InvestorListType, name: String? = nil) -> String {
        switch type {
        case .TypeInvestor : for item in investorList where item.name == name { return item.code }
        case .TypeCurrency : for item in currenceList where item.name == name { return item.code }
        case .TypeProject : for item in projectList where item.name == name { return item.code }
        }
        return ""
    }
}
