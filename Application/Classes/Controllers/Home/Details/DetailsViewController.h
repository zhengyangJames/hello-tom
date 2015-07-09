//
//  DetailsViewController.h
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseViewController.h"
#import "CODetailsAccessoryCell.h"
#import "CODetailsDelegate.h"
#import "CODetailsOffersObject.h"
#import "CODetailsProjectCell.h"

@interface DetailsViewController : BaseViewController <CODetailsAccessoryCellDelegate>

@property (strong, nonatomic) CODetailsOffersObject *objectDetails;

@property (nonatomic, strong) NSArray *arrayObj;

@end

