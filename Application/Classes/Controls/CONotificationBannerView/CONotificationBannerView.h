//
//  CONotificationBannerView.h
//  CoAssets
//
//  Created by Tony Tuong on 10/20/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"

@protocol CONotificationBannerViewDelegate;

@interface CONotificationBannerView : BaseView
@property (strong, nonatomic) NSString *textMessage;
@property (weak, nonatomic) id<CONotificationBannerViewDelegate> delegate;
- (void)show;
- (void)delayPerform;
@end

@protocol CONotificationBannerViewDelegate <NSObject>

@optional
- (void)notificationBannerViewShow:(CONotificationBannerView*)notificationView;
- (void)notificationBannerViewDissmis:(CONotificationBannerView*)notificationView;

@end