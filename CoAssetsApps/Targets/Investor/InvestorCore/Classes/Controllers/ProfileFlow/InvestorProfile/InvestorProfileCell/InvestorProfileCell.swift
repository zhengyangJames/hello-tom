//
//  InvestorProfileCell.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 04/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

let kInvestorProfileTitle = "kInvestorProfileTitle"
let kInvestorProfileValue = "kInvestorProfileValue"

class InvestorProfileCell: BaseTableViewCell {
    
    @IBOutlet weak private var titleLabel: BaseLabel!
    @IBOutlet weak private var valueLabel: BaseLabel!
    var userInvestorProfile: COInvestorProfileModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        separatorFullWidth()
    }
    
    var data: NSDictionary? {
        didSet {
            if oldValue != self.data {
                refreshUI()
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.font = UIFont(
            name: AppDefine.AppFontName.COAvenirMedium,
            size: titleLabel.font.pointSize)
        valueLabel.font = UIFont(
            name: AppDefine.AppFontName.COAvenirBook,
            size: titleLabel.font.pointSize)
        
    }
    
    func refreshUI() {
        if NSThread.isMainThread() {
            updateUIInMainThread()
        } else {
            NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
                self.updateUIInMainThread()
            }
        }
    }
    
    private func updateUIInMainThread() {
        if let title = self.data?.objectForKey(kInvestorProfileTitle) as? String,
            detail = self.data?.objectForKey(kInvestorProfileValue) as? String {
                self.titleLabel.text = title
                self.valueLabel.text = detail
        }
    }
}
