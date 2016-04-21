//
//  InvestorDefine.swift
//  CoAssetsApps
//
//  Created by TruongVO07 on 3/1/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import Foundation
import UIKit

// MARK: Define
struct InvestorDefine {
    
    static let ClientId     = "AoB2Dn2P93FFYkd2Hcd15opIaC9lIn8ciIPNg44O"
    static let ClientSecret = "E5SVOzDAICZ2fUJBx8uWFfb7eUZumkZ9QrSoCsLRgvAAQVEdMQ98TWyZdF07rQLbpX0sbJETOxsXJgoy2pUbpYlEQFnvHguPkFEH92fwHiAR2p6Yhxf1hwdTGkCruBKF"
}

extension InvestorDefine {
    static let htmlFrame = "<div style='font-size: 13px; font-family: Avenir-Book;'>%@"
}

// MARK: Func
func m_local_string(key: String) -> String {
    return NSLocalizedString(key, tableName: "CoAssetsInvestor", bundle: NSBundle.mainBundle(), value: "", comment: "")
}

extension InvestorDefine {
    struct USerdefaultKey {
        static let kDeviceTockenExitedOnSever = "kDeviceTockenExitedOnSeverAddBySanyi"
    }
}
