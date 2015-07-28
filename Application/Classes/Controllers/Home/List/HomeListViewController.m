//
//  HomeListViewController.m
//  CoAssest
//
//  Created by Macintosh HD on 6/10/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "HomeListViewController.h"
#import "HomeListViewCell.h"
#import "LoadFileManager.h"
#import "CODropListVC.h"
#import "DetailsViewController.h"
#import "LoginViewController.h"
#import "COLIstOffersObject.h"
#import "MBProgressHUD.h"
#import "WSURLSessionManager.h"
#import "WSURLSessionManager+ListHome.h"
#import "COProgressbarObj.h"
#import "COOferObj.h"
#import "COOfferItemObj.h"

#define kFILTER_CO  @"/CO"
#define kFILTER_PS  @"/PS"
#define kFILTER_BP  @"/BP"

typedef void(^ActionGetIndexPath)(NSIndexPath *indexPath);

@interface HomeListViewController () <UITableViewDataSource,UITableViewDelegate,LoginViewControllerDelegate>
{
    __weak IBOutlet UITableView *_tableView;
    UIBarButtonItem *_leftButton;
    NSInteger _indexSelectFilter;
    NSIndexPath *_indexPathForCell;
}
@property (copy, nonatomic) ActionGetIndexPath actionGetIndexPath;
@property (strong, nonatomic) NSArray *arrayData;
@property (strong, nonatomic) NSArray *arrayListFilter;
@property (strong, nonatomic) NSArray *arraySort;
@property (strong, nonatomic) COProgressbarObj *profressbarObj;

@end

@implementation HomeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
    [self _callAPIGetAllOffers];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
    
    [kUserDefaults setObject:@"0" forKey:KEY_TABBARSELECT];
    [kUserDefaults synchronize];
}

#pragma mark - Setup
- (void)_setupUI {
    self.navigationItem.title = m_string(@"CoAssets");
    [self _setupLeftBarButton];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    _indexSelectFilter = 0;
    [_tableView registerNib:[UINib nibWithNibName:[HomeListViewCell identifier] bundle:nil]
     forCellReuseIdentifier:[HomeListViewCell identifier]];
}

- (void)_setupLeftBarButton {
    _leftButton = [[UIBarButtonItem alloc]initWithTitle:m_string(@"Filter")
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(__actionFilter)];
    [_leftButton setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Raleway-Regular" size:17]}
                              forState:UIControlStateNormal];
    
    [self.navigationItem setLeftBarButtonItem:_leftButton];
}

#pragma mark - Private

- (void)_pushDetailVcWithID:(NSArray *)arr {
    DetailsViewController *vc = [[DetailsViewController alloc]init];
    vc.arrayObj = arr;
    vc.progressBarObj = self.profressbarObj;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Setter Getter
- (NSArray*)arrayData {
    if (!_arrayData) {
       return _arrayData = [[NSArray alloc] init];
    }
    return _arrayData;
}

- (NSArray*)arrayListFilter {
    if (!_arrayListFilter) {
        return _arrayListFilter = [LoadFileManager loadFilePlistWithName:@"FilterList"];
    }
    return _arrayListFilter;
}

- (NSArray*)arraySort {
    if (!_arraySort) {
        return _arraySort = [[NSArray alloc] init];
    }
    return _arraySort;
}

#pragma mark - Action
- (void)__actionFilter {
    [CODropListVC presentWithTitle:m_string(@"Filter")
                              data:self.arrayListFilter
                     selectedIndex:_indexSelectFilter
                          parentVC:self
                         didSelect:^(NSInteger index) {
        _indexSelectFilter = index;
//        NSArray *arraySort = self.arrayData;
//        NSString *key = self.arrayListFilter[_indexSelectFilter];
//        if (![key isEqualToString:@"All"]) {
//            NSPredicate *pre = [NSPredicate predicateWithFormat:@"offerType CONTAINS[cd] %@",key];
//            self.arraySort = [arraySort filteredArrayUsingPredicate:pre];
//        }else {
//            self.arraySort = self.arrayData;
//        }
        self.arrayData = nil;
         if (_indexSelectFilter == 1) {
             [self _callWSGetListOfferFilter:kFILTER_BP];
         } else if (_indexSelectFilter == 2) {
             [self _callWSGetListOfferFilter:kFILTER_CO];
         } else if (_indexSelectFilter == 3) {
             [self _callWSGetListOfferFilter:kFILTER_PS];
         } else {
             [self _callAPIGetAllOffers];
         }
        [_tableView reloadData];
    }];
}

#pragma mark - CalAPI
- (void)_callAPIGetAllOffers {
    _leftButton.enabled = NO;
    [UIHelper showLoadingInView:self.view];
    [[WSURLSessionManager shared]wsGetListOfferWithHandler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSArray class]]) {
            self.arrayData = (NSArray*)responseObject;
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [_tableView beginUpdates];
                for (NSInteger i = 0 ; i < [self.arrayData count] ; i++) {
                    [_tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
                [_tableView endUpdates];
            }];
        } else {
            [UIHelper showError:error];
        }
        [UIHelper hideLoadingFromView:self.view];
        _leftButton.enabled = YES;
    }];
}

- (void)_callWSGetListOfferFilter:(NSString*)typeFilter {
    _leftButton.enabled = NO;
    [UIHelper showLoadingInView:self.view];
    [[WSURLSessionManager shared] wsGetListOffersFilter:typeFilter handle:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSArray class]]) {
            self.arrayData = (NSArray*)responseObject;
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [_tableView beginUpdates];
                for (NSInteger i = 0 ; i < [self.arrayData count] ; i++) {
                    [_tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
                [_tableView endUpdates];
            }];
        } else {
            [UIHelper showError:error];
        }
        [UIHelper hideLoadingFromView:self.view];
        _leftButton.enabled = YES;
    }];
}

- (void)_callWSGetDetailsWithID:(NSString*)offerID {
    [UIHelper showLoadingInView:self.view];
    [[WSURLSessionManager shared] wsGetDetailsWithOffersID:offerID handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            [self _pushDetailVcWithID:responseObject];
        } else {
            [UIHelper showError:error];
        }
        [UIHelper hideLoadingFromView:self.view];
        _leftButton.enabled = YES;
    }];
}

- (void)_callWSGetProgressbar:(NSString*)offerID {
    _leftButton.enabled = NO;
    [UIHelper showLoadingInView:self.view];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:offerID,@"offer_id", nil];
    [[WSURLSessionManager shared] wsGetProgressBarWithOfferID:dic handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            self.profressbarObj = (COProgressbarObj*)responseObject;
            [self _callWSGetDetailsWithID:offerID];
        } else {
            [UIHelper showError:error];
        }
    }];
}

#pragma mark - TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayData.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self _setupHomeListCell:tableView cellForRowAtIndexPath:indexPath];;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (![kUserDefaults boolForKey:KDEFAULT_LOGIN]) {
        LoginViewController *vcLogin = [[LoginViewController alloc]init];
        vcLogin.delegate = self;
        BaseNavigationController *base = [[BaseNavigationController alloc] initWithRootViewController:vcLogin];
        [[kAppDelegate baseTabBarController] presentViewController:base animated:YES completion:nil];
        _indexPathForCell = indexPath;
    }else {
        [self _callWSGetProgressbar:[[self.arrayData[indexPath.row] valueForKey:@"offerID"] stringValue]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 248;
}

- (HomeListViewCell*)_setupHomeListCell:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeListViewCell identifier]];
    
    cell.object = self.arrayData[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

#pragma mark - Other Delegate
- (void)loginViewController:(LoginViewController *)loginViewController loginWithStyle:(LoginWithStyle)loginWithStyle {
    switch (loginWithStyle) {
        case DismissLoginVC:
        {
            [[kAppDelegate baseTabBarController] dismissViewControllerAnimated:YES completion:nil];
        } break;
            
        case PushLoginVC:
        {
            [[kAppDelegate baseTabBarController] dismissViewControllerAnimated:YES
                                                                    completion:^{
                [self _callWSGetProgressbar:[[self.arrayData[_indexPathForCell.row] valueForKey:@"offerID"] stringValue]];
            }];
            _indexPathForCell = nil;
        } break;
            
        default: break;
    }
}
@end