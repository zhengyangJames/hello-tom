//
//  COCircleImageView.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 04/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class COCircleImageView: UIImageView {

    private var isSetUpLayer: Bool? = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isSetUpLayer == false {
            self.layer.cornerRadius = self.frame.size.height/2.0
            self.clipsToBounds = true
            isSetUpLayer = true
        }
    }

}
