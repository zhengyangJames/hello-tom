//
//  COProjectPreferenceDropList.swift
//  CoAssetsApps
//
//  Created by Tony Tuong on 3/11/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class COProjectPreferenceDropList: CODropList {

    var completion: ((selected: ProjectListModel?) -> Void)?
    
    var selectedModel: ProjectListModel? {
        didSet {
            if let index = project.indexOf({$0.code == selectedModel?.code}) {
                self.selectedIndex = index
            } else {
                self.selectedIndex = nil
            }
        }
    }
    
    var selectedCode: String? {
        didSet {
            if let index = project.indexOf({$0.code == selectedCode}) {
                self.selectedIndex = index
            } else {
                self.selectedIndex = nil
            }
        }
    }
    
    var project: [ProjectListModel] {
        return ProfileContainer.investorProfileModel.projectList
    }
    
    override func numberOfRows() -> Int {
        return project.count
    }
    
    override func titleForRowAtIndex(index: Int) -> String {
        return  project[index].stringFormat()
    }
    
    override func didSelectRowAtIndex(index: Int) {
        selectedModel = project[index]
        completion?(selected: selectedModel)
    }

}
