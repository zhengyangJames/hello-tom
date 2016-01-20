//
//  ProtfolioController.h
//  CoAssets
//
//  Created by Macintosh HD on 10/2/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseViewController.h"
#import "COAccountInvestmentModel.h"
#import "COMultiPortpolioModel.h"

@interface ProtfolioController : BaseViewController

@property (readonly,nonatomic) COPortfolioProfile protfolioStyle;
@property (strong, nonatomic) COAccountInvestmentModel *accountModel;
@property (strong, nonatomic) COMultiPortpolioModel *multiPortpolio;

@end
