//
//  COOfferDocumentModel.swift
//  CoAssetsApps
//
//  Created by TruongVO07 on 3/8/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit
import SwiftyJSON

class COOfferDocumentModel: NSObject {
    var legalAppointment = [COOfferDocumentItem]()
    var ownership = [COOfferDocumentItem]()
    var licenses = [COOfferDocumentItem]()
    var registrationFormList = [COOfferDocumentItem]()
    var declarationFormList = [COOfferDocumentItem]()
    var others = [COOfferDocumentItem]()
}

extension COOfferDocumentModel {
    func importJsonData(jsonData: JSON) {
        if let documents = jsonData[ServiceDefine.DocumentField.LegalAppointment].array {
            var documentData = [COOfferDocumentItem]()
            for object in documents {
                let documentItem = COOfferDocumentItem(object: object)
                documentData.append(documentItem)
            }
            self.legalAppointment = documentData
        }
        
        if let documents = jsonData[ServiceDefine.DocumentField.Ownership].array {
            var documentData = [COOfferDocumentItem]()
            for object in documents {
                let documentItem = COOfferDocumentItem(object: object)
                documentData.append(documentItem)
            }
            self.legalAppointment = documentData
        }
        
        if let documents = jsonData[ServiceDefine.DocumentField.Licenses].array {
            var documentData = [COOfferDocumentItem]()
            for object in documents {
                let documentItem = COOfferDocumentItem(object: object)
                documentData.append(documentItem)
            }
            self.legalAppointment = documentData
        }
        
        if let documents = jsonData[ServiceDefine.DocumentField.RegistrationFormList].array {
            var documentData = [COOfferDocumentItem]()
            for object in documents {
                let documentItem = COOfferDocumentItem(object: object)
                documentData.append(documentItem)
            }
            self.legalAppointment = documentData
        }
        
        if let documents = jsonData[ServiceDefine.DocumentField.DeclarationFormList].array {
            var documentData = [COOfferDocumentItem]()
            for object in documents {
                let documentItem = COOfferDocumentItem(object: object)
                documentData.append(documentItem)
            }
            self.legalAppointment = documentData
        }
        
        if let others = jsonData[ServiceDefine.DocumentField.Others].array {
            var othersData = [COOfferDocumentItem]()
            for object in others {
                let documentItem = COOfferDocumentItem(object: object)
                othersData.append(documentItem)
            }
            self.others = othersData
        }
    }
}
