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

+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButton:(NSString *)cancelButton delegate:(id)delegate tag:(NSInteger)tag arrayTitleButton:(NSArray *)arrayTitel {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
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
    }];
}

+ (void)showAlertViewErrorWithMessage:(NSString *)message delegate:(id)delegate tag:(NSInteger)tag {
   [[NSOperationQueue mainQueue] addOperationWithBlock:^{
       UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"COASSETS_TITLE", nil)
                                                      message: message
                                                     delegate: delegate
                                            cancelButtonTitle:NSLocalizedString(@"OK_TITLE", nil)
                                            otherButtonTitles: nil];
       alert.tag = tag;
       [alert show];
   }];
}


+ (void)showActionsheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButton destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonsTitle:(NSArray *)arrayTitle delegate:(id)delegate tag:(NSInteger)tag showInView:(UIView *)view {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:delegate cancelButtonTitle:cancelButton destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil];
        actionSheet.tag = tag;
        
        for (NSInteger i = 0; i < arrayTitle.count; i++) {
            NSString *titleButton = [arrayTitle objectAtIndex:i];
            [actionSheet addButtonWithTitle:titleButton];
        }
        [actionSheet showInView:view];
    }];
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
    [picker setAllowsEditing:YES];
    switch (mode) {
        case 1:
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
        case 2:
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                if(IS_IOS8) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [controller presentViewController:picker animated:YES completion:nil];
                    }];
                } else {
                    [controller presentViewController:picker animated:YES completion:nil];
                }
            }
            break;
            
        default: break;
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

+ (NSString *)getStringCurrencyOfferWithKey:(NSString*)keyCurrency {
    NSDictionary *objCurrency = @ {@"SGD": @"Singapore Dollars",
        @"USD" : @"US Dollars",
        @"GBP" : @"British Pounds",
        @"EUR" : @"Euros",
        @"JPY" : @"Japanese Yen",
        @"CNY" : @"Chinese Yuan",
        @"TWD" : @"Taiwan Dollar",
        @"CAD" : @"Canadian Dollars",
        @"HKD" : @"Hongkong Dollar",
        @"AUD" : @"Australia Dollar",
        @"MYR" : @"Malaysia Ringit",
        @"THB" : @"Thai Baht",
        @"PHP" : @"Philippine Peso",
        @"IDR" : @"Indonesia Rupiah",
        @"VND" : @"Vietnamese Dong"
    };
    return [objCurrency objectForKeyNotNull:keyCurrency];
}

+ (NSString *)getStringCurrencyOfferWithValue:(NSString*)value {
    NSDictionary *objCurrency = @ {@"SGD": @"Singapore Dollars",
        @"USD" : @"US Dollars",
        @"GBP" : @"British Pounds",
        @"EUR" : @"Euros",
        @"JPY" : @"Japanese Yen",
        @"CNY" : @"Chinese Yuan",
        @"TWD" : @"Taiwan Dollar",
        @"CAD" : @"Canadian Dollars",
        @"HKD" : @"Hongkong Dollar",
        @"AUD" : @"Australia Dollar",
        @"MYR" : @"Malaysia Ringit",
        @"THB" : @"Thai Baht",
        @"PHP" : @"Philippine Peso",
        @"IDR" : @"Indonesia Rupiah",
        @"VND" : @"Vietnamese Dong"
    };
    NSString *key;
    for (int i = 0 ; i < [objCurrency allKeys].count ; i ++ ) {
        NSArray *arr = [objCurrency allValues];
        NSString *str = arr[i];
        if ([str isEqualToString:value]) {
            NSArray *arrkey = [objCurrency allKeys];
            key = arrkey[i];
            break;
        }
    }
    return key;
}

+ (NSArray*)getArrayCurrency {
    NSArray *objCurrency = @[@"Singapore Dollars",
        @"US Dollars",
        @"British Pounds",
        @"Euros",
        @"Japanese Yen",
        @"Chinese Yuan",
        @"Taiwan Dollar",
        @"Canadian Dollars",
        @"Hongkong Dollar",
        @"Australia Dollar",
        @"Malaysia Ringit",
        @"Thai Baht",
        @"Philippine Peso",
        @"Indonesia Rupiah",
        @"Vietnamese Dong"
    ];
    return objCurrency;
}

+ (NSArray*)getInvestorType {
    NSArray *array = @[@"Agent",
                       @"Business",
                       @"Developer",
                       @"Educator",
                       @"Financier",
                       @"High Net Worth",
                       @"Institutional Investor",
                       @"Media",
                       @"Retail Investor",
                       @"Others",
                       @"Services"];
    
    return array;
}

+ (NSString *)getInvestorTypeWithKey:(NSString *)key {
    NSDictionary *dic = @{
                          @"AGY" : @"Agent",
                          @"BSN" : @"Business",
                          @"DEV" : @"Developer",
                          @"EDU" : @"Educator",
                          @"FIN" : @"Financier",
                          @"HNW" : @"High Net Worth",
                          @"INI" : @"Institutional Investor",
                          @"MED" : @"Media",
                          @"NRM" : @"Retail Investor",
                          @"OTH" : @"Others",
                          @"SER" : @"Services"
                          };
    return [dic objectForKeyNotNull:key];
}

+ (NSString *)getInvestorTypeWithValue:(NSString *)value {
    NSDictionary *dic = @{
                          @"AGY" : @"Agent",
                          @"BSN" : @"Business",
                          @"DEV" : @"Developer",
                          @"EDU" : @"Educator",
                          @"FIN" : @"Financier",
                          @"HNW" : @"High Net Worth",
                          @"INI" : @"Institutional Investor",
                          @"MED" : @"Media",
                          @"NRM" : @"Retail Investor",
                          @"OTH" : @"Others",
                          @"SER" : @"Services"
                          };
    NSString *key;
    for (int i = 0 ; i < [dic allKeys].count ; i ++ ) {
        NSArray *arr = [dic allValues];
        NSString *str = arr[i];
        if ([str isEqualToString:value]) {
            NSArray *arrkey = [dic allKeys];
            key = arrkey[i];
            break;
        }
    }
    return key;
}

+ (NSArray *)arrayProjectType {
    NSArray *array = @[
                       @"Bulk Purchases",
                       @"Pre-sales",
                       @"Crowdfunding"
                       ];
    return array;
}

+ (NSString *)getProjectTypeWithKey:(NSString*)key {
    NSDictionary *dic = @{
                          @"BKP" : @"Bulk Purchases",
                          @"DEV" : @"Pre-sales",
                          @"EQC" : @"Crowdfunding",
                          };
    return [dic objectForKeyNotNull:key];
}

+ (NSString *)getProjectTypeWithValue:(NSString*)value {
    NSDictionary *dic = @{
                          @"BKP" : @"Bulk Purchases",
                          @"DEV" : @"Pre-sales",
                          @"EQC" : @"Crowdfunding",
                          };
    NSString *key;
    for (int i = 0 ; i < [dic allKeys].count ; i ++ ) {
        NSArray *arr = [dic allValues];
        NSString *str = arr[i];
        if ([str isEqualToString:value]) {
            NSArray *arrkey = [dic allKeys];
            key = arrkey[i];
            break;
        }
    }
    return key;
}

+ (CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
}

+ (NSString *)getLinkImageWithUrl:(NSURL*)urlImage {
    NSString *imageName = urlImage.path.lastPathComponent;
    NSString *urlDocument = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *localPath = [urlDocument stringByAppendingPathComponent:imageName];
    return localPath;
}

+ (NSMutableDictionary*)getParamTokenWithModel:(COUserProfileModel *)model {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    if (model.stringOfAccessToken) {
        dic[kACCESS_TOKEN] = model.stringOfAccessToken;
    } else {
        dic[kACCESS_TOKEN] = @"";
    }
    if (model.stringOfTokenType) {
        dic[kTOKEN_TYPE] = model.stringOfTokenType;
    } else {
        dic[kTOKEN_TYPE] = @"";
    }
    return dic;
}

+ (NSString*)formartDoubleValueWithAccountInvest:(NSNumber*)value {
    return [NSString stringWithFormat:@"$%.2f",[value doubleValue]];
}

+ (NSString *)formatStringUnknown:(NSString *)string {
    if ([string isEqualToString:@"Unknown"]) {
        return @"0";
    }
    if ([string isEqualToString:@"0"]) {
        return @"Unknown";
    }
    if ([string isEmpty]) {
        return @"Unknown";
    }
    return string;
}

+ (NSString*)formartStringDuration:(NSString*)string {
    string = [self formatStringUnknown:string];
    if ([string isEqualToString:@"Unknown"] || [string isEqualToString:@"0"]) {
        return string;
    }
    return [NSString stringWithFormat:@"%@ mth",string];
}

+ (NSString*)formartStringTarget:(NSString*)string {
    string = [self formatStringUnknown:string];
    if ([string isEqualToString:@"Unknown"] || [string isEqualToString:@"0"]) {
        return string;
    }
    return [NSString stringWithFormat:@"%@ %%",string];
}

+ (NSString*)getNumberInstring:(NSString*)value {
    // Intermediate
    NSString *numberString;
    NSScanner *scanner = [NSScanner scannerWithString:value];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    // Throw away characters before the first number.
    [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
    // Collect numbers.
    [scanner scanCharactersFromSet:numbers intoString:&numberString];
    // Result.
    NSInteger integer = [numberString integerValue];
    NSString *string = [NSString stringWithFormat:@"%li",(long)integer];
    return string;
}

+ (CGFloat)convertStringToCGfloat:(NSString*)string {
    NSNumber *number = [NSNumber numberWithChar:[string characterAtIndex:string.length]];
    return [number floatValue];
}

+ (NSString*)formartFoatValueWithPortfolio:(NSNumber*)value {
    NSNumberFormatter * formatter = [NSNumberFormatter new];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2]; // Set this if you need 2 digits
    [formatter setMinimumFractionDigits:2];
    NSString * newString =  [formatter stringFromNumber:[NSNumber numberWithFloat:[value floatValue]]];
    return [NSString stringWithFormat:@"$%@",newString];
}

+ (NSString *)formatStringDateToString:(NSString*)strDate {
    if (strDate != nil) {
        NSDateFormatter *format = [[NSDateFormatter alloc]init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ssZ"];
        NSDate *date = [format dateFromString:strDate];
        NSString *strdate = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle];
        return strdate;
    }
    return nil;
}

+ (NSString *)setBadgeValueNotification:(id )responseObject {
    NSArray *dataArray = [[NSArray alloc]init];
    dataArray = (NSArray *)responseObject;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"notifiData.notifiStatus == %@", @"UNREAD"];
    NSArray *filtered  = [dataArray filteredArrayUsingPredicate:predicate];
    NSString *inStr = [NSString stringWithFormat: @"%lu", (unsigned long)filtered.count];

    if (inStr != nil) {
        return inStr;
    }
    return nil;
}

@end
