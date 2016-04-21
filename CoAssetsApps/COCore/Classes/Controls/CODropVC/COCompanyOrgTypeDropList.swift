//
//  COCompanyOrgTypeDropList.swift
//  CoAssetsApps
//
//  Created by Tony Tuong on 3/12/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class CompanyOrgModel {
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.code = json["code"].stringValue
    }
    var name: String!
    var code: String!
    
    func stringFormat() -> String {
        return  String("\(name)")
    }
}

class COCompanyOrgTypeDropList: CODropList {

    var completion: ((selected: CompanyOrgModel?) -> Void)?
    
    var selectedModel: CompanyOrgModel? {
        didSet {
            if let index = companyOrgs.indexOf({ $0.code == selectedModel?.code }) {
                self.selectedIndex = index
            } else {
                self.selectedIndex = nil
            }
        }
    }
    
    var selectedOrgType: String? {
        didSet {
            if let index = companyOrgs.indexOf({$0.code == selectedOrgType}) {
                self.selectedIndex = index
            } else {
                self.selectedIndex = nil
            }
        }
    }
    
    lazy var companyOrgs: [CompanyOrgModel] = {
        guard let arrayPlist = ResourcesHelper.readPlistFile("CompanyOrgType") else {
            return []
        }
        let jsonData = JSON(arrayPlist)
        guard let array = jsonData.array else {
            return []
        }
        var items = [CompanyOrgModel]()
        for json in array {
            items.append(CompanyOrgModel(json: json))
        }
        return items
    }()
    
    override func numberOfRows() -> Int {
        return companyOrgs.count
    }
    
    override func titleForRowAtIndex(index: Int) -> String {
        return  companyOrgs[index].stringFormat()
    }
    
    override func didSelectRowAtIndex(index: Int) {
        selectedModel = companyOrgs[index]
        completion?(selected: selectedModel)
    }
    
}
