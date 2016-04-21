//
//  COService.swift
//  CoAssets-Agent
//
//  Created by Linh NGUYEN on 11/27/15.
//  Copyright © 2015 Nikmesoft_M009. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

typealias COServiceCompletion = (data: JSON?, error: NSError?) -> Void
typealias COServiceDataCompletion = (data: AnyObject?, error: NSError?) -> Void
typealias COCompletion = (success: Bool, error: NSError?) -> Void
typealias COMultipartFormData = (multipartData: MultipartFormData) -> Void

struct ErrorService {
    static let errorExpireToken = "Authentication credentials were not provided."
}

class COService: NSObject {
    private var countRefreshToken = 1
}

extension COService {
    
    func request(method: Alamofire.Method,
        _ urlString: URLStringConvertible,
        parameters: [String: AnyObject]? = nil,
        encoding: ParameterEncoding = .URL,
        headers: [String: String]? = nil,
        completion: COServiceCompletion?) {
        let request = Alamofire.request(method, urlString, parameters: parameters, encoding: encoding, headers: headers)
        print("--The Url-->\(request.request?.URLString)")
        request.response { (urlRequest: NSURLRequest?, response: NSHTTPURLResponse?, data: NSData?, error: NSError?) -> Void in
            print("--The Status Code-->\(response?.statusCode)")
            let error = self.parseError(response, error: error)
            let data = self.parseJSONData(data)
            if let data = data where data["detail"].stringValue == ErrorService.errorExpireToken {
                self.checkingRefreshToken(method, urlString, data: data, error: error, completion: completion)
            } else if let error = error {
                completion?(data: data, error: error)
            } else {
                completion?(data: data, error: nil)
            }
        }
    }
    
    func upload(method: Alamofire.Method,
        _ urlString: URLStringConvertible,
        headers: [String: String]? = nil,
        multipartFormData: COMultipartFormData,
        completion: COCompletion?) {
        Alamofire.upload(.POST, urlString,
            headers: headers,
            multipartFormData: { (multipartData: MultipartFormData) -> Void in
                multipartFormData(multipartData: multipartData)
            }) { (encodingResult: Manager.MultipartFormDataEncodingResult) -> Void in
            switch encodingResult {
            case .Success(let upload, _, _):
                upload.responseJSON { response in
                    print(response.response?.statusCode)
                    print(self.parseJSONData(response.data))
                    completion?(success: true, error: nil)
                }
            case .Failure:
                completion?(success: false, error: nil)
            }
        }
    }
    
    private func checkingRefreshToken(method: Alamofire.Method,
        _ urlString: URLStringConvertible,
        parameters: [String: AnyObject]? = nil,
        encoding: ParameterEncoding = .URL,
        data: JSON,
        error: NSError?,
        completion: COServiceCompletion?) {
        if self.countRefreshToken >= 1 {
            --self.countRefreshToken
            self.refreshToken({ (success, error) -> Void in
                if success == true {
                    let newHeaders = self.createAuthHeaders()
                    self.request(method, urlString, parameters: parameters, encoding: encoding, headers: newHeaders, completion: completion)
                } else {
                    AuthManager.shared.revokeAccessToken()
                    completion?(data:nil, error: error)
                }
            })
        } else {
            AuthManager.shared.revokeAccessToken()
            completion?(data:nil, error: error)
        }
    }
    
    private func refreshToken(completion: COCompletion?) {
        guard let refreshToken = SettingsContainer.refreshToken else {
            completion?(success: false, error: nil)
            return
        }
        let path = ServiceDF.WSTokenEndpoint
        var params = createParams()
        params[ServiceDefine.OAuth2Field.GrantType] = "refresh_token"
        params[ServiceDefine.OAuth2Field.ClientId] = InvestorDefine.ClientId
        params[ServiceDefine.OAuth2Field.ClientSecret] = InvestorDefine.ClientSecret
        params[ServiceDefine.OAuth2Field.RefreshToken] = refreshToken
        self.request(.POST, path, parameters: params) { (data, error) -> Void in
            if let error = error {
                completion?(success: false, error: error)
            } else {
                UserService.processOAuthResponse(data, completion: { () -> Void in
                    completion?(success: true, error: nil)
                })
            }
        }
    }
    
    private func parseError(response: NSHTTPURLResponse?, error: NSError?) -> NSError? {
        var message = ""
        if let tempError = error where tempError.code == -1009 {
            message = m_local_string("MESSAGE_ERROR_NETWORK")
            return NSError(domain: "COErrorDomain", code:0, userInfo: ["code": -1009, "message": message])
        } else {
            if response?.statusCode >= 400 {
                if error != nil {
                    message = (error?.description)!
                }
                return NSError(domain: "COErrorDomain", code:0, userInfo: ["code": 500, "message": message])
            } else {
                return error
            }
        }
    }
    
    private func parseJSONData(data: NSData?) -> JSON? {
        if data != nil {
            return JSON(data: data!)
        } else {
            return nil
        }
    }
    
    func createMultipartFormData() -> MultipartFormData {
        return MultipartFormData()
    }
    
    func createParams() -> Dictionary<String, String> {
        let params: [String: String] = Dictionary()
        return params
    }
    
    func createAuthHeaders() -> Dictionary<String, String> {
        var headers: [String: String] = Dictionary()
        if let accessToken = SettingsContainer.accessToken, tokenType = SettingsContainer.tokenType {
            headers[ServiceDefine.HeadersKey.Authorization] = String("\(tokenType) \(accessToken)")
        }
        return headers
    }
    
    func removeCaches() {
        NSURLCache.sharedURLCache().removeAllCachedResponses()
    }
}

class SynchronizedArray<T> {
    private var array: [T] = []
    private let accessQueue = dispatch_queue_create("SynchronizedArrayAccess", DISPATCH_QUEUE_SERIAL)
    var completion: ((Void) -> Void)?
    var progress: ((Float) -> Void)?
    var totalTasks: Int = 0
    
    func append(newElement: T) {
        dispatch_async(self.accessQueue) {
            self.array.append(newElement)
            self.totalTasks += 1
        }
    }
    
    func removeLast() {
        dispatch_async(self.accessQueue) {
            self.array.removeLast()
            if self.array.isEmpty {
                self.completion?()
            } else {
                self.progress?(Float(self.totalTasks - self.array.count)/Float(self.totalTasks))
            }
        }
    }
    
    subscript(index: Int) -> T {
        set {
            dispatch_async(self.accessQueue) {
                self.array[index] = newValue
            }
        }
        get {
            var element: T!
            
            dispatch_sync(self.accessQueue) {
                element = self.array[index]
            }
            
            return element
        }
    }
}
