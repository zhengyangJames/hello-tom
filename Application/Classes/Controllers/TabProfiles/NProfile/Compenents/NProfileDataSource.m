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
#import "COUserInverstorModel.h"

@interface NProfileDataSource () <profileButtonCellDelegate>
{
    __weak UITableView *_tableview;
}
@property (weak, nonatomic) id<profileButtonCellDelegate> controller;

@end

@implementation NProfileDataSource

- (id)initWithTableview:(UITableView *)tableview controller:(id<profileButtonCellDelegate>)controller {
    self = [super init];
    if (self) {
        self.controller = controller;
        _tableview = tableview;
        [_tableview registerNib:[UINib nibWithNibName:[NprofileButtonCell identifier] bundle:nil] forCellReuseIdentifier:[NprofileButtonCell identifier]];
        [_tableview registerNib:[UINib nibWithNibName:[NProfileImageCell identifier] bundle:nil] forCellReuseIdentifier:[NProfileImageCell identifier]];
        [_tableview registerNib:[UINib nibWithNibName:[NProfileTextCell identifier] bundle:nil] forCellReuseIdentifier:[NProfileTextCell identifier]];
        [_tableview registerNib:[UINib nibWithNibName:[NProfileAdressCell identifier] bundle:nil] forCellReuseIdentifier:[NProfileAdressCell identifier]];
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
    if (!self.companyModel.imageUrl) {
        if (indexPath.row == NUM_OF_ROW_COMPANY_NO_IMAGE - 1) {
            NprofileButtonCell *cell = [self tableview:tableView buttonCellForRowAtIndexpath:indexPath];
            cell.actionStyle = NProfileActionUpdateCompany;
            return cell;
        } else if (indexPath.row == NUM_OF_ROW_COMPANY_NO_IMAGE - 2) {
            return [self tableview:tableView adressCellForRowAtIndexpath:indexPath];
        }
        return [self tableview:tableView textCellForRowAtIndexpath:indexPath];
    } else {
        if (indexPath.row == 0) {
            return [self tableview:tableView imageCellForRowAtIndexpath:indexPath];
        } else if (indexPath.row == NUM_OF_ROW_COMPANY - 1) {
            NprofileButtonCell *cell = [self tableview:tableView buttonCellForRowAtIndexpath:indexPath];
            cell.actionStyle = NProfileActionUpdateCompany;
            return cell;
        } else if (indexPath.row == NUM_OF_ROW_COMPANY - 2) {
            return [self tableview:tableView adressCellForRowAtIndexpath:indexPath];
        }
        return [self tableview:tableView textCellForRowAtIndexpath:indexPath];
    }
}

- (UITableViewCell *)tableview:(UITableView *)tableView investorProfileCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == NUM_OF_ROW_INVESTOR - 1) {
        NprofileButtonCell *cell = [self tableview:tableView buttonCellForRowAtIndexpath:indexPath];
        cell.actionStyle = NProfileActionUpdateInvestor;
        return cell;
    }
    return [self tableview:tableView textCellForRowAtIndexpath:indexPath];
}

- (NprofileButtonCell *)tableview:(UITableView *)tableview buttonCellForRowAtIndexpath:(NSIndexPath *)indexPath {
    NprofileButtonCell *cell = [tableview dequeueReusableCellWithIdentifier:[NprofileButtonCell identifier]];
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
        case NProfileStyleCompany:
            if (!self.companyModel.imageUrl) { return NUM_OF_ROW_COMPANY_NO_IMAGE; }
            return NUM_OF_ROW_COMPANY;
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
    if (!self.companyModel.imageUrl) {
        if (indexPath.row == NUM_OF_ROW_COMPANY_NO_IMAGE - 1) {
            return HIEGHT_BOTTOMVIEW;
        } else if (indexPath.row == NUM_OF_ROW_COMPANY_NO_IMAGE - 2) {
            return [self tableview:tableView heightForAdressRowAtIndexPath:indexPath];
        }
        return DEFAULT_HEIGHT_CELL;
    } else {
        if (indexPath.row == 0) {
            return HEIGHT_FOR_IMAGE_ROW;
        } else if (indexPath.row == NUM_OF_ROW_COMPANY - 1) {
            return HIEGHT_BOTTOMVIEW;
        } else if (indexPath.row == NUM_OF_ROW_COMPANY - 2) {
            return [self tableview:tableView heightForAdressRowAtIndexPath:indexPath];
        }
        return DEFAULT_HEIGHT_CELL;
    }
}

- (CGFloat)tableview:(UITableView *)tableView heightForInvestorProfileCellAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == NUM_OF_ROW_INVESTOR - 1) {
        return HIEGHT_BOTTOMVIEW;
    }
    return DEFAULT_HEIGHT_CELL;
}

@end
