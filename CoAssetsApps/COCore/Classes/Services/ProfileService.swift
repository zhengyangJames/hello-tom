//
//  ProfileService.swift
//  CoAssetsApps
//
//  Created by Tony Tuong on 3/6/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProfileService: COService {
    
    func getUserProfile(completion: COServiceDataCompletion?) {
        let path = ServiceDF.WSEndpoint + ServiceDefine.Method.GetProfile
        let headers = createAuthHeaders()
        request(.GET, path, parameters: nil, encoding: .URL, headers: headers) { (data, error) -> Void in
            if let error = error {
                completion?(data: nil, error: error)
            } else {
                ProfileContainer.storeUserProfileModel(data?.rawString())
                completion?(data: ProfileContainer.userProfileModel, error: nil)
            }
        }
    }
    
    func getInvestorProfile(completion: COServiceDataCompletion?) {
        let path = ServiceDF.WSEndpoint + ServiceDefine.Method.GetInvestorProfile
        let headers = createAuthHeaders()
        request(.GET, path, parameters: nil, encoding: .URL, headers: headers) { (data, error) -> Void in
            if let error = error {
                completion?(data: nil, error: error)
            } else {
                ProfileContainer.storeInvestorProfileModel(data?.rawString())
                completion?(data: ProfileContainer.investorProfileModel, error: nil)
            }
        }
    }
    
    func getCompanyProfile(completion: COServiceDataCompletion?) {
        let path = ServiceDF.WSEndpoint + ServiceDefine.Method.CompanyProfile
        let headers = createAuthHeaders()
        removeCaches()
        request(.GET, path, parameters: nil, encoding: .URL, headers: headers) { (data, error) -> Void in
            if let error = error {
                completion?(data: nil, error: error)
            } else {
                ProfileContainer.storeCompanyProfileModel(data?.rawString())
                completion?(data: ProfileContainer.companyProfileModel, error: nil)
            }
        }
    }
    
    func getInvestmentDashboard(completion: COServiceDataCompletion?) {
        let path = ServiceDF.WSEndpoint + ServiceDefine.Method.GetInvestmentDashboard
        let headers = createAuthHeaders()
        request(.GET, path, parameters: nil, encoding: .URL, headers: headers) {
            (data, error) -> Void in
            if let error = error {
                completion?(data: nil, error: error)
            } else {
                let investmentDashboard = COInvestmentDashboardModel()
                if let data = data {
                    investmentDashboard.importJsonData(data)
                }
                completion?(data: investmentDashboard, error: nil)
            }
        }
    }
    
    func getMultiFortfolio(completion: COServiceDataCompletion?) {
        let path = ServiceDF.WSEndpoint + ServiceDefine.Method.GetInvestmentDashboard
        let headers = createAuthHeaders()
        request(.GET, path, parameters: nil, encoding: .URL, headers: headers) {
            (data, error) -> Void in
            if let error = error {
                completion?(data: nil, error: error)
            } else {
                print("getMultiFortfolio--->\(data)")
                let multiPortfolio = COMultiPortfolioModel()
                if let data = data {
                    let diction = data[ServiceDefine.MultiPortfolioField.CurrencyMultiPort]
                   multiPortfolio.importJsonData(diction)
                }
                completion?(data: multiPortfolio, error: nil)
            }
        }
    }
    
    func getPortfolioCompletedWithdrawal(username: String, completion: COServiceDataCompletion?) {
        let path = ServiceDF.WSEndpoint + ServiceDefine.Method.ProtfolioWithdrawal + username + "/"
        let headers = createAuthHeaders()
        request(.GET, path, parameters: nil, encoding: .URL, headers: headers) { (data, error) -> Void in
            if let error = error {
                completion?(data: nil, error: error)
            } else {
                print("getPortfolioCompletedWithdrawal--->\(data)")
                var completeArray = [COPortfolioCompletedModel]()
                if let data = data {
                    for item in data {
                        let model = COPortfolioCompletedModel()
                        model.importWith(item.0, value: item.1.stringValue)
                        completeArray.append(model)
                    }
                }
                completion?(data: completeArray, error: nil)
            }
        }
    }
    
    func getPortfolioAllBalance(username: String, completion: COServiceDataCompletion?) {
        let path = ServiceDF.WSEndpoint + ServiceDefine.Method.ProtfolioGetAllBalance + username + "/"
        let headers = createAuthHeaders()
        request(.GET, path, parameters: nil, encoding: .URL, headers: headers) {
            (data, error) -> Void in
            if let error = error {
                completion?(data: nil, error: error)
            } else {
                print("getPortfolioAllBalance--->\(data)")
                var balanceArray = [COPortfolioBalanceModel]()
                if let datas = data {
                    for var i = 0; i < datas.count; ++i {
                        let balanceModel = COPortfolioBalanceModel()
                        balanceModel.importJsonData(datas[i])
                        balanceArray.append(balanceModel)
                    }
                }
                completion?(data: balanceArray, error: nil)
            }
        }
    }
    
}
//MARK: - update
extension ProfileService {
    func updateUserProfile(param: [String:String], completion: COCompletion?) {
        let path = ServiceDF.WSEndpoint + ServiceDefine.Method.GetProfile
        let headers = createAuthHeaders()
        removeCaches()
        request(.PUT, path, parameters: param, encoding: .URL, headers: headers) { (data, error) -> Void in
            if let error = error {
                completion?(success: false, error: error)
            } else {
                ProfileContainer.storeUserProfileModel(data?.rawString())
                completion?(success: true, error: nil)
            }
        }
    }
    
    func updateUserProfileInvestor(param: [String:String], completion: COCompletion?) {
        let path = ServiceDF.WSEndpoint + ServiceDefine.Method.GetInvestorProfile
        let headers = createAuthHeaders()
        removeCaches()
        request(.POST, path, parameters: param, encoding: .URL, headers: headers) { (data, error) -> Void in
            if let error = error {
                completion?(success: false, error: error)
            } else {
                ProfileContainer.storeInvestorProfileModel(data?.rawString())
                completion?(success: true, error: nil)
            }
        }
    }
    
    func getInvestorDeal(completion: COServiceDataCompletion?) {
        let path = ServiceDF.WSEndpoint + ServiceDefine.Method.GetInvestorDeal
        let headers = createAuthHeaders()
        var body = createParams()
        body[ServiceDefine.UserField.DeviceType] = ServiceDefine.NotificationKey.DeviceType
        body[ServiceDefine.UserField.ApplicationName] = ServiceDefine.NotificationKey.ApplicationNameGet
        request(.GET, path, parameters: body, encoding: .URLEncodedInURL, headers: headers) {(data, error) -> Void in
            if let error = error {
                completion?(data: nil, error: error)
            } else {
                let deal = COInvestorDealModel()
                deal.importJsonData(data!)
                completion?(data: deal, error: error)
            }
        }
    }

}
//MARK: - post
extension ProfileService {
    func postInvestedMessage(message: String, completion: COServiceCompletion?) {
        let path = ServiceDF.WSEndpoint + ServiceDefine.Method.PostStockBuyShared
        var body = createParams()
        body[ServiceDefine.InvestmentDashboardField.CustomMessage] = message
        let headers = createAuthHeaders()
        request(.POST, path, parameters: body, encoding: .URL, headers: headers) { (data, error) -> Void in
            if let error = error {
                completion?(data: data, error: error)
            } else {
                if let _ = data {
                    completion?(data: data, error: nil)
                } else {
                    completion?(data: nil, error: error)
                }
            }
        }
    }
    
    func postPortfolioWidthdraw(parameters: [String:String], completion: COServiceCompletion?) {
        let path = ServiceDF.WSEndpoint + ServiceDefine.Method.ProtfolioPostAllBalance
        let headers = createAuthHeaders()
        request(.POST, path, parameters: parameters, encoding: .URL, headers: headers) { (data, error) -> Void in
            if let error = error {
                completion?(data: data, error: error)
            } else {
                if let _ = data {
                    completion?(data: data, error: nil)
                } else {
                    completion?(data: nil, error: error)
                }
            }
        }
    }
    
}
