//
//  NProfileDataSource.h
//  CoAssets
//
//  Created by Macintosh HD on 10/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class COUserProfileModel;
@interface NProfileDataSource :NSObject <UITableViewDataSource>

@property (nonatomic, strong) COUserProfileModel *userModel;
@property (nonatomic, strong) NSArray *arrayObject;
@property (nonatomic, assign) NSInteger profileStyle;

- (id)initWithTableview:(UITableView *)tableview;
- (CGFloat)tableview:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
