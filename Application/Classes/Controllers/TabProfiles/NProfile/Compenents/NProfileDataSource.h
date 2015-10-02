//
//  NProfileDataSource.h
//  CoAssets
//
//  Created by Macintosh HD on 10/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NprofileButtonCell.h"
@class COUserProfileModel;
@class COUserCompanyModel;
@class COUserInverstorModel;
@protocol profileButtonCellDelegate;
@protocol ProfileDataSourceDelegate;
@interface NProfileDataSource :NSObject <UITableViewDataSource>

@property (nonatomic, strong) COUserProfileModel *userModel;
@property (nonatomic, strong) COUserCompanyModel *companyModel;
@property (nonatomic, strong) COUserInverstorModel *invedtorModel;
@property (nonatomic, assign) NSInteger profileStyle;
@property (nonatomic, weak) id<ProfileDataSourceDelegate> delegate;


- (id)initWithTableview:(UITableView *)tableview controller:(id<profileButtonCellDelegate>)controller;
- (CGFloat)tableview:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol ProfileDataSourceDelegate <NSObject>

@optional
- (void)actionProfileDataSourceDelegate:(NProfileDataSource*)profileDelegate actionForCellButton:(NProfileActionStyle)actionForCellButton;

@end
