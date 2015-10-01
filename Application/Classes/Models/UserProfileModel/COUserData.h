//
//  COUserData.h
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/21/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol COUserFirstName  <NSObject>

- (NSString *)firstNameTitle;
- (NSString *)firstNameContent;
@end

@protocol COUserLastName  <NSObject>

- (NSString *)lastNameTitle;
- (NSString *)lastNameContent;
@end

@protocol COUserEmail <NSObject>

- (NSString *)emailTitle;
- (NSString *)emailContent;
@end

@protocol COUserPhone <NSObject>

- (NSString *)phoneTitle;
- (NSString *)phoneContent;
- (NSString *)phoneContentWithPrefix;
@end

@protocol COUserAboutProfile <NSObject>

- (NSString *)nameOfUserName;
- (NSString *)nameOfUserFirstName;
- (NSString *)nameOfUserLastName;
- (NSString *)nameOfUserEmail;
- (NSString *)numberOfUserPhone;
- (NSString *)nameOfUserAddress1;
- (NSString *)nameOfUserRegion;
- (NSString *)nameOfUserAddress2;
- (NSString *)nameOfUserCity;
- (NSString *)nameOfUserCountry;
- (NSString *)nameOfUserCountryCode;

- (void)setNameOfUserName:(NSString*)string;
- (void)setNameOfUserFirstName:(NSString*)string;
- (void)setNameOfUserLastName:(NSString*)string;
- (void)setNameOfUserEmail:(NSString*)string;
- (void)setNumberOfUserPhone:(NSString*)string;
- (void)setNameOfUserAddress1:(NSString*)string;
- (void)setNameOfUserRegion:(NSString*)string;
- (void)setNameOfUserAddress2:(NSString*)string;
- (void)setNameOfUserCity:(NSString*)string;
- (void)setNameOfUserCountry:(NSString*)string;
- (void)setNameOfUserCountryCode:(NSString*)string;

@end
