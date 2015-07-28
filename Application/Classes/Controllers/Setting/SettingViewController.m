//
//  SettingViewController.m
//  CoAssest
//
//  Created by Macintosh HD on 6/10/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "SettingViewController.h"
#import "LoadFileManager.h"
#import "ContacViewController.h"
#import "WebViewSetting.h"
#import "LoginViewController.h"


#define LINK_NEW             @"https://www.coassets.com/news/"
#define LINK_COMMENTARIES    @"https://www.coassets.com/blog/"
#define LINK_TERMS_OF_USE    @"https://www.coassets.com/terms-of-use/"
#define LINK_CODE_OF_CONDUCT @"https://www.coassets.com/code-of-conduct/"
#define LINK_PRIVACY         @"https://www.coassets.com/privacy/"


@interface SettingViewController () <UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,LoginViewControllerDelegate>
{
    __weak IBOutlet UITableView *_tableView;
    WebViewSetting *_webViewSetting;
}

@property (strong, nonatomic) NSArray *arrayData;
@property (strong, nonatomic) NSArray *arraySetting;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
    _webViewSetting = nil;
    [kUserDefaults setObject:@"2" forKey:KEY_TABBARSELECT];
    [kUserDefaults synchronize];
    if (![kUserDefaults boolForKey:KDEFAULT_LOGIN]) {
        [self _replaceArraySettingLogOut];
    } else {
        [self _replaceArraySettingLogin];
    }
}

#pragma mark - Setup
- (void)_setupUI {
    self.navigationItem.title = m_string(@"Settings");
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
}

#pragma mark - Setter Getter
- (NSArray*)arrayData {
    if (!_arrayData) {
        _arrayData = [LoadFileManager loadFilePlistWithName:@"SettingPlist"];
        return _arrayData;
    }
    return _arrayData;
}

- (NSArray*)arraySetting {
    if (!_arraySetting) {
        _arraySetting = self.arrayData;
        return _arraySetting;
    }
    return _arraySetting;
}


#pragma mark - TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arraySetting.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell identifier]];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[UITableViewCell identifier]];
    }
    cell.accessoryType = UITableViewCellSeparatorStyleSingleLine;
    cell.textLabel.text = self.arraySetting[indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont fontWithName:@"Raleway-Regular" size:17];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self __actionForCellWithIndex:indexPath.row];
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Action

- (void)__actionForCellWithIndex:(NSInteger)index {
    switch (index) {
        case COSettingsStypeContact: return [self _pushContacViewController];
            
        case COSettingsStypeNew: return [self _pushWebViewSetting:LINK_NEW titler:@"News"];
            
        case COSettingsStypeCommentaries: return [self _pushWebViewSetting:LINK_COMMENTARIES titler:@"Commentaries"];
            
        case COSettingsStypeTermOfUse: return [self _pushWebViewSetting:LINK_TERMS_OF_USE titler:@"Terms of Use"];
            
        case COSettingsStypeCodeOfConduct: return [self _pushWebViewSetting:LINK_CODE_OF_CONDUCT titler:@"Code of Conduct"];

        case COSettingsStypePrivacy: return [self _pushWebViewSetting:LINK_PRIVACY titler:@"Privacy"];

        case COSettingsStypeLogout: return [self _setupLoginAndLogout];
    }
}

#pragma mark - Private
- (void)_pushWebViewSetting:(NSString*)link titler:(NSString*)titler {
    _webViewSetting = [[WebViewSetting alloc]init];
    _webViewSetting.webLink = link;
    _webViewSetting.titler = m_string(titler);
    [self.navigationController pushViewController:_webViewSetting animated:YES];
}

- (void)_pushContacViewController {
    ContacViewController *vc = [[ContacViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)_setupLoginAndLogout {
    if (![kUserDefaults boolForKey:KDEFAULT_LOGIN]) {
        [self _logginApllication];
    } else {
        [UIHelper showAleartViewWithTitle:m_string(@"CoAssets") message:m_string(@"Are you sure you want to logout?") cancelButton:m_string(@"Cancel") delegate:self tag:0 arrayTitleButton:@[@"OK"]];
    }
}


- (void)_logginApllication {
    LoginViewController *vcLogin = [[LoginViewController alloc]init];
    vcLogin.delegate = self;
    BaseNavigationController *base = [[BaseNavigationController alloc] initWithRootViewController:vcLogin];
    [[kAppDelegate baseTabBarController] presentViewController:base
                                                      animated:YES completion:nil];
}

- (void)_replaceArraySettingLogin {
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.arraySetting];
    for (int i = 0 ; i < arr.count ; i ++) {
        if ([arr[i] isEqualToString:@"Log In"]) {
            [arr replaceObjectAtIndex:i withObject:@"Log Out"];
        }
    }
    self.arraySetting = arr;
    [_tableView reloadData];
}

- (void)_replaceArraySettingLogOut {
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.arraySetting];
    for (int i = 0 ; i < arr.count ; i ++) {
        if ([arr[i] isEqualToString:@"Log Out"]) {
            [arr replaceObjectAtIndex:i withObject:@"Log In"];
        }
    }
    self.arraySetting = arr;
    [_tableView reloadData];
    [kUserDefaults removeObjectForKey:KDEFAULT_LOGIN];
    [kUserDefaults removeObjectForKey:kACCESS_TOKEN];
    [kUserDefaults removeObjectForKey:kTOKEN_TYPE];
    [kUserDefaults removeObjectForKey:kPROFILE_OBJECT];
    [kUserDefaults synchronize];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self _replaceArraySettingLogOut];
    }
}

#pragma mark - Delegate
- (void)loginViewController:(LoginViewController *)loginViewController loginWithStyle:(LoginWithStyle)loginWithStyle {
    switch (loginWithStyle) {
        case DismissLoginVC:
        {
            [[kAppDelegate baseTabBarController] dismissViewControllerAnimated:YES completion:^{
                [self _replaceArraySettingLogOut];
            }];
        } break;
            
        case PushLoginVC:
        {
            [[kAppDelegate baseTabBarController] dismissViewControllerAnimated:YES completion:nil];
        } break;
            
        default: break;
    }
}

@end