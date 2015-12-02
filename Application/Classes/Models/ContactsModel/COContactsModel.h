//
//  ContactsModel.h
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/28/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface COContactsModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *contactRegNo;
@property (nonatomic, strong) NSString *contactCity;
@property (nonatomic, strong) NSString *contactPostalCode;
@property (nonatomic, strong) NSString *contactCountry;
@property (nonatomic, strong) NSString *contactAddress2;
@property (nonatomic, strong) NSString *contactPhoneNumber;
@property (nonatomic, strong) NSString *contactAddress1;
@property (nonatomic, strong) NSString *contactName;

- (NSString *)stringOfContactRegNo;
- (NSString *)stringOfContactCity;
- (NSString *)stringOfContactPostalCode;
- (NSString *)stringOfContactCountry;
- (NSString *)stringOfContactAddress2;
- (NSString *)stringOfContactPhoneNumber;
- (NSString *)stringOfContactAddress1;
- (NSString *)stringOfContactName;
@end
