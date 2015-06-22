//
//  EditAboutProfileVC.m
//  CoAssest
//
//  Created by TUONG DANG on 6/16/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "EditAboutProfileVC.h"
#import "CODropListView.h"
#import "COBorderTextField.h"

@interface EditAboutProfileVC ()
{
    __weak IBOutlet COBorderTextField *fristNameTXT;
    __weak IBOutlet COBorderTextField *lastNameTXT;
    __weak IBOutlet COBorderTextField *emailNameTXT;
    __weak IBOutlet COBorderTextField *phoneNameTXT;
    __weak IBOutlet COBorderTextField *addressNameTXT;
}

@end

@implementation EditAboutProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
    self.addressName = self.addressName;
    self.phoneName = self.phoneName;
    self.emailName = self.emailName;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - Set Get
- (void)setAddressName:(NSString *)addressName {
    _addressName = addressName;
    addressNameTXT.text = _addressName;
}

- (void)setPhoneName:(NSString *)phoneName {
    _phoneName = phoneName;
    phoneNameTXT.text = _phoneName;
}

- (void)setEmailName:(NSString *)emailName {
    _emailName = emailName;
    emailNameTXT.text = _emailName;
}

#pragma mark - Private 

- (void)_setupUI {
    
    self.navigationItem.title = m_string(@"Basic Info");
    [self _setupBarButtonCancel];
    [self _setupBarButtonDone];
}

- (void)_setupBarButtonDone {
    UIBarButtonItem *btDone = [[UIBarButtonItem alloc]initWithTitle:m_string(@"Done")
                                                              style:UIBarButtonItemStyleDone
                                                             target:self
                                                             action:@selector(__actionDone:)];
    [btDone setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Raleway-Regular" size:17]}
                          forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btDone;
}

- (void)_setupBarButtonCancel {
    UIBarButtonItem *btCancel = [[UIBarButtonItem alloc]initWithTitle:m_string(@"Cancel")
                                                                style:UIBarButtonItemStyleDone
                                                               target:self
                                                               action:@selector(__actionDCancel:)];
    [btCancel setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Raleway-Regular" size:17]}
                            forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = btCancel;
}


#pragma mark - Action

- (void)__actionDone:(id)sender {
    if (self.actionDone) {
        self.actionDone(emailNameTXT.text,phoneNameTXT.text,addressNameTXT.text);
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)__actionDCancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end
