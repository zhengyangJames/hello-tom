//
//  EditInvestmentProfileVC.h
//  CoAssets
//
//  Created by Tony Tuong on 10/7/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "BaseViewController.h"
#import "COUserInverstorModel.h"

typedef void(^ActionDoneInvestor)();

@interface EditInvestmentProfileVC : BaseViewController

@property (copy, nonatomic) ActionDoneInvestor actionDone;
@property (strong, nonatomic) COUserInverstorModel *investorUserModel;

@end
