//
//  CODetailsMapCell.m
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsMapCell.h"
#import "MKMapView+ZoomLevel.h"

#define GEORGIA_TECH_LATITUDE 33.777328
#define GEORGIA_TECH_LONGITUDE -84.397348
#define ZOOM_LEVEL 14

@interface CODetailsMapCell ()
{
    
}

@end

@implementation CODetailsMapCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    CLLocationCoordinate2D centerCoord = {GEORGIA_TECH_LATITUDE,GEORGIA_TECH_LONGITUDE};
    [self.mapViewCell setCenterCoordinate:centerCoord zoomLevel:ZOOM_LEVEL animated:YES];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(33.777328,
                                                                   -84.397348);
    
    MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc]init];
    myAnnotation.coordinate = coordinate;
    myAnnotation.title = @"Matthews Pizza";
    myAnnotation.subtitle = @"Best Pizza in Town";
    [self.mapViewCell  addAnnotation:myAnnotation];
}

- (void)viewDidLoad {
    [self.mapViewCell setScrollEnabled:NO];
    [self.mapViewCell setZoomEnabled:YES];
}

@end
