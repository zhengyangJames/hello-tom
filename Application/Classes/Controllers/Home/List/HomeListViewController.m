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
#import "COOfferModel.h"
#import "COProjectModel.h"
#import "COProjectFundedAmountModel.h"
#import "COFilterListModel.h"

typedef NS_ENUM(NSInteger, FilterType) {
    FilterBullkType,
    FilterCrowdType,
    FilterSaleType,
    FilterAllType
};

typedef void(^ActionGetIndexPath)(NSIndexPath *indexPath);

@interface HomeListViewController () <UITableViewDataSource,UITableViewDelegate,LoginViewControllerDelegate>
{
    __weak IBOutlet UITableView *_tableView;
    __weak IBOutlet UIView *_noDataView;
    __weak IBOutlet UILabel *_noDataLabel;
    UIBarButtonItem *_leftButton;
    NSInteger _indexSelectFilter;
    NSIndexPath *_indexPathForCell;
}
@property (copy, nonatomic) ActionGetIndexPath actionGetIndexPath;
@property (strong, nonatomic) NSArray *arrayData;
@property (strong, nonatomic) NSArray *arrayListFilter;
@property (strong, nonatomic) NSArray *arraySort;
@property (nonatomic, strong) COOfferModel *offerModel;
@property (nonatomic, strong) id<COFilterList> filterItem;
@end	
@implementation HomeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
    [self _callWSGetListOfferFilter:@""];
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
    self.navigationItem.title = NSLocalizedString(@"COASSETS_TITLE", nil);
    [self _setupLeftBarButton];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:[HomeListViewCell identifier] bundle:nil]
     forCellReuseIdentifier:[HomeListViewCell identifier]];
    _noDataView.hidden = YES;
    _indexSelectFilter = 0;
}

- (void)_setupLeftBarButton {
    _leftButton = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"FILTER_TITLE", nil)
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(__actionFilter)];
    [_leftButton setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Raleway-Regular" size:17]}
                              forState:UIControlStateNormal];
    
    [self.navigationItem setLeftBarButtonItem:_leftButton];
}

#pragma mark - Private

- (void)_pushDetailVcWithID:(COOfferModel *)model {
    DetailsViewController *vc = [[DetailsViewController alloc]init];
    vc.offerModel = model;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)_showViewNoData:(NSInteger)filterType{
    _noDataView.hidden = NO;
    switch (filterType) {
        case FilterBullkType:
            _noDataLabel.text = NSLocalizedString(@"FILTER_BULLK_NULL",nil);
            break;
        case FilterCrowdType:
            _noDataLabel.text = NSLocalizedString(@"FILTER_CROWD_NULL",nil);
            break;
        case FilterSaleType:
            _noDataLabel.text = NSLocalizedString(@"FILTER_SALE_NULL",nil);
            break;
        case FilterAllType:
            _noDataLabel.text = NSLocalizedString(@"FILTER_ALL_NULL",nil);
            break;
        default:  break;
    }
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
        return _arrayListFilter = [LoadFileManager loadFileFilterListWithName:@"FilterList"];
    }
    return _arrayListFilter;
}

#pragma mark - Action
- (void)__actionFilter {
    [CODropListVC presentWithTitle:NSLocalizedString(@"FILTER_TITLE", nil)
                              data:self.arrayListFilter
                     selectedIndex:_indexSelectFilter
                          parentVC:self
                         didSelect:^(NSInteger index) {
         _indexSelectFilter = index;
         self.filterItem = self.arrayListFilter[index];
         self.arrayData = nil;
        [self _callWSGetListOfferFilter:self.filterItem.filterValue];

        [_tableView reloadData];
    }];
}

#pragma mark - CalAPI

- (void)_callWSGetListOfferFilter:(NSString*)typeFilter {
    _leftButton.enabled = NO;
    [UIHelper showLoadingInView:self.view];
    [[WSURLSessionManager shared] wsGetListOffersFilter:typeFilter handle:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSArray class]]) {
            self.arrayData = (NSArray*)responseObject;
            [UIHelper hideLoadingFromView:self.view];
            if (self.arrayData.count>0) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    _noDataView.hidden = YES;
                    [_tableView beginUpdates];
                    for (NSInteger i = 0 ; i < [self.arrayData count] ; i++) {
                        [_tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                    }
                    [_tableView endUpdates];
                }];
            } else {
                if ([typeFilter isEqualToString:kFILTER_BP]) {
                    [self _showViewNoData:FilterBullkType];
                } else if ([typeFilter isEqualToString:kFILTER_CO]) {
                    [self _showViewNoData:FilterCrowdType];
                } else if ([typeFilter isEqualToString:kFILTER_PS]) {
                    [self _showViewNoData:FilterSaleType];
                } else {
                    [self _showViewNoData:FilterAllType];
                }
            }
        } else {
            [UIHelper showError:error];
        }
        _leftButton.enabled = YES;
    }];
}

- (void)_callWSGetDetailsWithID:(NSString*)offerID {
    [UIHelper showLoadingInView:self.view];
    [[WSURLSessionManager shared] wsGetDetailsWithOffersID:offerID handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.offerModel = responseObject;
                [self _callWSGetProgressbar:offerID];
            }];
        } else {
            [UIHelper hideLoadingFromView:self.view];
            [UIHelper showError:error];
        }
        
        [UIHelper hideLoadingFromView:self.view];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            _leftButton.enabled = YES;
        }];
        
    }];
}

- (void)_callWSGetProgressbar:(NSString*)offerID {
    _leftButton.enabled = NO;
    [UIHelper showLoadingInView:self.view];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:offerID,@"offer_id", nil];
    [[WSURLSessionManager shared] wsGetProgressBarWithOfferID:dic handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            [UIHelper hideLoadingFromView:self.view];
            self.offerModel.offerProject.projectFundedAmount = responseObject;
            [self _pushDetailVcWithID:self.offerModel];
        } else {
            [UIHelper hideLoadingFromView:self.view];
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
        [self _callWSGetDetailsWithID:[[self.arrayData[indexPath.row] valueForKey:@"offerId"]stringValue]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 248;
}

- (HomeListViewCell*)_setupHomeListCell:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeListViewCell identifier]];
    cell.offerobject = self.arrayData[indexPath.row];
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
