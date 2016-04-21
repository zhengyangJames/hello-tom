//
//  COInvestorDropList.swift
//  CoAssetsApps
//
//  Created by Tony Tuong on 3/11/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class COInvestorDropList: CODropList {

    var completion: ((selected: InvestorListModel?) -> Void)?
    
    var selectedInvestor: InvestorListModel? {
        didSet {
            if let index = investor.indexOf({$0.code == selectedInvestor?.code}) {
                self.selectedIndex = index
            } else {
                self.selectedIndex = nil
            }
        }
    }
    
    var selectedCode: String? {
        didSet {
            if let index = investor.indexOf({$0.code == selectedCode}) {
                self.selectedIndex = index
            } else {
                self.selectedIndex = nil
            }
        }
    }
    
    var investor: [InvestorListModel] {
        return ProfileContainer.investorProfileModel.investorList
    }
    
    override func numberOfRows() -> Int {
        return investor.count
    }
    
    override func titleForRowAtIndex(index: Int) -> String {
        return  investor[index].stringFormat()
    }
    
    override func didSelectRowAtIndex(index: Int) {
        selectedInvestor = investor[index]
        completion?(selected: selectedInvestor)
    }
    
}
