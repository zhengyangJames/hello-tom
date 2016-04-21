//
//  COLabelLanguage.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 04/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class COLabelLanguage: UILabel {

    //MARK: Override
    override func awakeFromNib() {
        super.awakeFromNib()
        if let text = self.text where text.trim().isEmpty {
            self.text = m_local_string(text)
        }  
    }
}
