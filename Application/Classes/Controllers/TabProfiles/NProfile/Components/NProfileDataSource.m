//
//  NProfileDataSource.m
//  CoAssets
//
//  Created by Macintosh HD on 10/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "NProfileDataSource.h"
#import "NProfileButtonCell.h"
#import "NProfileImageCell.h"
#import "NProfileTextCell.h"
#import "NProfileAdressCell.h"
#import "COUserProfileModel.h"
#import "COUserCompanyModel.h"
#import "COUserInverstorModel.h"
#import "NProfileNodataCell.h"
#import "COUserData.h"
#import "NProfileCountrieCell.h"

@interface NProfileDataSource () <profileButtonCellDelegate>
{
    __weak UITableView *_tableview;
}
@property (weak, nonatomic) id<profileButtonCellDelegate> controller;
@property (assign, nonatomic) id<COUserCompany>company;

@end

@implementation NProfileDataSource

- (id)initWithTableview:(UITableView *)tableview controller:(id<profileButtonCellDelegate>)controller {
    self = [super init];
    if (self) {
        self.controller = controller;
        _tableview = tableview;
        [_tableview registerNib:[UINib nibWithNibName:[NProfileButtonCell identifier] bundle:nil] forCellReuseIdentifier:[NProfileButtonCell identifier]];
        [_tableview registerNib:[UINib nibWithNibName:[NProfileImageCell identifier] bundle:nil] forCellReuseIdentifier:[NProfileImageCell identifier]];
        [_tableview registerNib:[UINib nibWithNibName:[NProfileTextCell identifier] bundle:nil] forCellReuseIdentifier:[NProfileTextCell identifier]];
        [_tableview registerNib:[UINib nibWithNibName:[NProfileAdressCell identifier] bundle:nil] forCellReuseIdentifier:[NProfileAdressCell identifier]];
        [_tableview registerNib:[UINib nibWithNibName:[NProfileNodataCell identifier] bundle:nil] forCellReuseIdentifier:[NProfileNodataCell identifier]];
        [_tableview registerNib:[UINib nibWithNibName:[NProfileCountrieCell identifier] bundle:nil] forCellReuseIdentifier:[NProfileCountrieCell identifier]];
    }
    return self;
}

#pragma mark - Setter, Getter

- (void)setProfileStyle:(NSInteger)profileStyle {
    _profileStyle = profileStyle;
}

- (void)setUserModel:(COUserProfileModel *)userModel {
    _userModel = userModel;
}

- (void)setCompanyModel:(COUserCompanyModel *)companyModel {
    self.company = nil;
    _companyModel = companyModel;
}

- (id<COUserCompany>)company {
    if (_company) {
        return _company;
    }
    _company = self.companyModel;
    return _company;
}

#pragma mark - Cells

- (UITableViewCell *)tableview:(UITableView *)tableView aboutCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == NUM_OF_ROW_ABOUT- 1) {
        NProfileButtonCell *cell = [self tableview:tableView buttonCellForRowAtIndexpath:indexPath];
        cell.actionStyle = NProfileActionChangePassWord;
        return cell;
    } else if (indexPath.row == NUM_OF_ROW_ABOUT - 2) {
        NProfileButtonCell *cell = [self tableview:tableView buttonCellForRowAtIndexpath:indexPath];
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
        NProfileButtonCell *cell = [self tableview:tableView buttonCellForRowAtIndexpath:indexPath];
        cell.actionStyle = NProfileActionUpdateCompany;
        return cell;
    } else if (indexPath.row == 1) {
        return [self tableview:tableView textCellForRowAtIndexpath:indexPath];
    } else {
        return [self tableview:tableView adressCellForRowAtIndexpath:indexPath];
    }
    
   
//    if (indexPath.row == [self.company indexOfImageCell]) {
//         return [self tableview:tableView imageCellForRowAtIndexpath:indexPath];
//    } else if (indexPath.row == [self.company indexOfNoDataCell]) {
//        return [self tableview:tableView noDataCellForRowAtIndexpath:indexPath];
//    } else if (indexPath.row == [self.company indexOfNameCell]) {
//        return [self tableview:tableView textCellForRowAtIndexpath:indexPath];
//    } else if (indexPath.row == [self.company indexOfAddressCell]) {
//        return [self tableview:tableView adressCellForRowAtIndexpath:indexPath];
//    } else {
//        NProfileButtonCell *cell = [self tableview:tableView buttonCellForRowAtIndexpath:indexPath];
//        cell.actionStyle = NProfileActionUpdateCompany;
//        return cell;
//    }
}

- (UITableViewCell *)tableview:(UITableView *)tableView investorProfileCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == NUM_OF_ROW_INVESTOR - 1) {
        NProfileButtonCell *cell = [self tableview:tableView buttonCellForRowAtIndexpath:indexPath];
        cell.actionStyle = NProfileActionUpdateInvestor;
        return cell;
    } else if (indexPath.row == NUM_OF_ROW_INVESTOR - 2) {
        return [self tableview:tableView noContrieCellForRowAtIndexpath:indexPath];
        return nil;
    }
    return [self tableview:tableView textCellForRowAtIndexpath:indexPath];
}

- (NProfileCountrieCell *)tableview:(UITableView *)tableview noContrieCellForRowAtIndexpath:(NSIndexPath *)indexPath {
    NProfileCountrieCell *cell = [tableview dequeueReusableCellWithIdentifier:[NProfileCountrieCell identifier]];
    cell.userAddressInvestor = self.invedtorModel;
    return cell;
}

- (NProfileNodataCell *)tableview:(UITableView *)tableview noDataCellForRowAtIndexpath:(NSIndexPath *)indexPath {
    NProfileNodataCell *cell = [tableview dequeueReusableCellWithIdentifier:[NProfileNodataCell identifier]];
    return cell;
}

- (NProfileButtonCell *)tableview:(UITableView *)tableview buttonCellForRowAtIndexpath:(NSIndexPath *)indexPath {
    NProfileButtonCell *cell = [tableview dequeueReusableCellWithIdentifier:[NProfileButtonCell identifier]];
    cell.delegate = self.controller;
    return cell;
}

- (NProfileImageCell *)tableview:(UITableView *)tableview imageCellForRowAtIndexpath:(NSIndexPath *)indexPath {
    NProfileImageCell *cell = [tableview dequeueReusableCellWithIdentifier:[NProfileImageCell identifier]];
    cell.companyImage = self.companyModel;
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
            } else if (indexPath.row == COAboutProfileStyleUserName) {
                cell.userName = self.userModel;
            } else {
                cell.userPhone = self.userModel;
            }
        } break;
        case NProfileStyleCompany: {
            if (!self.companyModel.imageUrl) {
                if (indexPath.row == COCompanyProfileStyleName -1) {
                    cell.companytName = self.companyModel;
                }
            } else {
                if (indexPath.row == COCompanyProfileStyleName) {
                    cell.companytName = self.companyModel;
                }
            }
        } break;
        case NProfileStyleInvestorProfile: {
            if (indexPath.row == COInvedtorProfileStyleType) {
                cell.investorType = self.invedtorModel;
            } else if (indexPath.row == COInvedtorProfileStylePreference) {
                cell.investorPreference = self.invedtorModel;
            } else if (indexPath.row == COInvedtorProfileStyleAmount) {
                cell.investorAmount = self.invedtorModel;
            } else if (indexPath.row == COInvedtorProfileStyleTarget) {
                cell.investorTarget = self.invedtorModel;
            } else if (indexPath.row == COInvedtorProfileStyleDuration) {
                cell.investorDuration = self.invedtorModel;
            } else {
                cell.investorCountries = self.invedtorModel;
            } break;
        }
    }
    return cell;
}

- (NProfileAdressCell *)tableview:(UITableView *)tableview adressCellForRowAtIndexpath:(NSIndexPath *)indexPath {
    NProfileAdressCell *cell = [tableview dequeueReusableCellWithIdentifier:[NProfileAdressCell identifier]];
    switch (self.profileStyle) {
        case NProfileStyleAbout:
            cell.userAddress = self.userModel;
            break;
        case NProfileStyleCompany:
            cell.userAddressCompany = self.companyModel;
            break;
        default: break;
    }
    return cell;
}

#pragma mark - Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (self.profileStyle) {
            
        case NProfileStyleAbout: return NUM_OF_ROW_ABOUT;
//        case NProfileStyleCompany: return [self.company numOfItemInTableview];
            //by vincent
        case NProfileStyleCompany: return NUM_OF_ROW_COMPANY;

            
        case NProfileStyleInvestorProfile: return NUM_OF_ROW_INVESTOR;
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

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

#pragma mark - Height all cell

- (CGFloat)tableview:(UITableView *)tableView heightForAdressRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0;
    if(IS_IOS8_OR_ABOVE) {
        height = UITableViewAutomaticDimension;
        return height;
    } else {
        NProfileAdressCell *cell = [self tableview:tableView adressCellForRowAtIndexpath:indexPath];
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
        CGSize cellSize = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        return cellSize.height;
    }
}

- (CGFloat)tableview:(UITableView *)tableView heightForAboutCellAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == NUM_OF_ROW_ABOUT - 1 || indexPath.row == NUM_OF_ROW_ABOUT - 2) {
        return HIEGHT_BOTTOMVIEW;
    } else if (indexPath.row == NUM_OF_ROW_ABOUT - 3) {
        return [self tableview:tableView heightForAdressRowAtIndexPath:indexPath];
    }
    return DEFAULT_HEIGHT_CELL;
}

- (CGFloat)tableview:(UITableView *)tableView heightForCompanyCellAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [self.company indexOfImageCell]) {
        return [self.companyModel.heightForImage floatValue];
    } else if (indexPath.row == [self.company indexOfNoDataCell]) {
        return DEFAULT_HEIGHT_NO_DATA_CELL;
    } else if (indexPath.row == [self.company indexOfNameCell]) {
        return DEFAULT_HEIGHT_CELL;
    } else if (indexPath.row == [self.company indexOfAddressCell]) {
        return [self tableview:tableView heightForAdressRowAtIndexPath:indexPath];
    } else {
        return HIEGHT_BOTTOMVIEW;
    }
}

- (CGFloat)tableview:(UITableView *)tableView heightForInvestorProfileCellAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == NUM_OF_ROW_INVESTOR - 1) {
        return HIEGHT_BOTTOMVIEW;
    } else if (indexPath.row == NUM_OF_ROW_INVESTOR - 2) {
        return [self tableview:tableView heightForAdressRowAtIndexPath:indexPath];
    }
    return DEFAULT_HEIGHT_CELL;
}

@end
