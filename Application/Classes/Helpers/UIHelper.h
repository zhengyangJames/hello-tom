//
//  UIHelper.h
//  myTomorrows
//
//  Created by Linh NGUYEN on 12/30/14.
//  Copyright (c) 2014 BakBurner Digital, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface UIHelper : NSObject



+ (void)showLoadingInView:(UIView*)view;
+ (void)hideLoadingFromView:(UIView*)view;

+ (void)showLoadingIndicator;
+ (void)hideLoadingIndicator;

+ (void)showAlertViewErrorWithMessage:(NSString *)message delegate:(id)delegate tag:(NSInteger)tag;
+ (void)showAleartViewWithTitle:(NSString *)title message:(NSString *)message cancelButton:(NSString *)cancelButton delegate:(id)delegate tag:(NSInteger)tag arrayTitleButton:(NSArray *)arrayTitel;
+ (void)showActionsheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButton destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonsTitle:(NSArray *)arrayTitle delegate:(id)delegate tag:(NSInteger)tag showInView:(UIView *)view;
+ (void)showError:(NSError *)error;

+ (UIImagePickerController *)showImagePickerAtController:(UIViewController *)controller withDelegate:(id)delegate andMode:(NSInteger)mode;

+ (NSArray *)getListOfferDetailWihtDict:(NSDictionary *)dict;
+ (NSString *)stringCurrencyFormatFromNumberDouble:(NSNumber*)number;
@end
