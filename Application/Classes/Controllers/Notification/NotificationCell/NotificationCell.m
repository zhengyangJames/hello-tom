//
//  NotificationCell.m
//  CoAssets
//
//  Created by Nikmesoft_M007 on 11/16/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "NotificationCell.h"


@implementation NotificationCell {
    __weak IBOutlet UILabel *_lbDate;
    __weak IBOutlet UILabel *_lbAlert;
    __weak IBOutlet UIImageView *_iconNotifi;
}

- (void)setNotifiModel:(CONotificationModel *)notifiModel {
    _notifiModel = notifiModel;
    [self _loadIconNotification:notifiModel];
    if (_notifiModel != nil) {
        if ([notifiModel.notifiData.notifiStatus isEqual: NOTIFI_UNREAD]) {
            self.backgroundColor = KBACKGROUND_COLOR;
        } else {
            self.backgroundColor = [UIColor whiteColor];
        }
        _lbAlert.text = _notifiModel.notifiAlert;
        _lbDate.text = [UIHelper formatStringDateToString:_notifiModel.notifiData.notifiDateTime];
    }
}

- (void)_loadIconNotification:(CONotificationModel *)notifi {
    if ([notifi.notifiData.notifiType isEqual:NOTIFI_ICON_OFFER]) {
        _iconNotifi.image = [UIImage imageNamed:@"offer"];
    } else if ([notifi.notifiData.notifiType isEqual:NOTIFI_ICON_LANDINGPG]) {
        _iconNotifi.image = [UIImage imageNamed:@"landingpg"];
    } else if ([notifi.notifiData.notifiType isEqual:NOTIFI_ICON_GENERAL]) {
         _iconNotifi.image = [UIImage imageNamed:@"general"];
    } else if ([notifi.notifiData.notifiType isEqual:NOTIFI_ICON_EVENT]) {
        _iconNotifi.image = [UIImage imageNamed:@"event"];
    }
}


@end
