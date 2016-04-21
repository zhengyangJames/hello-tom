//
//  FlowManger+OfferFlow.swift
//  CoAssetsApps
//
//  Created by Tony Tuong on 3/18/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

extension FlowManager {
    func getListOffer(completion: COCompletion?) {
        OfferService().getListOffer { (data, error) -> Void in
            if data != nil && error == nil {
                if let myData = data as? [COOfferModel] {
                    FlowManager.shared.home?.setData(myData)
                }
            }
            completion?(success: true, error: nil)
        }
    }
}
