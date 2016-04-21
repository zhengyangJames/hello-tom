//
//  ListContact.swift
//  CoAssetsApps
//
//  Created by Macintosh HD on 3/3/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class ListContact: COService {
    func getListContact( completion: COServiceDataCompletion?) {
        let path = ServiceDF.WSEndpoint + ServiceDefine.Method.GetCompanyInfo
        request(.GET, path) { (data, error) -> Void in
            if let myData = data {
                var dataArray = [COContactModel]()
                for item in myData.array! {
                     let contactModel = COContactModel()
                    contactModel.importDataJSON(item)
                    dataArray.append(contactModel)
                }
                completion?(data: dataArray, error: nil)
            } else {
                completion?(data: nil, error: error)
            }
        }
    }
    
    /* body contain question Text, OfferId*/
    func postQuestion(var body: [String:String], accessToken: String,
        completion: COServiceCompletion?) {
        let offerID = body[ServiceDefine.OfferField.OfferID]
        let path = ServiceDF.WSEndpoint + ServiceDefine.Method.PostQuestion +
            offerID! + "/"
        body.removeValueForKey(ServiceDefine.OfferField.OfferID)
        var header = [String:String]()
        header[ServiceDefine.HeadersKey.Authorization] = accessToken
        request(.POST, path, parameters: body, encoding: .URL, headers: header) {
            (data, error) -> Void in
            if let myData = data {
                completion?(data: myData, error: nil)
            } else {
                completion?(data: nil, error: error)
            }
        }
    }
    
    func getStockPrice(completion: COServiceDataCompletion?) {
        let path = ServiceDF.WSEndpoint + ServiceDefine.Method.GetStockPrice
        let header = createAuthHeaders()
        request(.GET, path, parameters: nil, encoding: .URL, headers: header) {
            (data, error) -> Void in
            if let error = error {
                completion?(data: nil, error: error)
            } else {
                let stock = COStockProfileModel()
                if let data = data {
                    stock.importJsonData(data)
                }
                completion?(data: stock, error: nil)
            }
        }
    }
    
    func postStockBuyShared(message: String, completion: COServiceCompletion?) {
        let path = ServiceDF.WSEndpoint + ServiceDefine.Method.PostStockBuyShared
        var body = [String:String]()
        body[ServiceDefine.OfferField.Message] = message
        request(.POST, path, parameters: body) { (data, error) -> Void in
            if let myData = data {
                completion?(data: myData, error: nil)
            } else {
                completion?(data: nil, error: error)
            }
        }
    }
}
