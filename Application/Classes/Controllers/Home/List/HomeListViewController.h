//
//  HomeListViewController.h
//  CoAssest
//
//  Created by Macintosh HD on 6/10/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseViewController.h"

@interface HomeListViewController : BaseViewController
@property (nonatomic, strong) NSString *notifiID;
- (void)setNotificationOfferId:(NSString *)offerId isCheckNotificationBanner:(BOOL)isCheck;
@end
