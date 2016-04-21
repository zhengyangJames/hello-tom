//
//  FQAPageCell.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/16/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import UIKit

class FAQPageCell: UITableViewCell {
    
    @IBOutlet weak private var titleLabel: UILabel!
    
    weak var parentController:FAQPageViewController?
    
    var structObject: AppDefine.FAQStruct? {
        didSet {
            if let myStruct = structObject {
                loadData(myStruct)
            }
        }
    }
}

//MARK: Action
extension FAQPageCell {
    func actionSelect(indexPath:NSIndexPath) {
        if structObject?.isShow == true {
            parentController?.deleteRowFromIndexPath(indexPath)
            updateTitleColor(AppDefine.AppColor.COBlackColor)
        } else {
            parentController?.insertRowFromIndexPath(indexPath)
            updateTitleColor(AppDefine.AppColor.CORedColor)
        }
        structObject!.isShow = !structObject!.isShow
    }
}

//MARK: Private
extension FAQPageCell {
    private func loadData(str: AppDefine.FAQStruct) {
        titleLabel.text = str.title
        if str.isShow {
            updateTitleColor(AppDefine.AppColor.CORedColor)
        } else {
            updateTitleColor(AppDefine.AppColor.COBlackColor)
        }
    }
    
    private func updateTitleColor(color:UIColor) {
        titleLabel?.textColor = color
    }
}
