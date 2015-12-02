//
//  PortFolioCell.h
//  CoAssets
//
//  Created by Macintosh HD on 10/2/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COUserPortFolioModel.h"

@interface PortFolioCell : UICollectionViewCell

@property (nonatomic, strong) id<COOngoingInvestment> OngoingInvestment;
@property (nonatomic, strong) id<COOngoingProjects> OngoingProjects;
@property (nonatomic, strong) id<COCompletedInvestment> CompletedInvestment;
@property (nonatomic, strong) id<COCompletedProjects> CompletedProjects;

@end
