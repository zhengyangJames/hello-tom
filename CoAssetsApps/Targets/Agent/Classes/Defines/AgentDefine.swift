//
//  AgentDefine.swift
//  CoAssetsApps
//
//  Created by TruongVO07 on 3/1/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import Foundation

// MARK: Func
func m_local_string(key:String) -> String {
    return NSLocalizedString(key, tableName: "CoAssetsAgent", bundle: NSBundle.mainBundle(), value: "", comment: "")
}