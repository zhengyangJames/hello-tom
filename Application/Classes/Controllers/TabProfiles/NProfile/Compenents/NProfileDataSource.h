//
//  NProfileDataSource.h
//  CoAssets
//
//  Created by Macintosh HD on 10/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NprofileButtonCell.h"
#import "COUserData.h"
@class COUserProfileModel;
@class COUserCompanyModel;
@class COUserInverstorModel;

@interface NProfileDataSource :NSObject <UITableViewDataSource>

@property (nonatomic, strong) COUserProfileModel *userModel;
@property (nonatomic, strong) COUserCompanyModel<COCompanyImage> *companyModel;
@property (nonatomic, strong) COUserInverstorModel *invedtorModel;
@property (nonatomic, assign) NSInteger profileStyle;


- (id)initWithTableview:(UITableView *)tableview controller:(id<profileButtonCellDelegate>)controller;

- (CGFloat)tableview:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

