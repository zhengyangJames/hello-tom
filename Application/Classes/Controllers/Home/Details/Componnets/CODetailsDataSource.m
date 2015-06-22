//
//  CODetailsDataSource.m
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsDataSource.h"

#define K_String_Project @"CANYON DE BORACAY PREMIERE is a 264 room mixed use condotel that brings the convenience and luxury of the urban lifestyle to Boracay - what is called the Best Island in the World in recent years. Equipped with a full range of amenities to provide world class accommodations. From the tranquil sea breeze to the commercial retail complex, Canyon de Boracay Premiere has everything you need, including the best beaches and the modern necessities of life.Building featuresRooftop amenitiesVertical gardenSwimming pool and spaSupermarket commercial retail Amenities Health and fitness center Supermarket and commercial retail stores (1st indoor mall on the island!) Restaurants and pubs Water sports and activities White sand beaches Benefits & Advantages of being a condotel owner Return on Investment (ROI) There will be recurring revenue from hotel operations during the 15 year lease agreement with G2 hotel management. 40% of room net revenue given to unit owners and hotel expenses no longer a risk for unit owners. 14 complimentary room-night stay annually Free Condominium Dues Free Insurance Free Real Property Taxes Lifetime Ownership covered by a CCT Title (Condominium Certificate Title) Prestige Ownership of a property in a Prime Tourist Destination The condotel is selling at Php 40K to 145K/sqm. The expected turn over date is Dec 2019."

@interface CODetailsDataSource ()

@property (weak, nonatomic) id<CODetailsAccessoryCellDelegate,CODetailsProjectCellDelegate> controller;

@end

@implementation CODetailsDataSource


- (instancetype)initWithController:(id<CODetailsProjectCellDelegate,CODetailsAccessoryCellDelegate>)controller tableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
        self.controller = controller;
        [tableView registerNib:[UINib nibWithNibName:[CODetailsPhotoCell identifier] bundle:nil] forCellReuseIdentifier:[CODetailsPhotoCell identifier]];
        [tableView registerNib:[UINib nibWithNibName:[CODetailsMapCell identifier] bundle:nil] forCellReuseIdentifier:[CODetailsMapCell identifier]];
        [tableView registerNib:[UINib nibWithNibName:[CODetailsAccessoryCell identifier] bundle:nil] forCellReuseIdentifier:[CODetailsAccessoryCell identifier]];
        [tableView registerNib:[UINib nibWithNibName:[CODetailsProjectCell identifier] bundle:nil] forCellReuseIdentifier:[CODetailsProjectCell identifier]];
        [tableView registerNib:[UINib nibWithNibName:[CODetailsTextCell identifier] bundle:nil] forCellReuseIdentifier:[CODetailsTextCell identifier]];
        [tableView registerNib:[UINib nibWithNibName:[CODetailsSectionCell identifier] bundle:nil] forCellReuseIdentifier:[CODetailsSectionCell identifier]];
    }
    return self;
}

#pragma mark - Set get


#pragma mark - Private

- (CODetailsTextCell*)textCellForTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    CODetailsTextCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODetailsTextCell identifier] forIndexPath:indexPath];
    if (indexPath.row == 2) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"Invest in the booming tourism in Philippines -Boracay, Philippine's top tourist destination, known for its Powder - Fine Sands and Prestine Watersy",@"details",@"OFFER",@"status", nil];
        cell.object = dic;
    } else if(indexPath.row == 3) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:K_String_Project,@"details",@"PROJECT",@"status", nil];
        cell.object = dic;
    } else if(indexPath.row == 4) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"The following are documents uploaded by OP for the projects. For documents that are marked as PRIVATE - please contact us to review.",@"details",@"DOCUMENTS",@"status", nil];
        cell.object = dic;
    } else {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"Sitio Sinagpa, Balabag, Malay Aklan 5608 Boracay Philippines",@"details",@"ADDRESS",@"status", nil];
        cell.object = dic;
    }
    return cell;
}

- (CODetailsProjectCell*)_projectCellForTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    CODetailsProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODetailsProjectCell identifier] forIndexPath:indexPath];
    
    return cell;
}

- (CODetailsAccessoryCell*)_accessoryCellForTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    CODetailsAccessoryCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODetailsAccessoryCell identifier] forIndexPath:indexPath];
    if (indexPath.row == 6) {
        cell.object = @"Declaration Form";
    }else if (indexPath.row == 8) {
        cell.object = @"Company Registration";
    } else if (indexPath.row == 9) {
        cell.object = @"Company Registration - PRIVATE DOCUMENT";
    } else if (indexPath.row == 11) {
        cell.object = @"Location - Shopping Centers nearby";
    } else if (indexPath.row == 12) {
        cell.object = @"Location - Schools nearby";
    } else if (indexPath.row == 13) {
        cell.object = @"Location - Hospital nearby";
    } else if (indexPath.row == 14) {
        cell.object = @"Brochure pg 2";
    } else {
        cell.object = @"Brochure pg 1";
    }
    return cell;
}

- (CODetailsMapCell*)_mapCellForTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    CODetailsMapCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODetailsMapCell identifier] forIndexPath:indexPath];
    
    return cell;
}

- (CODetailsSectionCell*)_sectionCellForTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    CODetailsSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODetailsSectionCell identifier] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 5) {
        cell.titleSection = @"DECLARATION FORM";
    } else if (indexPath.row == 7) {
        cell.titleSection = @"COMPANY REGISTRATION";
    } else {
        cell.titleSection = @"OTHER DOCUMENTS";
    }
    return cell;
}

- (CODetailsPhotoCell*)photoCellForTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    CODetailsPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODetailsPhotoCell identifier] forIndexPath:indexPath];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"Invest in Canyon de Boracay Premier to own a piece of the booming tourism in Boracay",@"details",@"8.jpg",@"images", nil];
    cell.object = dic;
    return cell;
}

- (NSInteger)_detailsnumberOfSections:(UITableView *)tableView {
    return 1;
}

- (NSInteger)_detailsNumberOfRowInSection:(NSInteger)section {
    return 18;
}

- (UITableViewCell*)_tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [self photoCellForTableView:tableView indexPath:indexPath];
    } else if(indexPath.row == 1) {
        return [self _projectCellForTableView:tableView indexPath:indexPath];
    } else if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 16 ){
        return [self textCellForTableView:tableView indexPath:indexPath];
    } else if (indexPath.row == 5 || indexPath.row == 7 || indexPath.row == 10) {
        return [self _sectionCellForTableView:tableView indexPath:indexPath];
    } else if (indexPath.row == 17) {
        return [self _mapCellForTableView:tableView indexPath:indexPath];
    } else {
        return [self _accessoryCellForTableView:tableView indexPath:indexPath];
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
