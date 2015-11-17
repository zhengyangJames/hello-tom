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
    __weak IBOutlet UILabel *_lbContentAlert;
    __weak IBOutlet UILabel *_lbContentDate;
}


- (void)setNotifiModel:(CONotificationModel *)notifiModel {
    _notifiModel = notifiModel;
    
    if (_notifiModel != nil) {
        _lbAlert.text = _notifiModel.notifiAlert;
        _lbDate.text = [UIHelper formatStringDateToString:_notifiModel.notifiData.notifiDateTime];
    }
  
    
}

@end
