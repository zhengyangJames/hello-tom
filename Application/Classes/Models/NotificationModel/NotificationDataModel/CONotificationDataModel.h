//
//  CONotificationDataModel.h
//  CoAssets
//
//  Created by Nikmesoft_M007 on 11/16/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CONotificationDataModel : MTLModel<MTLJSONSerializing>
@property (nonatomic, strong) NSString *notifiStatus;
@property (nonatomic, strong) NSString *notifiUrl;
@property (nonatomic, strong) NSString *notifiDateTime;
@property (nonatomic, strong) NSString *notifiType;
@property (nonatomic, strong) NSNumber *notifiId;
@property (nonatomic, strong) NSString *notifiUnique;

- (NSString *)stringOfdata;
- (NSNumber *)numberOfId;
- (NSString *)stringOfUniqueId;
@end
