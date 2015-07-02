//
//  RegisterViewController.h
//  CoAssest
//
//  Created by Macintosh HD on 6/10/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^ActionRegister)();

@interface RegisterViewController : BaseViewController

@property (copy, nonatomic) ActionRegister actionRegister;

@end
