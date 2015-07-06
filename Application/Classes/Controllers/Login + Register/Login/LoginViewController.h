//
//  LoginViewController.h
//  CoAssest
//
//  Created by Macintosh HD on 6/10/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^ActionLogin)(BOOL CancelOrLogin); // 0 Cancel , 1 Login

@interface LoginViewController : BaseViewController

@property (copy, nonatomic) ActionLogin actionLogin;

@end
