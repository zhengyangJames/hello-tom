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
- (void)setArrayObject:(NSArray *)arrayObject {
    _arrayObject = arrayObject;
}

- (void)setProfileStyle:(NSInteger)profileStyle {
    _profileStyle = profileStyle;
}

- (void)setUserModel:(COUserProfileModel *)userModel {
    _userModel = userModel;
}

#pragma mark - Cells

- (UITableViewCell *)tableview:(UITableView *)tableView aboutCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.arrayObject.count - 1) {
        NprofileButtonCell *cell = [self tableview:tableView buttonCellForRowAtIndexpath:indexPath];
        cell.actionStyle = NProfileActionChangePassWord;
        return cell;
    } else if (indexPath.row == self.arrayObject.count - 2) {
        NprofileButtonCell *cell = [self tableview:tableView buttonCellForRowAtIndexpath:indexPath];
        cell.actionStyle = NProfileActionUpdateProfile;
        return cell;
    } else if (indexPath.row == self.arrayObject.count - 3) {
        return [self tableview:tableView adressCellForRowAtIndexpath:indexPath];
    }
    return [self tableview:tableView textCellForRowAtIndexpath:indexPath];
    
}

- (UITableViewCell *)tableview:(UITableView *)tableView companyCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [self tableview:tableView imageCellForRowAtIndexpath:indexPath];
    } else if (indexPath.row == self.arrayObject.count - 1) {
        NprofileButtonCell *cell = [self tableview:tableView buttonCellForRowAtIndexpath:indexPath];
        cell.actionStyle = NProfileActionUpdateCompany;
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell identifier]];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[UITableViewCell identifier]];
    }
    cell.textLabel.text = [self.arrayObject objectAtIndex:indexPath.row];
    return cell;
}

- (UITableViewCell *)tableview:(UITableView *)tableView investorProfileCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.arrayObject.count - 1) {
        NprofileButtonCell *cell = [self tableview:tableView buttonCellForRowAtIndexpath:indexPath];
        cell.actionStyle = NProfileActionUpdateInvestor;
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell identifier]];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[UITableViewCell identifier]];
    }
    cell.textLabel.text = [self.arrayObject objectAtIndex:indexPath.row];
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
    if (indexPath.row == COAboutProfileStyleFirstName) {
        cell.userFirstName = self.userModel;
    } else if (indexPath.row == COAboutProfileStyleLastNameSurname) {
        cell.userLastName = self.userModel;
    } else if (indexPath.row == COAboutProfileStyleEmail) {
        cell.userEmail = self.userModel;
    } else {
        cell.userPhone = self.userModel;
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
    return self.arrayObject.count;
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
    if (indexPath.row == self.arrayObject.count - 1 || indexPath.row == self.arrayObject.count - 2) {
        return HIEGHT_BOTTOMVIEW;
    }
    return DEFAULT_HEIGHT_CELL;
}

- (CGFloat)tableview:(UITableView *)tableView heightForCompanyCellAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return HEIGHT_FOR_IMAGE_ROW;
    } else if (indexPath.row == self.arrayObject.count - 1) {
        return HIEGHT_BOTTOMVIEW;
    }
    return DEFAULT_HEIGHT_CELL;
}

- (CGFloat)tableview:(UITableView *)tableView heightForInvestorProfileCellAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.arrayObject.count - 1) {
        return HIEGHT_BOTTOMVIEW;
    }
    return DEFAULT_HEIGHT_CELL;
}

@end
