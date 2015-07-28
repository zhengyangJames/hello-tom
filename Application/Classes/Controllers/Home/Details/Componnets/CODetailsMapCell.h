//
//  CODetailsMapCell.h
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "BaseTableViewCell.h"

@interface CODetailsMapCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet MKMapView *mapViewCell;

@end
