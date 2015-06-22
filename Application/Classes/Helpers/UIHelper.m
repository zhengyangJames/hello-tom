//
//  UIHelper.m
//  myTomorrows
//
//  Created by Linh NGUYEN on 12/30/14.
//  Copyright (c) 2014 BakBurner Digital, LLC. All rights reserved.
//

#import "UIHelper.h"
#import "MBProgressHUD.h"

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

+ (void)showActionsheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButton destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonsTitle:(NSArray *)arrayTitle delegate:(id)delegate tag:(NSInteger)tag showInView:(UIView *)view {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:delegate cancelButtonTitle:cancelButton destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil];
    actionSheet.tag = tag;
    
    for (NSInteger i = 0; i < arrayTitle.count; i++) {
        NSString *titleButton = [arrayTitle objectAtIndex:i];
        [actionSheet addButtonWithTitle:titleButton];
    }
    [actionSheet showInView:view];
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

@end
