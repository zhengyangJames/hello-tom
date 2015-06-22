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
#import "DetailsViewController.h"
#import "LoginViewController.h"

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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - Setup
- (void)_setupUI {
    self.navigationItem.title = m_string(@"CoAssests");
    [self _setupLeftBarButton];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    
    [_tableView registerNib:[UINib nibWithNibName:[HomeListViewCell identifier] bundle:nil]
     forCellReuseIdentifier:[HomeListViewCell identifier]];
}

- (void)_setupLeftBarButton {
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:m_string(@"Filter")
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(__actionFilter)];
    [leftButton setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Raleway-Regular"
                                                                             size:17]}
                              forState:UIControlStateNormal];
    
    [self.navigationItem setLeftBarButtonItem:leftButton];
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

- (CGFloat)_heightForTableView:(UITableView*)tableView cell:(UITableViewCell*)cell atIndexPath:(NSIndexPath *)indexPath {
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    CGSize cellSize = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return cellSize.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayData.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self _setupHomeListCell:tableView cellForRowAtIndexPath:indexPath];;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LoginViewController *vc = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 248;
//    if(IS_IOS8_OR_ABOVE) {
//        return UITableViewAutomaticDimension;
//    } else {
//        id cell = [self _setupHomeListCell:tableView cellForRowAtIndexPath:indexPath];
//        height = [self _heightForTableView:tableView cell:cell atIndexPath:indexPath];
//    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 248;
}

- (HomeListViewCell*)_setupHomeListCell:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeListViewCell identifier]];
    
    cell.object = self.arrayData[arc4random() % self.arrayData.count];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
