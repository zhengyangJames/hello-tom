//
//  AccountController.m
//  CoAssets
//
//  Created by Macintosh HD on 10/2/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "AccountController.h"
#import "AccountCell.h"
#import "LoadFileManager.h"

@interface AccountController ()<UITableViewDelegate, UITableViewDataSource>
{
    __weak IBOutlet UITableView *_tableView;
    
}
@property (strong, nonatomic) NSArray *arrayList;
@end

@implementation AccountController

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
    self.navigationItem.title = m_string(@"Account");
    [_tableView registerNib:[UINib nibWithNibName:[AccountCell identifier] bundle:nil] forCellReuseIdentifier:[AccountCell identifier]];
    UIView *view = [[UIView alloc]init];
    _tableView.tableFooterView = view;
    _tableView.dataSource = self;
    _tableView.delegate = self;
}

#pragma mark - Set Get
- (NSArray*)arrayList {
    if (!_arrayList) {
        _arrayList = [LoadFileManager loadFilePlistWithName:@"AccountPlist"];
    }
    return _arrayList;
}

#pragma mark - UITableView - Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayList.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AccountCell *cell = [tableView dequeueReusableCellWithIdentifier:[AccountCell identifier] forIndexPath:indexPath];
    cell.object = self.arrayList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
