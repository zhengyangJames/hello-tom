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

#define LINK_NEW             @"https://www.coassets.com/news/"
#define LINK_COMMENTARIES    @"https://www.coassets.com/blog/"
#define LINK_TERMS_OF_USE    @"https://www.coassets.com/terms-of-use/"
#define LINK_CODE_OF_CONDUCT @"https://www.coassets.com/code-of-conduct/"
#define LINK_PRIVACY         @"https://www.coassets.com/privacy/"


@interface SettingViewController () <UITableViewDelegate,UITableViewDataSource>
{
    __weak IBOutlet UITableView *_tableView;
    WebViewSetting *_webViewSetting;
}

@property (strong, nonatomic) NSArray *arrayData;

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

#pragma mark - TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayData.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell identifier]];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[UITableViewCell identifier]];
    }
    cell.accessoryType = UITableViewCellSeparatorStyleSingleLine;
    cell.textLabel.text = self.arrayData[indexPath.row];
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

        case COSettingsStypeLogout: return [kAppDelegate gotoHome];
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

@end
