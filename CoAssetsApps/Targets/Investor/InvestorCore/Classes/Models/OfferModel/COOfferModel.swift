//
//  COOfferModel.swift
//  CoAssetsApps
//
//  Created by TruongVO07 on 3/4/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class COOfferModel: NSObject {
    var currency = ""
    var offerID: Int = 0
    var interested: NSNumber?
    var isPremiumListing = false
    var maxAnnualReturn = ""
    var minAnnualReturn = ""
    var minInvestment: NSNumber?
    var offerTitle = ""
    var offerType = ""
    var ownerType = ""
    var shortDescription = ""
    var tokensPerFancy = 0
    
    var companyLogo = ""
    var developerDescription = ""
    var status = ""
    var investorCount = 0
    var developerName = ""
    var howToCrowdFundPic = ""
    var projectDescription = ""
    var timehorizon = 0
    var annualReturn = ""
    var documents = COOfferDocumentModel()
    var project: COOfferProjectModel?
    
    var annualizedReturn: NSNumber?
    var dayleft: NSNumber?
    var pledged: NSNumber?
    var percentFunded: NSNumber?
}

extension COOfferModel {
    var shortDesc: NSAttributedString? {
        do {
            let html = NSString(format: InvestorDefine.htmlFrame, shortDescription)
            let str = try NSAttributedString(data: (html.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true))!, options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
            return str
        } catch {
            print(error)
        }
        return nil
    }
    
    var projectDesc: String {
        let html = NSString(format: InvestorDefine.htmlFrame, projectDescription)
        return html as String
    }
    
    var interectDesc: String {
        let stringCount = "\(investorCount)"
        return stringCount + " " + m_local_string("INVESTORS")
    }
    
    var dayLeftString: String {
        if let dayleft = dayleft {
            return "\(dayleft)" as String
        }
        return "N/A"
    }
    
    var timeHorizon: String {
        if timehorizon == 0 {
            return "N/A"
        }
        return "\(timehorizon)" as String + m_local_string("MONTHS")
    }
    
    var yieldDesc: String {
        if annualizedReturn == nil {
            return "N/A"
        } else {
            return "\(annualReturn)%(\(annualizedReturn!.doubleValue)%)"
        }
    }
    
    var minInvesmentTitle: String {
        if minInvestment == nil {
            return "N/A"
        } else {
            let str = FormattedHelper.formartDecimalFromNSNumber(minInvestment!.integerValue)
            return str!
        }
    }
    
    var minInvesmentNotNil: Double {
        if minInvestment == nil {
            return 0
        } else {
            return minInvestment!.doubleValue
        }
    }
    
    var minInvesmentDesc: String {
        if let current = ResourcesHelper.getStringCurrencyOfferWithKey(currency) {
            return m_local_string("MIN.INVESTMENT") + "(" + m_local_string(current) + ")"
        }
        return ""
    }
}

extension COOfferModel {
    var offerInterestedValue: String {
        if self.interested == nil {
            return ""
        } else {
            return self.interested!.stringValue
        }
    }
    var offerInterestedTitle: String {
        return m_local_string("offer_interested")
    }
    
    var offerMinInvesmentValue: String {
        return self.minInvesmentTitle.isEmpty ? "" : "\(self.currency) \(self.minInvesmentTitle)"
    }
    
    var offerMinInvesmentTitle: String {
        return m_local_string("offer_minimum_investment")
    }
    
    var offerMinAnnualValue: String {
        return self.minAnnualReturn.isEmpty ? "-" : "\(self.minAnnualReturn)%"
    }
    
    var offerMinAnnualTitle: String {
        return m_local_string("offer_annualized_yield")
    }
    
    var offerDayLeftValue: String {
        if self.dayleft == nil {
            return ""
        } else {
            return dayleft!.stringValue
        }
    }
    
    var offerDayLeftTitle: String {
        return m_local_string("offer_days_left")
    }
    
    var offerPledgedValue: String {
        if pledged == nil {
            return ""
        } else if let str = FormattedHelper.formartDecimalFromNSNumber(pledged!.integerValue) {
            return "\(self.currency) \(str)"
        }
        return ""
    }
    
    var offerPledgedTitle: String {
        return m_local_string("offer_pledged")
    }
    
    var offerFundedGoalValue: String {
        return self.percentFunded == nil ? "" : "\(FormattedHelper.formartFoatValueWithDeal(self.percentFunded!, min:2))%"
    }
    
    var offerFundedGoalTitle: String {
        return m_local_string("offer_funded")
    }

}

extension COOfferModel {
    func importJsonData(jsonData: JSON) {
        if let temp = jsonData[ServiceDefine.OfferObjectField.Currency].string {
            self.currency = temp
        }
        
        if jsonData[ServiceDefine.OfferObjectField.OfferId].isExists() {
            self.offerID = jsonData[ServiceDefine.OfferObjectField.OfferId].intValue
        }
        
        if jsonData[ServiceDefine.OfferObjectField.Interested].isExists() {
            self.interested = jsonData[ServiceDefine.OfferObjectField.Interested].intValue
        }
        
        if jsonData[ServiceDefine.OfferObjectField.IsPremiumListing].isExists() {
           self.isPremiumListing = jsonData[ServiceDefine.OfferObjectField.IsPremiumListing].boolValue
        }
        
        if let temp = jsonData[ServiceDefine.OfferObjectField.MaxAnnualReturn].string {
            self.maxAnnualReturn = temp
        }
        
        if let temp = jsonData[ServiceDefine.OfferObjectField.MinAnnualReturn].string {
            self.minAnnualReturn = temp
        }
        if jsonData[ServiceDefine.OfferObjectField.MinInvestment].isExists() {
            self.minInvestment = jsonData[ServiceDefine.OfferObjectField.MinInvestment].number
        }
        
        if let temp = jsonData[ServiceDefine.OfferObjectField.OfferTitle].string {
            self.offerTitle = temp
        }
        
        if let temp = jsonData[ServiceDefine.OfferObjectField.OfferType].string {
            self.offerType = temp
        }
        
        if let temp = jsonData[ServiceDefine.OfferObjectField.OwnerType].string {
            self.ownerType = temp
        }
        
        if let temp = jsonData[ServiceDefine.OfferObjectField.ShortDescription].string {
            self.shortDescription = temp
        }
        
        if let temp = jsonData[ServiceDefine.OfferObjectField.timeHorizon].int {
            self.timehorizon = temp
        }
        if jsonData[ServiceDefine.OfferObjectField.TokensPerFancy].isExists() {
            self.tokensPerFancy = jsonData[ServiceDefine.OfferObjectField.TokensPerFancy].intValue
        }
        
        if let _ = jsonData[ServiceDefine.OfferObjectField.Project].dictionary {
            let projectObject = COOfferProjectModel()
            projectObject.importJsonData(jsonData[ServiceDefine.OfferObjectField.Project])
            self.project = projectObject
        }
        
        if let temp = jsonData[ServiceDefine.OfferObjectField.CompanyLogo].string {
            self.companyLogo = temp
        }
        
        if let temp = jsonData[ServiceDefine.OfferObjectField.DeveloperDescription].string {
            self.developerDescription = temp
        }
        
        if let temp = jsonData[ServiceDefine.OfferObjectField.Status].string {
            self.status = temp
        }
        
        if jsonData[ServiceDefine.OfferObjectField.InvestorCount].isExists() {
            self.investorCount = jsonData[ServiceDefine.OfferObjectField.InvestorCount].intValue
        }
        
        if let temp = jsonData[ServiceDefine.OfferObjectField.DeveloperName].string {
            self.developerName = temp
        }
        
        if let temp = jsonData[ServiceDefine.OfferObjectField.HowToCrowdFundPic].string {
            self.howToCrowdFundPic = temp
        }
        
        if let _ = jsonData[ServiceDefine.OfferObjectField.Documents].dictionary {
            let documentObject = COOfferDocumentModel()
            documentObject.importJsonData(jsonData[ServiceDefine.OfferObjectField.Documents])
            self.documents = documentObject
        }
        
        if let temp = jsonData[ServiceDefine.OfferObjectField.projectDescription].string {
            self.projectDescription = temp
        }
        
        if jsonData[ServiceDefine.OfferObjectField.dayLeft].isExists() {
            self.dayleft = jsonData[ServiceDefine.OfferObjectField.dayLeft].number
        }
        
        if jsonData[ServiceDefine.OfferObjectField.timeHorizon].isExists() {
            self.timehorizon = jsonData[ServiceDefine.OfferObjectField.timeHorizon].intValue
        }
        
        if jsonData[ServiceDefine.OfferObjectField.annualizedReturn].isExists() {
            if let text = jsonData[ServiceDefine.OfferObjectField.annualizedReturn].string {
                let numberFormatter = NSNumberFormatter()
                self.annualizedReturn = numberFormatter.numberFromString(text)
            }
        }
        
        if let temp = jsonData[ServiceDefine.OfferObjectField.annualReturn].string {
            self.annualReturn = temp
        }
        
        if jsonData[ServiceDefine.OfferObjectField.percentFunded].isExists() {
            self.percentFunded = jsonData[ServiceDefine.OfferObjectField.percentFunded].number
        }
        
        if jsonData[ServiceDefine.OfferObjectField.pledged].isExists() {
            self.pledged = jsonData[ServiceDefine.OfferObjectField.pledged].number
        }
    }
}
