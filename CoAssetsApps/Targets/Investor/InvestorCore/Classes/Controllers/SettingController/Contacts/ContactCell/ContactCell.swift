//
//  ContactCell.swift
//  CoAssetsApps
//
//  Created by Macintosh HD on 3/3/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    
    @IBOutlet weak var labelCoAssets: BaseLabel!
    @IBOutlet weak var labelReg: BaseLabel!
    @IBOutlet weak var labelAdress: BaseLabel!
    @IBOutlet weak var labelTell: BaseLabel!
    @IBOutlet weak var labelPostCode: BaseLabel!
    @IBOutlet weak var labelCountry: BaseLabel!
    @IBOutlet weak var labelCity: BaseLabel!
    @IBOutlet weak var labelCountrySecsion: BaseLabel!
    var cotactModel: COContactModel? {
        didSet {
            if let mycontact = cotactModel {
                loadData(mycontact)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
}

//MARK: Private
extension ContactCell {
    private func loadData(contact: COContactModel) {
        labelReg.text = contact.regNo
        labelCity.text = contact.city
        labelPostCode.text = contact.postalCode
        labelCountry.text = contact.country
        labelTell.text = contact.phoneNo
        labelAdress.text = contact.add1
        labelCoAssets.text = contact.name
        labelCountrySecsion.text = contact.country
    }
}
