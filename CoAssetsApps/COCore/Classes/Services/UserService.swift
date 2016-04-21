//
//  UserService.swift
//  CoAssets-Agent
//
//  Created by Linh NGUYEN on 11/27/15.
//  Copyright © 2015 Nikmesoft_M009. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserService: COService {
    
    func startOAuthLogin(var params: [String:String], completion: COServiceCompletion?) {
        let path = ServiceDF.WSTokenEndpoint
        params[ServiceDefine.OAuth2Field.ClientId] = InvestorDefine.ClientId
        params[ServiceDefine.OAuth2Field.ClientSecret] = InvestorDefine.ClientSecret
        params[ServiceDefine.OAuth2Field.GrantType] = "password"
        request(.POST, path, parameters: params) { (data, error) -> Void in
            if let myError = error {
                completion?(data: nil, error: myError)
            } else {
                UserService.processOAuthResponse(data, completion: { () -> Void in
                    completion?(data: data, error: nil)
                })
            }
        }
    }
    
    func registerUser(params: [String:String], completion: COCompletion?) {
        let path = ServiceDF.WSEndpoint + ServiceDefine.Method.RegisterUser
        request(.POST, path, parameters: params, encoding: .URL, headers: nil) { (data, error) -> Void in
            if let _ = error {
                completion?(success: false, error: error)
            } else {
                completion?(success: true, error: nil)
            }
        }
    }
    
    func forgotPassword(email: String, completion: COCompletion?) {
        let path = ServiceDF.WSEndpoint + ServiceDefine.Method.ForgetPassword
        var body = createParams()
        body[ServiceDefine.UserField.Email] = email
        request(.POST, path, parameters: body) { (data, error) -> Void in
            if let _ = error {
                completion?(success: false, error: error)
            } else {
                completion?(success: true, error: nil)
            }
        }
    }
    
    func updatePassword(params: [String:String], completion: COServiceCompletion?) {
        let path = ServiceDF.WSEndpoint + ServiceDefine.Method.ChangePassword
        let headers = createAuthHeaders()
        request(.POST, path, parameters: params, encoding: .URL, headers: headers) { (data, error) -> Void in
            if let _ = error {
                completion?(data: nil, error: error)
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

//MARK: - Userdefault
extension UserService {
    class func processOAuthResponse(data: JSON?, completion:() -> Void) {
        if let myData = data {
            if let token = myData["access_token"].string {
                SettingsContainer.accessToken = token
            }
            if let typeToken = myData["token_type"].string {
                SettingsContainer.tokenType = typeToken
            }
            if let refreshToken = myData["refresh_token"].string {
                SettingsContainer.refreshToken = refreshToken
            }
            completion()
        }
    }
}
