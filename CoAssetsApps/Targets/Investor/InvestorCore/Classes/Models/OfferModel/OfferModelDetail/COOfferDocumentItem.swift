//
//  COOfferDocumentItem.swift
//  CoAssetsApps
//
//  Created by Macintosh HD on 3/14/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class COOfferDocumentItem: NSObject {
    var url = ""
    var title = ""
    init(object: JSON) {
        url = object[ServiceDefine.DocumentField.Url].string!
        title = object[ServiceDefine.DocumentField.Title].string!
    }
    init(title: String, url: String) {
        self.title = title
        self.url = url
    }
}
