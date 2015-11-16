//
//  NotificationCell.h
//  CoAssets
//
//  Created by Nikmesoft_M007 on 11/16/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "CONotificationModel.h"
#import "CONotificationDataModel.h"

@interface NotificationCell : BaseTableViewCell
@property (strong, nonatomic) CONotificationModel *notifiModel;
@end
