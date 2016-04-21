//
//  COCurrencyDropList.swift
//  CoAssetsApps
//
//  Created by Tony Tuong on 3/11/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class COCurrencyDropList: CODropList {

    var completion: ((selected: CurrencyListModel?) -> Void)?
    
    var selectedModel: CurrencyListModel? {
        didSet {
            if let index = currency.indexOf({$0.code == selectedModel?.code}) {
                self.selectedIndex = index
            } else {
                self.selectedIndex = nil
            }
        }
    }
    
    var selectedCode: String? {
        didSet {
            if let index = currency.indexOf({$0.code == selectedCode}) {
                self.selectedIndex = index
            } else {
                self.selectedIndex = nil
            }
        }
    }
    
    var currency: [CurrencyListModel] = ProfileContainer.investorProfileModel.currenceList
    
    override func numberOfRows() -> Int {
        return currency.count
    }
    
    override func titleForRowAtIndex(index: Int) -> String {
        return  currency[index].stringFormat()
    }
    
    override func didSelectRowAtIndex(index: Int) {
        selectedModel = currency[index]
        completion?(selected: selectedModel)
    }


}
