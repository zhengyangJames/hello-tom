//
//  ContacViewController.m
//  CoAssest
//
//  Created by TUONG DANG on 6/15/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "ContacViewController.h"
#import "ContactTableViewCell.h"
#import "WSURLSessionManager+ListContact.h"
#import "WSURLSessionManager.h"
#import "WSGetListContactsRequest.h"

#define TitleSection0  @"SINGAPORE OFFICE"
#define TitleSection1  @"MALAYSIA OFFICE"
#define TitleSection2  @"AUSTRALIA OFFICE"
#define HIEGHT_FOOTER  500

#define IS_IOS8_OR_ABOVE    [[[UIDevice currentDevice] systemVersion] floatValue] >= 8

@interface ContacViewController () <UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UITableView *_tableView;
}
@property (strong, nonatomic) NSArray *arrayData;
@property (strong, nonatomic) NSArray *listSection;
@end

@implementation ContacViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _wsGetListContact];
    [self _setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - Setup
- (void)_setupUI {
    self.navigationItem.title = NSLocalizedString(@"CONTACT", nil);
    
    _tableView.separatorStyle = UITableViewScrollPositionNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    
    [_tableView registerNib:[UINib nibWithNibName:[ContactTableViewCell identifier] bundle:nil] forCellReuseIdentifier:[ContactTableViewCell identifier]];
}

#pragma mark - Action 
- (void)__actionBack {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Setter Getter
- (NSArray*)arrayData {
    if (!_arrayData) {
        _arrayData = [[NSArray alloc]init];
        return _arrayData;
    }
    return _arrayData;
}

- (NSArray*)listSection {
    if (!_listSection) {
        return _listSection = @[TitleSection0,TitleSection1,TitleSection2];
    }
    return _listSection;
}

#pragma mark - Private

- (CGFloat)_heightForTableView:(UITableView*)tableView cell:(UITableViewCell*)cell atIndexPath:(NSIndexPath *)indexPath {
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    CGSize cellSize = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return cellSize.height;
}

- (UIView*)_setupviewForHeaderInSection:(NSInteger)section {
    UIView *view   = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, HEIGHT_SECTION_CONTACT)];
    UILabel *label = [UILabel autoLayoutView];
    [label setFont:[UIFont fontWithName:@"Raleway-Medium" size:16]];
    [label setTextColor:KGREEN_COLOR];
    [label setText:[self.listSection objectAtIndex:section]];
    [view addSubview:label];
    [label pinToSuperviewEdges:JRTViewPinLeftEdge|JRTViewPinRightEdge inset:16];
    [label pinToSuperviewEdges:JRTViewPinTopEdge|JRTViewPinBottomEdge inset:0];
    [view setBackgroundColor:KGRAY_COLOR];
    return view;
}

#pragma mark - Call WService

- (void)_wsGetListContact {
    [UIHelper showLoadingInView:self.view];
    [[WSURLSessionManager shared] wsGetListContactWithRequest:[self _createListContactsRequest] handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSArray class]]) {
            self.arrayData = (NSArray*)responseObject;
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [_tableView reloadData];
            }];
        } else {
            [ErrorManager showError:error];
        }
        [UIHelper hideLoadingFromView:self.view];
    }];
}

- (WSGetListContactsRequest *)_createListContactsRequest {
    WSGetListContactsRequest *request = [[WSGetListContactsRequest alloc] init];
    [request setURL:[NSURL URLWithString:[WS_METHOD_GET_LIST_CONTACT stringByAppendingString:@"/"]]];
    [request setHTTPMethod:METHOD_GET];
    return  request;
}

#pragma mark - TableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arrayData.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self _setupviewForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HEIGHT_SECTION_CONTACT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [self _setupContactCell:tableView indexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    } else if (indexPath.section == 1) {
        return [self _setupContactCell:tableView indexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    } else {
        return [self _setupContactCell:tableView indexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    CGFloat height = 0;
    if(IS_IOS8_OR_ABOVE) {
        return UITableViewAutomaticDimension;
    } else {
        id cell = [self _setupContactCell:tableView indexPath:indexPath];
        CGFloat height = [self _heightForTableView:tableView cell:cell atIndexPath:indexPath];
        return height;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return ESTIMATE_HEIGHT_FOR_ROW_CONTACT;
}

- (ContactTableViewCell*)_setupContactCell:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ContactTableViewCell identifier]];
    if (indexPath.section == 0) {
        cell.contactModel = self.arrayData[0];
    } else if (indexPath.section == 1) {
        cell.contactModel = self.arrayData[1];
    } else {
        cell.contactModel = self.arrayData[2];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
