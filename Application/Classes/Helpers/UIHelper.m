//
//  UIHelper.m
//  myTomorrows
//
//  Created by Linh NGUYEN on 12/30/14.
//  Copyright (c) 2014 BakBurner Digital, LLC. All rights reserved.
//

#import "UIHelper.h"
#import "MBProgressHUD.h"
#import "CODetailsProfileObj.h"
#import "CODetailsProfileObj+Mapping.h"

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

+ (NSAttributedString *)_getStringFromHtml:(NSString *)stringHtml {
    NSString *htmlString = [DEFINE_HTML_FRAME stringByReplacingOccurrencesOfString:@"%@" withString:stringHtml];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    return attributedString;
    
}

+ (NSString *)stringDecimalFormatFromNumberDouble:(NSNumber*)number {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *cvString  = [formatter stringFromNumber:number];
    return cvString;
}

+ (NSString *)stringCurrencyFormatFromNumberDouble:(NSNumber*)number {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSString *cvString  = [formatter stringFromNumber:number];
    NSString *stringF = [cvString substringToIndex:cvString.length - 3];
    return stringF;
}

@end
