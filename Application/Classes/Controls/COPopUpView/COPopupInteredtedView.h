//
//  COPopupInteredtedView.h
//  CoAssets
//
//  Created by TUONG DANG on 7/7/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseView.h"

static NSInteger const kAnimationOptionCurveIOS7 = (7 << 16);

typedef void(^ActionOk)();

@interface COPopupInteredtedView : BaseView

@property (nonatomic, strong) void (^actionClosePopup)();

@property (strong, nonatomic) NSString *offerTitle;
+ (instancetype)showPopup:(NSString*)offerTitler;

@end
