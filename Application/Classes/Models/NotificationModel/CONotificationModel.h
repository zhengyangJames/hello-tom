//
//  CONotificationModel.h
//  CoAssets
//
//  Created by Nikmesoft_M007 on 11/16/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CONotificationDataModel;

@interface CONotificationModel : MTLModel<MTLJSONSerializing>
@property (nonatomic, strong) NSString *notifiAlert;
@property (nonatomic, strong) CONotificationDataModel *notifiData;

@end
