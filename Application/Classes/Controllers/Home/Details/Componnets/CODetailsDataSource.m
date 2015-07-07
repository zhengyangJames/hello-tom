//
//  CODetailsDataSource.m
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsDataSource.h"


@interface CODetailsDataSource () <CODetailsProjectTBVCellDelegate,CODetailsProjectTBVCellDelegate>

@property (weak, nonatomic) id<CODetailsAccessoryCellDelegate,CODetailsProjectTBVCellDelegate> controller;

@end

@implementation CODetailsDataSource


- (instancetype)initWithController:(id<CODetailsProjectTBVCellDelegate,CODetailsAccessoryCellDelegate>)controller tableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
        self.controller = controller;
        [tableView registerNib:[UINib nibWithNibName:[CODetailsPhotoCell identifier] bundle:nil] forCellReuseIdentifier:[CODetailsPhotoCell identifier]];
//        [tableView registerNib:[UINib nibWithNibName:[CODetailsMapCell identifier] bundle:nil] forCellReuseIdentifier:[CODetailsMapCell identifier]];
//        [tableView registerNib:[UINib nibWithNibName:[CODetailsAccessoryCell identifier] bundle:nil] forCellReuseIdentifier:[CODetailsAccessoryCell identifier]];
        [tableView registerNib:[UINib nibWithNibName:[CODetailsProjectTBVCell identifier] bundle:nil] forCellReuseIdentifier:[CODetailsProjectTBVCell identifier]];
        [tableView registerNib:[UINib nibWithNibName:[CODetailsTextCell identifier] bundle:nil] forCellReuseIdentifier:[CODetailsTextCell identifier]];
//        [tableView registerNib:[UINib nibWithNibName:[CODetailsSectionCell identifier] bundle:nil] forCellReuseIdentifier:[CODetailsSectionCell identifier]];
    }
    return self;
}

#pragma mark - Set get


#pragma mark - Private

- (CODetailsTextCell*)textCellForTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    CODetailsTextCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODetailsTextCell identifier] forIndexPath:indexPath];
    NSString *address1 = ![self.object.address isEmpty]?self.object.address:@"";
    NSString *address2 = [self.object.address2 isEmpty]?@"":self.object.address2;
    NSString *city = [self.object.city isEmpty]?@"":self.object.city;
    NSString *country = [self.object.country isEmpty]?@"":self.object.country;
    NSString *all = [NSString stringWithFormat:@"%@ %@ ,%@ ,%@",address1,address2,city,country];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:all,@"details",@"ADDRESS",@"status", nil];
    cell.object = dic;
    return cell;
}

- (CODetailsProjectTBVCell*)_projectCellForTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    CODetailsProjectTBVCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODetailsProjectTBVCell identifier] forIndexPath:indexPath];
    cell.delegate = self.controller;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        cell.object = self.object;
    }];
    return cell;
}

//- (CODetailsAccessoryCell*)_accessoryCellForTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
//    CODetailsAccessoryCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODetailsAccessoryCell identifier] forIndexPath:indexPath];
//    if (indexPath.row == 6) {
//        cell.object = @"Declaration Form";
//    }else if (indexPath.row == 8) {
//        cell.object = @"Company Registration";
//    } else if (indexPath.row == 9) {
//        cell.object = @"Company Registration - PRIVATE DOCUMENT";
//    } else if (indexPath.row == 11) {
//        cell.object = @"Location - Shopping Centers nearby";
//    } else if (indexPath.row == 12) {
//        cell.object = @"Location - Schools nearby";
//    } else if (indexPath.row == 13) {
//        cell.object = @"Location - Hospital nearby";
//    } else if (indexPath.row == 14) {
//        cell.object = @"Brochure pg 2";
//    } else {
//        cell.object = @"Brochure pg 1";
//    }
//    return cell;
//}

//- (CODetailsMapCell*)_mapCellForTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
//    CODetailsMapCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODetailsMapCell identifier] forIndexPath:indexPath];
//    
//    return cell;
//}

//- (CODetailsSectionCell*)_sectionCellForTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
//    CODetailsSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODetailsSectionCell identifier] forIndexPath:indexPath];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    if (indexPath.row == 5) {
//        cell.titleSection = @"DECLARATION FORM";
//    } else if (indexPath.row == 7) {
//        cell.titleSection = @"COMPANY REGISTRATION";
//    } else {
//        cell.titleSection = @"OTHER DOCUMENTS";
//    }
//    return cell;
//}

- (CODetailsPhotoCell*)photoCellForTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    CODetailsPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODetailsPhotoCell identifier] forIndexPath:indexPath];
    NSString *str = self.object.detailsShort;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:str,@"details",self.object.imageBig,@"images", nil];
    cell.object = dic;
    return cell;
}

- (NSInteger)_detailsnumberOfSections:(UITableView *)tableView {
    return 1;
}

- (NSInteger)_detailsNumberOfRowInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell*)_tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [self photoCellForTableView:tableView indexPath:indexPath];
    } else if(indexPath.row == 1) {
        return [self _projectCellForTableView:tableView indexPath:indexPath];
    } else {
        return [self textCellForTableView:tableView indexPath:indexPath];
    }
    return  nil;
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self _detailsnumberOfSections:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self _detailsNumberOfRowInSection:section];;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self _tableView:tableView cellForRowAtIndexPath:indexPath];
}


@end
