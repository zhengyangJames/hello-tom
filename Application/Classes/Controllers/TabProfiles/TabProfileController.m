//
//  TabProfileController.m
//  CoAssets
//
//  Created by Macintosh HD on 10/2/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "TabProfileController.h"
#import "AccountController.h"
#import "DealsController.h"
#import "NProfileController.h"
#import "ProtfolioController.h"
#import "LoadFileManager.h"

@interface TabProfileController ()<UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UITableView *_tableView;
}
@property (strong, nonatomic) NSArray *arrayList;

@end

@implementation TabProfileController

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
    self.navigationItem.title = m_string(@"Profile");
    UIView *view = [[UIView alloc]init];
    _tableView.tableFooterView = view;
    _tableView.dataSource = self;
    _tableView.delegate = self;
}

- (void)_pushViewDealsVC {
    DealsController *deals = [[DealsController alloc]init];
    [self.navigationController pushViewController:deals animated:YES];
}

- (void)_pushViewDetailProfileVC {
    NProfileController *vc = [[NProfileController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)_pushViewAccountVC {
    AccountController *vc = [[AccountController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)_pushViewPortFolio {
    ProtfolioController *vc = [[ProtfolioController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)_pushViewControllerWithIndexPath:(NSInteger)index{
    switch (index) {
        case COProfilesStypeProfile: return [self _pushViewDetailProfileVC];
            
        case COProfilesStypeAccount: return [self _pushViewAccountVC];
            
        case COProfilesStypePortfolio: return [self _pushViewPortFolio];
            
        case COProfilesStypeDealsOngoing: return [self _pushViewDealsVC];
    }
}

#pragma mark - Set Get
- (NSArray*)arrayList {
    if (!_arrayList) {
        _arrayList = [LoadFileManager loadFilePlistWithName:@"ProfileList"];
    }
    return _arrayList;
}

#pragma mark - UITableView - Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayList.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell identifier]];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[UITableViewCell identifier]];
    }
    cell.accessoryType = UITableViewCellSeparatorStyleSingleLine;
    cell.textLabel.text = self.arrayList[indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont fontWithName:@"Raleway-Regular" size:17];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self _pushViewControllerWithIndexPath:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return DEFAULT_HEIGHT_CELL;
}

@end
