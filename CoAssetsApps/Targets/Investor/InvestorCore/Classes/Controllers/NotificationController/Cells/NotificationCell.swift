//
//  NotificationCell.swift
//  CoAssetsApps
//
//  Created by Nikmesoft_M008 on 03/03/2016.
//  Copyright © 2016 TruongVO07. All rights reserved.
//

import UIKit

class NotificationCell: BaseTableViewCell {

    @IBOutlet weak private var dateLabel: BaseLabel!
    @IBOutlet weak private var alertLabel: BaseLabel!
    @IBOutlet weak private var iconImageView: UIImageView!
    @IBOutlet weak private var dotView: RedView!
    
    var notificationObject: CONotificationModel! {
        didSet {
            reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dateLabel.textColor = AppDefine.AppColor.COOrangeColor
        dotView.layer.cornerRadius = 5
        separatorFullWidth()
    }
    
    func reloadData() {
        iconImageView.image = UIImage(named: notificationObject.type.icon)
        alertLabel.text = notificationObject.alert
        dateLabel.text = DateHelper.notificationGMTDateFormater(notificationObject.item.dateTimeCreated)
        dotView.hidden = notificationObject.status.isRead
    }
}
