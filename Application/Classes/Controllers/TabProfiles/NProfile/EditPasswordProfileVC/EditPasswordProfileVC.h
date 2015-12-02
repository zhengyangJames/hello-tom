//
//  EditPasswordProfileVC.h
//  CoAssets
//
//  Created by Tony Tuong on 10/2/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@protocol PasswordTableViewCellDelegate;

@interface EditPasswordProfileVC : BaseViewController

@property (weak, nonatomic) id<PasswordTableViewCellDelegate> delegate;

@end

@protocol PasswordTableViewCellDelegate <NSObject>

@optional
- (void)passwordTableViewCellTextFieldAction:(EditPasswordProfileVC*)passwordVC;

@end
