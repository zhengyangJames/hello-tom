//
//  NProfileDataSource.m
//  CoAssets
//
//  Created by Macintosh HD on 10/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "NProfileDataSource.h"
#import "NprofileButtonCell.h"
#import "NProfileImageCell.h"
#import "NProfileTextCell.h"
#import "NProfileAdressCell.h"
#import "COUserProfileModel.h"
#import "COUserCompanyModel.h"

@interface NProfileDataSource ()
{
    __weak UITableView *_tableview;
}
@end

@implementation NProfileDataSource

- (id)initWithTableview:(UITableView *)tableview {
    self = [super init];
    if (self) {
        _tableview = tableview;
        [_tableview registerNib:[UINib nibWithNibName:[NprofileButtonCell identifier] bundle:nil] forCellReuseIdentifier:[NprofileButtonCell identifier]];
        [_tableview registerNib:[UINib nibWithNibName:[NProfileImageCell identifier] bundle:nil] forCellReuseIdentifier:[NProfileImageCell identifier]];
        [_tableview registerNib:[UINib nibWithNibName:[NProfileTextCell identifier] bundle:nil] forCellReuseIdentifier:[NProfileTextCell identifier]];
        [_tableview registerNib:[UINib nibWithNibName:[NProfileAdressCell identifier] bundle:nil] forCellReuseIdentifier:[NProfileAdressCell identifier]];
    }
    return self;
}

#pragma mark - Setter, Gettr

- (void)setProfileStyle:(NSInteger)profileStyle {
    _profileStyle = profileStyle;
}

- (void)setUserModel:(COUserProfileModel *)userModel {
    _userModel = userModel;
}

- (void)setCompanyModel:(COUserCompanyModel *)companyModel {
    _companyModel = companyModel;
}

#pragma mark - Cells

- (UITableViewCell *)tableview:(UITableView *)tableView aboutCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == NUM_OF_ROW_ABOUT- 1) {
        NprofileButtonCell *cell = [self tableview:tableView buttonCellForRowAtIndexpath:indexPath];
        cell.actionStyle = NProfileActionChangePassWord;
        return cell;
    } else if (indexPath.row == NUM_OF_ROW_ABOUT - 2) {
        NprofileButtonCell *cell = [self tableview:tableView buttonCellForRowAtIndexpath:indexPath];
        cell.actionStyle = NProfileActionUpdateProfile;
        return cell;
    } else if (indexPath.row == NUM_OF_ROW_ABOUT - 3) {
        return [self tableview:tableView adressCellForRowAtIndexpath:indexPath];
    }
    return [self tableview:tableView textCellForRowAtIndexpath:indexPath];
    
}

- (UITableViewCell *)tableview:(UITableView *)tableView companyCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [self tableview:tableView imageCellForRowAtIndexpath:indexPath];
    } else if (indexPath.row == NUM_OF_ROW_COMPANY - 1) {
        NprofileButtonCell *cell = [self tableview:tableView buttonCellForRowAtIndexpath:indexPath];
        cell.actionStyle = NProfileActionUpdateCompany;
        return cell;
    }
    return [self tableview:tableView textCellForRowAtIndexpath:indexPath];
}

- (UITableViewCell *)tableview:(UITableView *)tableView investorProfileCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == NUM_OF_ROW_INVESTOR - 1) {
        NprofileButtonCell *cell = [self tableview:tableView buttonCellForRowAtIndexpath:indexPath];
        cell.actionStyle = NProfileActionUpdateInvestor;
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell identifier]];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[UITableViewCell identifier]];
    }
    cell.textLabel.text = @"SANYI";
    return cell;
}

- (NprofileButtonCell *)tableview:(UITableView *)tableview buttonCellForRowAtIndexpath:(NSIndexPath *)indexPath {
    NprofileButtonCell *cell = [tableview dequeueReusableCellWithIdentifier:[NprofileButtonCell identifier]];
    return cell;
}

- (NProfileImageCell *)tableview:(UITableView *)tableview imageCellForRowAtIndexpath:(NSIndexPath *)indexPath {
    NProfileImageCell *cell = [tableview dequeueReusableCellWithIdentifier:[NProfileImageCell identifier]];
    return cell;
}

- (NProfileTextCell *)tableview:(UITableView *)tableview textCellForRowAtIndexpath:(NSIndexPath *)indexPath {
    NProfileTextCell *cell = [tableview dequeueReusableCellWithIdentifier:[NProfileTextCell identifier]];
    switch (self.profileStyle) {
        case NProfileStyleAbout: {
            if (indexPath.row == COAboutProfileStyleFirstName) {
                cell.userFirstName = self.userModel;
            } else if (indexPath.row == COAboutProfileStyleLastNameSurname) {
                cell.userLastName = self.userModel;
            } else if (indexPath.row == COAboutProfileStyleEmail) {
                cell.userEmail = self.userModel;
            } else {
                cell.userPhone = self.userModel;
            }
        }
            break;
        case NProfileStyleCompany: {
            if (indexPath.row == COCompanyProfileStyleName) {
                cell.compantName = self.companyModel;
            } else  {
                cell.companyAdress = self.companyModel;
            }
        }
            break;
        case NProfileStyleInvestorProfile: {
            
        }
    }
    return cell;
}

- (NProfileAdressCell *)tableview:(UITableView *)tableview adressCellForRowAtIndexpath:(NSIndexPath *)indexPath {
    NProfileAdressCell *cell = [tableview dequeueReusableCellWithIdentifier:[NProfileAdressCell identifier]];
    cell.userAddress = self.userModel;
    return cell;
}

#pragma mark - Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (self.profileStyle) {
        case NProfileStyleAbout:
            return NUM_OF_ROW_ABOUT;
        case NProfileStyleCompany:
            return NUM_OF_ROW_COMPANY;
        case NProfileStyleInvestorProfile:
            return NUM_OF_ROW_INVESTOR;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.profileStyle) {
        case NProfileStyleAbout:
            return [self tableview:tableView aboutCellForRowAtIndexPath:indexPath];
        case NProfileStyleCompany:
            return [self tableview:tableView companyCellForRowAtIndexPath:indexPath];
        case NProfileStyleInvestorProfile:
            return [self tableview:tableView investorProfileCellForRowAtIndexPath:indexPath];
    }
    return nil;
}

#pragma mark - delegate

- (CGFloat)tableview:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.profileStyle) {
        case NProfileStyleAbout:
            return [self tableview:tableView heightForAboutCellAtIndexPath:indexPath];
        case NProfileStyleCompany:
            return [self tableview:tableView heightForCompanyCellAtIndexPath:indexPath];
        case NProfileStyleInvestorProfile:
            return [self tableview:tableView heightForInvestorProfileCellAtIndexPath:indexPath];
    }
    return 44;
}

#pragma mark - Height all cell
- (CGFloat)tableview:(UITableView *)tableView heightForAboutCellAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == NUM_OF_ROW_ABOUT - 1 || indexPath.row == NUM_OF_ROW_ABOUT - 2) {
        return HIEGHT_BOTTOMVIEW;
    }
    return DEFAULT_HEIGHT_CELL;
}

- (CGFloat)tableview:(UITableView *)tableView heightForCompanyCellAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return HEIGHT_FOR_IMAGE_ROW;
    } else if (indexPath.row == NUM_OF_ROW_COMPANY - 1) {
        return HIEGHT_BOTTOMVIEW;
    }
    return DEFAULT_HEIGHT_CELL;
}

- (CGFloat)tableview:(UITableView *)tableView heightForInvestorProfileCellAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == NUM_OF_ROW_INVESTOR - 1) {
        return HIEGHT_BOTTOMVIEW;
    }
    return DEFAULT_HEIGHT_CELL;
}

@end
