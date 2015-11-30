//
//  COOngoingStatusModel.h
//  CoAssets
//
//  Created by Macintosh HD on 11/19/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COOngoingStatusModel :  MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) BOOL dealOngoingStatusIsPaid;
@property (nonatomic, assign) BOOL dealOngoingStatusIsSigned;

@end
