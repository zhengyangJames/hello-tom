//
//  OfferService.swift
//  CoAssetsApps
//
//  Created by TruongVO07 on 3/4/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class OfferService: COService {
    func getListOffer(completion: COServiceDataCompletion?) {
        let path = ServiceDF.WSEndpoint + ServiceDefine.Method.GetListOffer
        request(.GET, path) { (data, error) -> Void in
            if let myerror = error {
                completion?(data: nil, error: myerror)
            } else {
                var offerDatas = [COOfferModel]()
                if let data = data, myData = data.array {
                    for jsonData in myData {
                        let offer = COOfferModel()
                        offer.importJsonData(jsonData)
                        offerDatas.append(offer)
                    }
                }
                completion?(data: offerDatas, error: nil)
            }
        }
    }
    
    func getOfferDetail(offerId: Int!, completion: COServiceDataCompletion?) {
        let path = ServiceDF.WSEndpoint + ServiceDefine.Method.GetListOffer + String(offerId) + "/"
        request(.GET, path) { (data, error) -> Void in
            if let myerror = error {
                completion?(data: nil, error: myerror)
            } else {
                if let myData = data {
                    let offer = COOfferModel()
                    offer.importJsonData(myData)
                    completion?(data: offer, error: error)
                } else {
                    completion?(data: nil, error: error)
                }
            }
        }
    }
    
    func postProjectFullInfo(offerId: Int, completion: COServiceDataCompletion?) {
        let path = ServiceDF.WSEndpoint + ServiceDefine.Method.ProjectFullInfo
        let headers = createAuthHeaders()
        var body = createParams()
        body[ServiceDefine.OfferField.OfferID] = String(offerId)
        request(.POST, path, parameters: body, encoding: .URL, headers: headers) {
            (data, error) -> Void in
            if let myerror = error {
                completion?(data: nil, error: myerror)
            } else {
                if let myData = data {
                    let projectFunInfo = COOfferProjectFunInfo()
                    projectFunInfo.importJsonData(myData)
                    completion?(data: projectFunInfo, error: nil)
                } else {
                    completion?(data: nil, error: error)
                }
            }
        }
    }
    
    func postOfferQuestion(offerId offerId: NSInteger, question: String, completion: COServiceDataCompletion?) {
        let idString = "\(offerId)"
        let path = ServiceDF.WSEndpoint + ServiceDefine.Method.PostQuestion + idString + "/"
        var params = createParams()
        params[ServiceDefine.OfferField.Question] = question
        let headers = createAuthHeaders()
         request(.POST, path, parameters: params, encoding: .URL, headers: headers) { (data, error) -> Void in
            if let myerror = error {
                completion?(data: nil, error: myerror)
            } else {
                print(data)
                if let message = data!["success"].string {
                    completion?(data: message, error: nil)
                } else {
                    completion?(data: m_local_string("MESSAGE_QUESTION_CONTENT"), error: nil)
                }
            }
        }
    }
    
    func postOfferSubscribe(offerId offerId: NSInteger, email: String, amount: String,
        completion: COServiceCompletion?) {
            let idString = "\(offerId)"
            let path = ServiceDF.WSEndpoint + ServiceDefine.Method.PostSubcribe +
                idString + "/"
            var params = createParams()
            params[ServiceDefine.UserField.Email] = email
            params[ServiceDefine.OfferField.Amount] = amount
            let headers = createAuthHeaders()
            request(.POST, path, parameters: params, encoding: .URL, headers: headers) {
                (data, error) -> Void in
                if let myerror = error {
                    completion?(data: nil, error: myerror)
                } else {
                    completion?(data: data, error: nil)
                }
            }
    }
}
