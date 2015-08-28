//
//  LoginViewController.h
//  CoAssest
//
//  Created by Macintosh HD on 6/10/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseViewController.h"

@protocol LoginViewControllerDelegate ;

@interface LoginViewController : BaseViewController

@property (weak, nonatomic) id<LoginViewControllerDelegate> delegate;

@end

@protocol LoginViewControllerDelegate <NSObject>

@optional
- (void)loginViewController:(LoginViewController*)loginViewController loginWithStyle:(LoginWithStyle)loginWithStyle;

@end