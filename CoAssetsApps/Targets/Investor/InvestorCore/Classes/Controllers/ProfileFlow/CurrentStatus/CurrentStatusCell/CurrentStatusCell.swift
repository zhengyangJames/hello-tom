//
//  CurrentStatusCell.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 04/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

let kCurrentStatusTitle = "kCurrentStatusTitle"
let kCurrentStatusValue = "kCurrentStatusValue"

class CurrentStatusCell: BaseTableViewCell {

    @IBOutlet weak private var titleLabel: BaseLabel!
    @IBOutlet weak private var valueLabel: BaseLabel!
    
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
        self.titleLabel.text = self.data?.objectForKey(kCurrentStatusTitle) as? String
        self.valueLabel.text = self.stringForValue(self.data?.objectForKey(kCurrentStatusValue) as? Double)
    }
    
    private func stringForValue(value: Double?) -> String {
        if let value = value where value != 0 {
            // format #.##
            return "$" + String(value)
        } else {
            return "$0.00"
        }
    }
}
