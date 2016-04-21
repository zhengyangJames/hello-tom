//
//  COPhoneDropList.swift
//  CoAssetsApps
//
//  Created by Linh NGUYEN on 3/11/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class PhoneModel {
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.code = json["code"].stringValue
    }
    var name: String!
    var code: String!
    
    func stringFormat() -> String {
        return  String("\(name) (+\(code))")
    }
    
    func shortStringFormat() -> String {
        return  "+" + String("\(code)")
    }
}

class COPhoneDropList: CODropList {
    
    var completion: ((selectedPhone: PhoneModel?) -> Void)?
    
    var selectedPhone: PhoneModel? {
        didSet {
            if let index = phones.indexOf({$0.code == selectedPhone?.code}) {
                self.selectedIndex = index
            } else {
                self.selectedIndex = nil
            }
        }
    }
    
    var selectedCode: String? {
        didSet {
            if let index = phones.indexOf({$0.code == selectedCode}) {
                self.selectedIndex = index
            } else {
                self.selectedIndex = nil
            }
        }
    }
    
    lazy var phones: [PhoneModel] = {
        guard let json = ResourcesHelper.readJSONFile("JsonPhoneCode") else {
            return []
        }
        guard let array = json.array else {
            return []
        }
        var items = [PhoneModel]()
        for json in array {
            items.append(PhoneModel(json: json))
        }
        return items
    }()
    
    override func numberOfRows() -> Int {
        return phones.count
    }
    
    override func titleForRowAtIndex(index: Int) -> String {
        return  phones[index].stringFormat()
    }
    
    override func didSelectRowAtIndex(index: Int) {
        selectedPhone = phones[index]
        completion?(selectedPhone: selectedPhone)
    }
}
