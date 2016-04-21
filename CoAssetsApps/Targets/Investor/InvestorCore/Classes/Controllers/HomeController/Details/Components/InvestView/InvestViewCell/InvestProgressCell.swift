//
//  InvestProgressCell.swift
//  CoAssetsApps
//
//  Created by TruongVO07 on 3/9/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class InvestProgressCell: UITableViewCell {

    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var offerFunInfo: COOfferProjectFunInfo? {
        didSet {
            loadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if isiOSVersion("7.0") {
            let transform = CGAffineTransformMakeScale(1.0, 10.5)
            progressBar.transform = transform
        } else {
            let transform = CGAffineTransformMakeScale(1.0, 1.5)
            progressBar.transform = transform
        }
        progressBar.layer.cornerRadius = 5
        progressBar.clipsToBounds = true
        progressBar.layer.masksToBounds = true
        progressBar.progressTintColor = AppDefine.AppColor.COLightYellow
    }
    
    func loadData() {
        goalLabel.text = offerFunInfo?.goalDesc
        totalLabel.text = offerFunInfo?.totalDesc
        currentLabel.text = offerFunInfo?.currentDesc
        
        let value = (offerFunInfo!.goal * 10)/1000
        progressBar.setProgress(Float(value), animated: false)
    }
    
    func isiOSVersion(version: String) -> Bool {
        return (UIDevice.currentDevice().systemVersion.compare(version, options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedSame)
    }
    
}
