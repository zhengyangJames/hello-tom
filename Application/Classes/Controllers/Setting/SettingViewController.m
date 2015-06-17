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

#define LINK_NEW @"https://www.coassets.com/news/"
#define LINK_COMMENTARIES @"https://www.coassets.com/blog/"
#define LINK_TERMS_OF_USE @"https://www.coassets.com/terms-of-use/"
#define LINK_CODE_OF_CONDUCT @"https://www.coassets.com/code-of-conduct/"
#define LINK_PRIVACY @"https://www.coassets.com/privacy/"


@interface SettingViewController () <UITableViewDelegate,UITableViewDataSource>
{
    __weak IBOutlet UITableView *_tableView;
}
@property (strong, nonatomic) NSArray *arrayData;
@property (strong, nonatomic) WebViewSetting *webViewSetting;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - Setup
- (void)_setupUI {
    self.navigationItem.title = m_string(@"Setting");
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

- (WebViewSetting*)webViewSetting {
    if (!_webViewSetting) {
      return _webViewSetting = [[WebViewSetting alloc]init];
    }
    return _webViewSetting;
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
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self __actionForCellWithIndex:indexPath.row];
    self.webViewSetting = nil;
}

#pragma mark - Action

- (void)__actionForCellWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
        {
            ContacViewController *vc = [[ContacViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            self.webViewSetting.webLink = LINK_NEW;
            self.webViewSetting.titler = m_string(@"News");
            [self.navigationController pushViewController:self.webViewSetting animated:YES];
        }
            break;
        case 2:
        {
            self.webViewSetting.webLink = LINK_COMMENTARIES;
            self.webViewSetting.titler = m_string(@"Commentaries");
            [self.navigationController pushViewController:self.webViewSetting animated:YES];
        }
            break;
        case 3:
        {
            self.webViewSetting.webLink = LINK_TERMS_OF_USE;
            self.webViewSetting.titler = m_string(@"Terms of Use");
            [self.navigationController pushViewController:self.webViewSetting animated:YES];
        }
            break;
        case 4:
        {
            self.webViewSetting.webLink = LINK_CODE_OF_CONDUCT;
            self.webViewSetting.titler = m_string(@"Code of Conduct");
            [self.navigationController pushViewController:self.webViewSetting animated:YES];
        }
            break;
        case 5:
        {
            self.webViewSetting.webLink = LINK_PRIVACY;
            self.webViewSetting.titler = m_string(@"Privacy");
            [self.navigationController pushViewController:self.webViewSetting animated:YES];
        }
            break;
        case 6:
        {
            [kAppDelegate gotoHome];
        }
            break;
            
        default:
            break;
    }
}


@end
