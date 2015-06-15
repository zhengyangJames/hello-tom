//
//  ContacViewController.m
//  CoAssest
//
//  Created by TUONG DANG on 6/15/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "ContacViewController.h"
#import "CODummyDataManager.h"
#import "ContactTableViewCell.h"

@interface ContacViewController () <UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UITableView *_tableView;
    ContactTableViewCell *_contactCell;
}
@property (strong, nonatomic) NSArray *arrayData;

@end

@implementation ContacViewController

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
    self.navigationItem.title = m_string(@"Contact");
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:m_string(@"Back") style:UIBarButtonItemStyleDone target:self action:@selector(__actionBack)];
    [self.navigationItem setLeftBarButtonItem:leftButton];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:[ContactTableViewCell identifier] bundle:nil] forCellReuseIdentifier:[ContactTableViewCell identifier]];
    _contactCell = [_tableView dequeueReusableCellWithIdentifier:[ContactTableViewCell identifier]];
}

#pragma mark - Action 
- (void)__actionBack {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Setter Getter
- (NSArray*)arrayData {
    if (!_arrayData) {
        _arrayData = [[CODummyDataManager shared] arrayContactObj];
        return _arrayData;
    }
    return _arrayData;
}


#pragma mark - TableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayData.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ContactTableViewCell identifier]];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = [_contactCell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];

    return size.height;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95.f;
}

- (void)configureCell:(ContactTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.contactObj = self.arrayData[indexPath.row];
}

@end
