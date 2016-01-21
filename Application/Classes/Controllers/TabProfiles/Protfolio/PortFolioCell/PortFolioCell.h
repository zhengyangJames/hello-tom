//
//  PortFolioCell.h
//  CoAssets
//
//  Created by Macintosh HD on 10/2/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COUserPortFolioModel.h"
#import "COMultiPortpolioModel.h"

@interface PortFolioCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *OngoingInvestment;
@property (nonatomic, strong) NSNumber *OngoingProjects;
@property (nonatomic, strong) NSDictionary *CompletedInvestment;
@property (nonatomic, strong) NSNumber *CompletedProjects;
@property (nonatomic, strong) COMultiPortpolioModel *multiPortlio;

@end
