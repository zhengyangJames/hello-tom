//
//  DealsController.m
//  CoAssets
//
//  Created by Macintosh HD on 10/2/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "DealsController.h"
#import "COPositive&NagitiveButton.h"
#import "HomeListViewController.h"

@interface DealsController ()
{
    __weak IBOutlet UISegmentedControl *_segment;
    __weak IBOutlet UILabel *_introductionLabel;
    __weak IBOutlet UIView *_contentView;
    __weak IBOutlet UITableView *_tableView;
    __weak IBOutlet UILabel *_greatLabel;
    __weak IBOutlet COPositive_NagitiveButton *__greatButton;
}

@end

@implementation DealsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setUpUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - Private

- (void)_setUpUI {
    self.navigationItem.title = NSLocalizedString(@"Deals", nil);
    [_segment setSelectedSegmentIndex:0];
    [_segment setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Raleway-Regular" size:15]} forState:UIControlStateNormal];
    [_tableView setHidden:YES];
    [self _setTilerLabelAndButton];
}

- (void)_setTilerLabelAndButton {
    _greatLabel.text = m_string(@"TITLE_LABEL");
    [__greatButton setTitle:m_string(@"TITLE_BUTTON") forState:UIControlStateNormal];
}

- (void)_setHiddenLabelAndButton:(BOOL)value {
    [__greatButton setHidden:value];
    [_greatLabel setHidden:value];
}

#pragma mark - Action
- (IBAction)__actionSegment:(id)sender {
    _segment = (UISegmentedControl*)sender;
    switch (_segment.selectedSegmentIndex) {
        case CODealsStypeOngoing:
            _introductionLabel.text = m_string(@"ON_GOING");
            [self _setHiddenLabelAndButton:NO];
            break;
        case CODealsStypeCompleted:
            _introductionLabel.text = m_string(@"COMPLETED");
            [self _setHiddenLabelAndButton:NO];
            break;
        case CODealsStypeFunded:
            _introductionLabel.text = m_string(@"FUNDED");
            [self _setHiddenLabelAndButton:NO];
            break;
//        case CODealsStypeSuggest:
//            _introductionLabel.text = m_string(@"SUGEST");
//            [self _setHiddenLabelAndButton:YES];
//            break;
        default:  break;
    }
}

- (IBAction)__actionButtonGetStart:(id)sender {
    BaseTabBarController *base = [kAppDelegate baseTabBarController];
    [base setSelectedIndex:0];
}

@end
