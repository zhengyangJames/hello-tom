//
//  DropListVC.h
//  Albameet
//
//  Created by Linh NGUYEN on 5/9/15.
//  Copyright (c) 2015 Linh NGUYEN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CODropListVC : UIViewController

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, copy) void (^didSelect)(NSInteger);

+ (void)presentWithTitle:(NSString*)title data:(NSArray*)data selectedIndex:(NSInteger)index
                parentVC:(UIViewController*)parentVC didSelect:(void (^)(NSInteger))didSelect;

@end
