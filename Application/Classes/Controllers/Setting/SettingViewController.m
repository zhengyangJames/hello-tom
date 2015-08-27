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
#import "COLoginManager.h"

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
    if (![kUserDefaults objectForKey:kUSER]) {
        [self _replaceArraySettingLogOut];
    } else {
        [self _replaceArraySettingLogin];
    }
}

#pragma mark - Setup
- (void)_setupUI {
    self.navigationItem.title = NSLocalizedString(@"SETTINGS", nil);
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
            
        case COSettingsStypeNew: return [self _pushWebViewSetting:LINK_NEW titler:NSLocalizedString(@"NEWS", nil)];
            
        case COSettingsStypeCommentaries: return [self _pushWebViewSetting:LINK_COMMENTARIES titler:NSLocalizedString(@"COMMENTARIES", nil)];
            
        case COSettingsStypeTermOfUse: return [self _pushWebViewSetting:LINK_TERMS_OF_USE titler:NSLocalizedString(@"TERM_OF_USE", nil)];
            
        case COSettingsStypeCodeOfConduct: return [self _pushWebViewSetting:LINK_CODE_OF_CONDUCT titler:NSLocalizedString(@"CODE_OF_CONDUCT", nil)];

        case COSettingsStypePrivacy: return [self _pushWebViewSetting:LINK_PRIVACY titler:NSLocalizedString(@"PRIVACY", nil)];

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
    if (![kUserDefaults objectForKey:kUSER]) {
        [self _logginApllication];
    } else {
        [UIHelper showAlertViewWithTitle:NSLocalizedString(@"COASSETS_TITLE", nil) message:NSLocalizedString(@"MESSAGE_LOGOUT", nil) cancelButton:NSLocalizedString(@"CANCEL_TITLE", nil) delegate:self tag:0 arrayTitleButton:@[NSLocalizedString(@"OK_TITLE", nil)]];
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
        if ([arr[i] isEqualToString:NSLocalizedString(@"LOG_IN", nil)]) {
            [arr replaceObjectAtIndex:i withObject:NSLocalizedString(@"LOG_OUT", nil)];
        }
    }
    self.arraySetting = arr;
    [_tableView reloadData];
}

- (void)_replaceArraySettingLogOut {
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.arraySetting];
    for (int i = 0 ; i < arr.count ; i ++) {
        if ([arr[i] isEqualToString:NSLocalizedString(@"LOG_OUT", nil)]) {
            [arr replaceObjectAtIndex:i withObject:NSLocalizedString(@"LOG_IN", nil)];
        }
    }
    self.arraySetting = arr;
    [_tableView reloadData];
    [kUserDefaults removeObjectForKey:kPROFILE_TOKEN_JSON];
    [kUserDefaults removeObjectForKey:kPROFILE_JSON];
    [kUserDefaults removeObjectForKey:kACCESS_TOKEN];
    [kUserDefaults removeObjectForKey:kTOKEN_TYPE];
    [kUserDefaults removeObjectForKey:kPROFILE_OBJECT];
    [kUserDefaults removeObjectForKey:kUSER];
    [kUserDefaults removeObjectForKey:kPASSWORD];
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
