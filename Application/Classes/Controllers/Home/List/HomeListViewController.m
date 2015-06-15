//
//  HomeListViewController.m
//  CoAssest
//
//  Created by Macintosh HD on 6/10/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "HomeListViewController.h"
#import "HomeListViewCell.h"
#import "CODummyDataManager.h"
#import "ListHomeObject.h"
#import "LoadFileManager.h"
#import "CODropListVC.h"

@interface HomeListViewController () <UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UITableView *_tableView;
}
@property (strong, nonatomic) NSArray *arrayData;

@end

@implementation HomeListViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

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
    self.navigationItem.title = m_string(@"CoAssest");
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:m_string(@"Filter") style:UIBarButtonItemStyleDone target:self action:@selector(__actionFilter)];
    [self.navigationItem setLeftBarButtonItem:leftButton];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:[HomeListViewCell identifier] bundle:nil] forCellReuseIdentifier:[HomeListViewCell identifier]];
}

#pragma mark - Setter Getter
- (NSArray*)arrayData {
    if (!_arrayData) {
        _arrayData = [[CODummyDataManager shared] arrayListHomeObj];
        return _arrayData;
    }
    return _arrayData;
}

#pragma mark - Action
- (void)__actionFilter {
    NSArray *array = [LoadFileManager loadFilePlistWithName:@"FilterList"];
    [CODropListVC presentWithTitle:m_string(@"Filter") data:array selectedIndex:0 parentVC:self didSelect:^(NSInteger index) {
        
    }];
}

#pragma mark - TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayData.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeListViewCell identifier]];
    
    cell.object = self.arrayData[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  248;
}

@end
