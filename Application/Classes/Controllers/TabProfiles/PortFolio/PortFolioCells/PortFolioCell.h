//
//  PortFolioCell.h
//  CoAssets
//
//  Created by Macintosh HD on 10/2/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COUserPortFolioModel.h"
#import "COMultiPortFolioModel.h"

@interface PortFolioCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *ongoingInvestment;
@property (nonatomic, strong) NSNumber *ongoingProjects;
@property (nonatomic, strong) NSDictionary *completedInvestment;
@property (nonatomic, strong) NSNumber *completedProjects;
@property (nonatomic, strong) COMultiPortFolioModel *multiPortlio;

@end
