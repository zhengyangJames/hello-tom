//
//  UIHelper.h
//  myTomorrows
//
//  Created by Linh NGUYEN on 12/30/14.
//  Copyright (c) 2014 BakBurner Digital, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "COUserProfileModel.h"

@interface UIHelper : NSObject



+ (void)showLoadingInView:(UIView*)view;
+ (void)hideLoadingFromView:(UIView*)view;

+ (void)showLoadingIndicator;
+ (void)hideLoadingIndicator;

+ (void)showAlertViewErrorWithMessage:(NSString *)message delegate:(id)delegate tag:(NSInteger)tag;
+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButton:(NSString *)cancelButton delegate:(id)delegate tag:(NSInteger)tag arrayTitleButton:(NSArray *)arrayTitel;
+ (void)showActionsheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButton destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonsTitle:(NSArray *)arrayTitle delegate:(id)delegate tag:(NSInteger)tag showInView:(UIView *)view;

+ (UIImagePickerController *)showImagePickerAtController:(UIViewController *)controller withDelegate:(id)delegate andMode:(NSInteger)mode;

+ (NSString *)stringCurrencyFormatFromNumberDouble:(NSNumber*)number;
+ (NSString *)stringDecimalFormatFromNumberDouble:(NSNumber*)number;

+ (NSAttributedString *)_getStringFromHtml:(NSString *)stringHtml;

+ (NSString *)getStringCurrencyOfferWithKey:(NSString*)keyCurrency;
+ (CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font;
+ (NSString *)getLinkImageWithUrl:(NSURL*)urlImage;

+ (NSMutableDictionary*)getParamTokenWithModel:(COUserProfileModel *)model;
+ (NSString*)formartDoubleValueWithAccountInvest:(NSNumber*)value;

+ (NSString *)getStringCurrencyOfferWithValue:(NSString*)value;

+ (NSArray*)getArrayCurrency;
+ (NSArray*)getInvestorType;

+ (NSString *)formatStringUnknown:(NSString *)string;
+ (NSString*)formartStringDuration:(NSString*)string;
+ (NSString*)formartStringTarget:(NSString*)string;
+ (NSString*)getNumberInstring:(NSString*)value;

+ (NSString*)formartFoatValueWithPortfolio:(NSNumber*)value;

+ (NSString *)getInvestorTypeWithKey:(NSString *)key;
+ (NSString *)getInvestorTypeWithValue:(NSString *)value;
+ (NSArray *)arrayProjectType;
+ (NSString *)getProjectTypeWithKey:(NSString*)key;
+ (NSString *)getProjectTypeWithValue:(NSString*)value;

// by vincent
+ (NSString *)formatStringDateToString:(NSString*)strDate;
+ (NSString *)setBadgeValueNotification:(id )responseObject;
+ (NSString*)formartFoatValueWithDeal:(NSNumber*)value MinimumFractionDigits:(NSInteger)min;
+ (NSString *)formatDateStock:(NSString *)dateString;
+ (BOOL)isStringDecimalNumber:(NSString *)stringValue;

@end
