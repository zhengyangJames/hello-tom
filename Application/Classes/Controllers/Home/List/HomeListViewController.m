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
#import "OfferViewController.h"
#import "LoginViewController.h"
#import "MBProgressHUD.h"
#import "WSURLSessionManager.h"
#import "WSURLSessionManager+ListHome.h"
#import "COOfferModel.h"
#import "COProjectModel.h"
#import "COProjectFundedAmountModel.h"
#import "COFilterListModel.h"
#import "COLoginManager.h"
#import "WSProjectFundInfoRequest.h"
#import "WSGetOfferInfoWithRequest.h"
#import "WSGetListOfferRequest.h"
#import "COListFilterObject.h"
#import "COLoginManager.h"

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
    NSIndexPath *_indexPathForCell;
}
@property (copy, nonatomic) ActionGetIndexPath actionGetIndexPath;
@property (strong, nonatomic) NSArray *arrayData;
@property (strong, nonatomic) NSArray *arrayListFilter;
@property (nonatomic, strong) COOfferModel *offerModel;
@end	
@implementation HomeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
    [self _checkIsReloadListHome];
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

- (void)_checkIsReloadListHome {
    if (![COLoginManager shared].isReloadListHome) {
        [self _callWSGetListOfferFilter:@""];
        [COLoginManager shared].isReloadListHome = YES;
    }
}

- (void)_pushDetailVcWithID:(COOfferModel *)model {
    OfferViewController *vc = [[OfferViewController alloc]init];
    vc.offerModel = model;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)_showViewNoData:(NSString *)filterType{
    _noDataView.hidden = NO;
    if ([filterType isEqualToString:kFILTER_BP]) {
        _noDataLabel.text = NSLocalizedString(@"FILTER_BULLK_NULL",nil);
    } else if ([filterType isEqualToString:kFILTER_CO]) {
        _noDataLabel.text = NSLocalizedString(@"FILTER_CROWD_NULL",nil);
    } else if ([filterType isEqualToString:kFILTER_PS]) {
        _noDataLabel.text = NSLocalizedString(@"FILTER_SALE_NULL",nil);
    } else {
        _noDataLabel.text = NSLocalizedString(@"FILTER_ALL_NULL",nil);
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
                          parentVC:self
                         didSelect:^(NSInteger index) {
         if (self.arrayListFilter && self.arrayListFilter.count > 0) {
             COListFilterObject *filterObject = self.arrayListFilter[index];
             [self _callWSGetListOfferFilter:filterObject.value];
        }
         
    }];
}

#pragma mark - CalAPI

- (void)_callWSGetListOfferFilter:(NSString*)typeFilter {
    if (self.arrayData && self.arrayData.count > 0) {
        self.arrayData = nil;
        [_tableView reloadData];
        
    } else {
        _noDataView.hidden = YES;
    }
    _leftButton.enabled = NO;
    [UIHelper showLoadingInView:self.view];
    [[WSURLSessionManager shared] wsGetListOffersWithRequest:[self _createGetListOfferRequestWithType:typeFilter] handle:^(id responseObject, NSURLResponse *response, NSError *error) {
        [UIHelper hideLoadingFromView:self.view];
        if (!error && [responseObject isKindOfClass:[NSArray class]]) {
            self.arrayData = (NSArray*)responseObject;
            if (self.arrayData.count>0) {
                _noDataView.hidden = YES;
                [_tableView beginUpdates];
                for (NSInteger i = 0 ; i < [self.arrayData count] ; i++) {
                    [_tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
                [_tableView endUpdates];
            } else {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [self _showViewNoData:typeFilter];
                }];
            }
        } else {
            [UIHelper showError:error];
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            _leftButton.enabled = YES;
        }];
    }];
}

- (WSGetListOfferRequest *)_createGetListOfferRequestWithType:(NSString *)offerType {
    WSGetListOfferRequest *request = [[WSGetListOfferRequest alloc] init];
    [request setHTTPMethod:METHOD_GET];
    [request setURL:[NSURL URLWithString:WS_METHOD_GET_LIST_OFFERS]];
    request.offerType = offerType;
    return request;
}

- (void)_callWSGetDetailsWithModel:(NSString*)offerID {
    [UIHelper showLoadingInView:self.view];
    [[WSURLSessionManager shared] wsGetOfferInforWithRequest:[self _createOfferInfoRequestWithOfferID:offerID] handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.offerModel = responseObject;
                [self _callWSGetFundInfo];
            }];
        } else {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [UIHelper hideLoadingFromView:self.view];
                _leftButton.enabled = YES;
            }];
            [UIHelper showError:error];
        }

        
    }];
}

- (WSGetOfferInfoWithRequest *)_createOfferInfoRequestWithOfferID:(NSString*)offerID {
    WSGetOfferInfoWithRequest *request = [[WSGetOfferInfoWithRequest alloc] init];
    [request setHTTPMethod:METHOD_GET];
    [request setURL:[NSURL URLWithString:WS_METHOD_GET_LIST_OFFERS]];
    request.offerID = offerID;
    return request;
}

- (void)_callWSGetFundInfo{
    _leftButton.enabled = NO;
    [UIHelper showLoadingInView:self.view];
    [[WSURLSessionManager shared] wsGetProjectFundInfoWithRequest:[self _createFundInfoRequest] handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.offerModel.offerProject.projectFundedAmount = responseObject;
                [self _pushDetailVcWithID:self.offerModel];
            }];
        } else {
            [UIHelper showError:error];
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [UIHelper hideLoadingFromView:self.view];
            _leftButton.enabled = YES;
        }];
    }];
}

- (WSProjectFundInfoRequest *)_createFundInfoRequest {
    WSProjectFundInfoRequest *request = [[WSProjectFundInfoRequest alloc] init];
    [request setURL:[NSURL URLWithString:WS_METHOD_POST_PROGRESSBAR]];
    [request setHTTPMethod:METHOD_POST];
    NSString *offerID = [self.offerModel.numberOfOfferId stringValue];
    [request setBodyParam:offerID forKey:kFundOfferID];
    [request setValueWithModel:[[COLoginManager shared] userModel]];
    return request;
}
#pragma mark - TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.arrayData && self.arrayData.count > 0) {
        return self.arrayData.count;
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self _setupHomeListCell:tableView cellForRowAtIndexPath:indexPath];;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (![[COLoginManager shared] userModel]) {
        LoginViewController *vcLogin = [[LoginViewController alloc]init];
        vcLogin.delegate = self;
        BaseNavigationController *base = [[BaseNavigationController alloc] initWithRootViewController:vcLogin];
        [[kAppDelegate baseTabBarController] presentViewController:base animated:YES completion:nil];
        _indexPathForCell = indexPath;
    }else {
        [self _callWSGetDetailsWithModel:[[self.arrayData[indexPath.row] numberOfOfferId]stringValue]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return HEIGHT_FOR_ROW_HOME;
}

- (HomeListViewCell*)_setupHomeListCell:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeListViewCell identifier]];
    cell.homeOffer = self.arrayData[indexPath.row];
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
                                                                        [self _callWSGetFundInfo];
            }];
            _indexPathForCell = nil;
        } break;
            
        default: break;
    }
}
@end
