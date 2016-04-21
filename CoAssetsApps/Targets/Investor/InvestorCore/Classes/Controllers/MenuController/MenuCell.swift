//
//  MenuCell.swift
//  CoAssetsApps
//
//  Created by TruongVO07 on 3/2/16.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    
    static let menuHeight = CGFloat(44)
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: BaseLabel!
    @IBOutlet weak var totalNotificationLabel: COBubbleLabel!

    private var notificationManager: NotificationsManager {
        return NotificationsManager.shared
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        totalNotificationLabel.font = UIFont(name: AppDefine.AppFontName.COAvenirBlack, size: 14)
    }
    
    private func changeTintColor(color: UIColor = UIColor.blackColor()) {
        iconImageView.image = iconImageView.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        iconImageView.tintColor = color
        titleLabel.textColor = color
    }
    
    func setData(title: String, menu: Menu) {
        titleLabel.text = title
        let icon: UIImage = UIImage(named: menu.icon)!
        iconImageView.image = icon
        changeTintColor()
        if menu == .Notification && notificationManager.notificationModel.isEmpty == false {
            updateTotalNotificationLabel(self.notificationManager.notificationCount)
        } else {
            updateTotalNotificationLabel(0)
        }
    }
    
    func actionSelected(selected: Bool = true) {
        if selected {
            changeTintColor(AppDefine.AppColor.CORedHighlightColor)
        } else {
            changeTintColor()
        }
    }
    
    private func updateTotalNotificationLabel(total: NSInteger) {
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            self.totalNotificationLabel.badgeCount = total
        })
    }
    
}
