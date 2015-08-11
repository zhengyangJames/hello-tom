//
//  UIHelper.m
//  myTomorrows
//
//  Created by Linh NGUYEN on 12/30/14.
//  Copyright (c) 2014 BakBurner Digital, LLC. All rights reserved.
//

#import "UIHelper.h"
#import "MBProgressHUD.h"
#import "COOferObj.h"
#import "COOfferItemObj.h"
#import "CODetailsProfileObj.h"

#define IS_IOS8             ((NSInteger)[[[UIDevice currentDevice] systemVersion] floatValue]) == 8

@implementation UIHelper

+ (void)showLoadingInView:(UIView*)view
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [MBProgressHUD showHUDAddedTo:view animated:YES];
    }];
}

+ (void)hideLoadingFromView:(UIView*)view
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [MBProgressHUD hideAllHUDsForView:view animated:YES];
    }];
}

+ (void)showLoadingIndicator
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

+ (void)hideLoadingIndicator
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

+ (void)showAleartViewWithTitle:(NSString *)title message:(NSString *)message cancelButton:(NSString *)cancelButton delegate:(id)delegate tag:(NSInteger)tag arrayTitleButton:(NSArray *)arrayTitel {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title
                                                   message: message
                                                  delegate: delegate
                                         cancelButtonTitle:cancelButton
                                         otherButtonTitles: nil];
    alert.tag = tag;
    for (NSInteger i = 0; i< arrayTitel.count; i++) {
        NSString *title_ = [arrayTitel objectAtIndex:i];
        [alert addButtonWithTitle:title_];
    }
    [alert show];
    
}

+ (void)showAlertViewErrorWithMessage:(NSString *)message delegate:(id)delegate tag:(NSInteger)tag {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"COASSETS_TITLE", nil)
                                                   message: message
                                                  delegate: delegate
                                         cancelButtonTitle:NSLocalizedString(@"OK_TITLE", nil)
                                         otherButtonTitles: nil];
    alert.tag = tag;
    [alert show];
}


+ (void)showActionsheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButton destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonsTitle:(NSArray *)arrayTitle delegate:(id)delegate tag:(NSInteger)tag showInView:(UIView *)view {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:delegate cancelButtonTitle:cancelButton destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil];
    actionSheet.tag = tag;
    
    for (NSInteger i = 0; i < arrayTitle.count; i++) {
        NSString *titleButton = [arrayTitle objectAtIndex:i];
        [actionSheet addButtonWithTitle:titleButton];
    }
    [actionSheet showInView:view];
}

+ (void)showError:(NSError *)error {
    if(!error) return;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        NSString *message = nil;
        if([error.userInfo objectForKey:@"message"])
        {
            message = [error.userInfo objectForKey:@"message"];
        } else {
            message = error.localizedDescription;
        }
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:m_string(@"CoAssets")
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:m_string(@"OK")
                                                  otherButtonTitles:nil];
        [alertView show];
        alertView = nil;
    }];
}

+ (UIImagePickerController *)showImagePickerAtController:(UIViewController *)controller withDelegate:(id)delegate andMode:(NSInteger)mode
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = delegate;
    switch (mode) {
        case 0:
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                picker.mediaTypes = @[(NSString *)kUTTypeImage];
                if(IS_IOS8) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [controller presentViewController:picker animated:YES completion:nil];
                    }];
                } else {
                    [controller presentViewController:picker animated:YES completion:nil];
                }
            }
            break;
        case 1:
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                picker.allowsEditing = YES;
                if(IS_IOS8) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [controller presentViewController:picker animated:YES completion:nil];
                    }];
                } else {
                    [controller presentViewController:picker animated:YES completion:nil];
                }
            }
            break;
            
        default:
            break;
    }
    return picker;
}

+ (NSArray *)getListOfferDetailWihtDict:(NSDictionary *)dict {
    NSMutableArray *arrObj = [[NSMutableArray alloc] init];
    if (dict) {
        if ([dict objectForKeyNotNull:@"offer_title"]) {
            COOferObj *off = [[COOferObj alloc] init];
            COOfferItemObj *offItem = [[COOfferItemObj alloc] init];
            offItem.title = [dict objectForKeyNotNull:@"offer_title"];
            offItem.offerID = [dict objectForKeyNotNull:@"id"];
            offItem.linkOrDetail = [dict objectForKeyNotNull:@"company_logo"];
            off.type = @"title";
            off.offerItemObjs = @[offItem];
            [arrObj addObject:off];
        }
        
        if ([dict objectForKeyNotNull:@"id"]) {
            COOferObj *off = [[COOferObj alloc] init];
            CODetailsProfileObj *profileObj = [[CODetailsProfileObj alloc]init];
            profileObj.investor_count = [dict objectForKeyNotNull:@"investor_count"];
            profileObj.status = [dict objectForKeyNotNull:@"status"];
            profileObj.min_annual_return = [dict valueForKeyNotNull:@"min_annual_return"];
            profileObj.min_investment = [dict objectForKeyNotNull:@"min_investment"];
            profileObj.day_left = [dict objectForKeyNotNull:@"day_left"];
            profileObj.time_horizon = [dict objectForKeyNotNull:@"time_horizon"];
            off.type = @"project";
            off.offerItemObjs = @[profileObj];
            [arrObj addObject:off];
        }
        
        if ([dict objectForKeyNotNull:@"short_description"]) {
            COOferObj *off = [[COOferObj alloc] init];
            COOfferItemObj *offItem = [[COOfferItemObj alloc] init];
            offItem.title = @"OFFER";
            offItem.htmlDetail = [UIHelper _getStringFromHtml:[dict objectForKeyNotNull:@"short_description"]];
            off.type = @"description";
            off.offerItemObjs = @[offItem];
            [arrObj addObject:off];
        }
        
        if ([dict objectForKeyNotNull:@"project_description"]) {
            COOferObj *off = [[COOferObj alloc] init];
            COOfferItemObj *offItem = [[COOfferItemObj alloc] init];
            offItem.title = @"PROJECT";
            offItem.htmlDetail = [UIHelper _getStringFromHtml:[dict objectForKeyNotNull:@"project_description"]];
            offItem.linkOrDetail = [dict objectForKeyNotNull:@"project_description"];
            off.type = @"description";
            off.offerItemObjs = @[offItem];
            [arrObj addObject:off];
        }
        
        if ([dict objectForKeyNotNull:@"documents"]) {
            NSDictionary *dictDocument = [dict objectForKeyNotNull:@"documents"];
            if (dictDocument) {
                COOferObj *off = [[COOferObj alloc] init];
                COOfferItemObj *offItem = [[COOfferItemObj alloc] init];
                offItem.title = @"DOCUMENTS";
                offItem.stringDetail = @"The following are documents uploaded by OP for the projects. For documents that are marked as PRIVATE - please contact us to review.";
                off.type = @"description";
                off.offerItemObjs = @[offItem];
                [arrObj addObject:off];
                
                for (NSString *key in [dictDocument allKeys]) {
                    if ([dictDocument objectForKeyNotNull:key]) {
                        COOferObj *off = [[COOferObj alloc] init];
                        NSArray *arrayObj = [dictDocument objectForKeyNotNull:key];
                        NSMutableArray *arrOffer = [[NSMutableArray alloc] init];
                        if (arrayObj.count > 0) {
                            for (NSDictionary *dictObj in arrayObj) {
                                COOfferItemObj *offItem = [[COOfferItemObj alloc] init];
                                offItem.linkOrDetail = [dictObj objectForKeyNotNull:@"url"];
                                offItem.title = [dictObj objectForKeyNotNull:@"title"];
                                [arrOffer addObject:offItem];
                            }
                        } else {
                            COOfferItemObj *offItem = [[COOfferItemObj alloc] init];
                            offItem.linkOrDetail = nil;
                            offItem.title = @"No Documents Uploaded";
                            [arrOffer addObject:offItem];
                        }
                        off.type = key;
                        off.offerItemObjs = arrOffer;
                        [arrObj addObject:off];
                    }
                }
            }
        }
        
        if ([dict objectForKeyNotNull:@"project"]) {
            NSString *address = @"";
            NSMutableDictionary *dictObject = [dict objectForKeyNotNull:@"project"];
            NSString *address1 = [dictObject objectForKeyNotNull:@"address_1"];
            if (address1 && ![address1 isEmpty]) {
                address = [address stringByAppendingString:address1];
            }
            NSString *address2 = [dictObject objectForKeyNotNull:@"address_2"];
            if (address2 && ![address2 isEmpty]) {
                address = [[address stringByAppendingString:@"\n"] stringByAppendingString:address2];
            }
            NSString *city = [dictObject objectForKeyNotNull:@"city"];
            if (city && ![city isEmpty]) {
                address = [[address stringByAppendingString:@"\n"] stringByAppendingString:city];
            }
            NSString *country = [dictObject objectForKeyNotNull:@"country"];
            if (country && ![country isEmpty]) {
                address = [[address stringByAppendingString:@"\n"] stringByAppendingString:country];
            }
            COOferObj *off = [[COOferObj alloc] init];
            COOfferItemObj *offItem = [[COOfferItemObj alloc] init];
            offItem.title = @"ADDRESS";
            offItem.stringDetail = address;
            offItem.photo = [dictObject objectForKeyNotNull:@"photo"];
            off.offerItemObjs = @[offItem];
            [arrObj addObject:off];
        }
    }
    return arrObj;
}

+ (NSAttributedString *)_getStringFromHtml:(NSString *)stringHtml {
    NSString *htmlString = [DEFINE_HTML_FRAME stringByReplacingOccurrencesOfString:@"%@" withString:stringHtml];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    return attributedString;
    
}

+ (NSString *)stringCurrencyFormatFromNumberDouble:(NSNumber*)number {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSString *cvString  = [formatter stringFromNumber:number];
    NSString *returnString = [cvString substringToIndex:cvString.length - 3];
    return returnString;
}

@end
