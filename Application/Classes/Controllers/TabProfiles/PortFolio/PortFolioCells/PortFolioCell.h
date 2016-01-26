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

@interface PortfolioCell : UITableViewCell
@property (nonatomic, strong) COMultiPortfolioModel *multiPortfolio;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end
