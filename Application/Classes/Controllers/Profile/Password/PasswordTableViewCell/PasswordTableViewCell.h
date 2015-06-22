//
//  PasswordTableViewCell.h
//  CoAssest
//
//  Created by TUONG DANG on 6/16/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PasswordTableViewCellDelegate;

@interface PasswordTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *oldPassowrdTXT;
@property (weak, nonatomic) IBOutlet UITextField *newpassowrdTXT;
@property (weak, nonatomic) IBOutlet UITextField *comfilmPassowrdTXT;

@property (weak, nonatomic) id<PasswordTableViewCellDelegate> delegate;

@end

@protocol PasswordTableViewCellDelegate <NSObject>

@optional
- (void)passwordTableViewCellTextFieldAction:(PasswordTableViewCell*)passwordTableViewCell oldPassowrd:(NSString*)oldPassowrd newPassowrd:(NSString*)newPassowrd comfilmPassowrd:(NSString*)comfilmPassowrd;

@end