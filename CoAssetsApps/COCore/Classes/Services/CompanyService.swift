//
//  CompanyService.swift
//  CoAssetsApps
//
//  Created by Tony Tuong on 3/6/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import Alamofire

class CompanyService: COService {
    
    func getCompanyProfile(completion: COServiceDataCompletion?) {
        let path = ServiceDF.WSEndpoint + ServiceDefine.Method.CompanyProfile
        let headers = createAuthHeaders()
        request(.GET, path, parameters: nil, encoding: .URL, headers: headers) { (data, error) -> Void in
            if let _ = data {
                completion?(data: nil, error: nil)
            } else {
                completion?(data: nil, error: error)
            }
        }
    }

    func postCompanyProfile(multipartFormData: COMultipartFormData, completion: COCompletion?) {
        let path = ServiceDF.WSEndpoint + ServiceDefine.Method.CompanyProfile
        let headers = createAuthHeaders()
        upload(.POST, path, headers: headers, multipartFormData: multipartFormData) { (success, error) -> Void in
            if let _ = error {
                completion?(success: false, error: error)
            } else {
                completion?(success: true, error: nil)
            }
        }

    }
 
    
    private func createDataFromParams(parameters: Dictionary<String, AnyObject>?, key: String) -> NSData {
        if let _ = parameters {
            let data = parameters![key]!.dataUsingEncoding(NSUTF8StringEncoding)
            if let tempData = data {
                return tempData
            }
        }
        return NSData()
    }
    
    private func getUrlFromParams(parameters: Dictionary<String, AnyObject>?, key: String) -> NSURL? {
        guard let myParam = parameters, url = myParam[key] as? String else {
            return nil
        }
        return NSURL(fileURLWithPath: url)
    }
    
}
