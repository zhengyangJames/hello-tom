//
//  COUserData.h
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/21/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol COUserName  <NSObject>

- (NSString *)userNameTitle;
- (NSString *)userNameContent;

@end

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


#pragma mark - Company

@protocol COCompanyName <NSObject>

- (NSString *)companyNameTitle;
- (NSString *)companyNameContent;
- (void)setCompanyNameContent:(NSString*)string;

@end

@protocol COCompanyAdress <NSObject>

- (NSString *)companyAdressTitle;
- (NSString *)companyAdressContent1;
- (NSString *)companyAdressContent2;
- (NSString *)companyOrgtype;
- (NSString *)companyCity;
- (NSString *)companyCountry;

- (void)setCompanyAdressContent1:(NSString*)string;
- (void)setCompanyAdressContent2:(NSString*)string;
- (void)setCompanyOrgtype:(NSString*)string;
- (void)setCompanyCity:(NSString*)string;
- (void)setCompanyCountry:(NSString*)string;

@end

@protocol COCompanyImage <NSObject>

- (NSString *)companyImageURL;
- (NSString *)heightForImage;
- (void)setCompanyImageURL:(NSString*)imageCompany;
- (void)setHeightForImage:(NSString*)imageHeight;
@end

#pragma mark - Investor

@protocol COCureency <NSObject>

- (NSString *)COCureencyContent;

@end

@protocol CODescriptions <NSObject>

- (NSString *)CODescriptionsContent;

@end

@protocol COWebsite <NSObject>

- (NSString *)COWebsiteContent;

@end

@protocol COInvestorType <NSObject>

- (NSString *)COInvestorTypeTitle;
- (NSString *)COInvestorTypeContent;

@end

@protocol COInvestorPreference <NSObject>

- (NSString *)COInvestorPreferenceTitle;
- (NSString *)COInvestorPreferenceContent;
@end

@protocol COInvestorAmount <NSObject>

- (NSString *)COInvestorAmountTitle;
- (NSString *)COInvestorAmountContent;
@end

@protocol COInvestorTarget <NSObject>

- (NSString *)COInvestorTargetTitle;
- (NSString *)COInvestorTargetContent;
@end

@protocol COInvestorDuration <NSObject>

- (NSString *)COInvestorDurationTitle;
- (NSString *)COInvestorDurationContent;
@end

@protocol COInvestorCountries <NSObject>

- (NSString *)COInvestorCountriesTitle;
- (NSString *)COInvestorCountriesContent;

@end

#pragma mark User Company

@protocol COUserCompany <NSObject>

- (NSInteger)numOfItemInTableview;
- (NSInteger)indexOfNameCell;
- (NSInteger)indexOfAddressCell;
- (NSInteger)indexOfButtonCell;
- (NSInteger)indexOfImageCell;
- (NSInteger)indexOfNoDataCell;

@end

#pragma mark - Account Invetment
@protocol COAccountOnGoing <NSObject>

- (NSString *)accOngoingTitle;
- (NSNumber *)accOngoingInvestment;

@end

@protocol COAccountFunded <NSObject>

- (NSString *)accFundedTitle;
- (NSNumber *)accFundedInvestment;

@end

@protocol COAccountCompleted <NSObject>

- (NSString *)accCompletedtitle;
- (NSNumber *)accCompletedInvestment;

@end

@protocol COAccountRealised <NSObject>

- (NSString *)accRealisedTitle;
- (NSNumber *)accRealisedPayouts;

@end

@protocol COAccountPotential <NSObject>

- (NSString *)accPotentialTitle;
- (NSNumber *)accPotentialPayouts;

@end


#pragma mark - About Profile

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

#pragma mark - Portfolio

@protocol COOngoingProjects <NSObject>

- (NSString *)OngoingProjectsTitle;
- (NSString *)OngoingProjectsImage;
- (NSNumber *)OngoingProjectsVaule;

@end

@protocol COOngoingInvestment <NSObject>

- (NSString *)COOngoingInvestmentTitle;
- (NSString *)COOngoingInvestmentImage;
- (NSNumber *)COOngoingInvestmentVaule;

@end

@protocol COCompletedProjects <NSObject>

- (NSString *)COCompletedProjectsTitle;
- (NSString *)COCompletedProjectsImage;
- (NSNumber *)COCompletedProjectsVaule;

@end

@protocol COCompletedInvestment <NSObject>

- (NSString *)COCompletedInvestmentTitle;
- (NSString *)COCompletedInvestmentImage;
- (NSNumber *)COCompletedInvestmentVaule;

@end
