//
//  DetailsViewController.h
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseViewController.h"
#import "CODetailsAccessoryCell.h"
#import "CODetailsProjectCell.h"
#import "CODetailsDelegate.h"

@interface DetailsViewController : BaseViewController <CODetailsAccessoryCellDelegate,CODetailsProjectCellDelegate,CODetailsController>

@end

