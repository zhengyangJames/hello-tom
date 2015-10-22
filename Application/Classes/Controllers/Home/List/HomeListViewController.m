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
    NSString *_selectedOfferID;
    NSString *_offerIdOfNotification;
}
@property (copy, nonatomic) ActionGetIndexPath actionGetIndexPath;
@property (strong, nonatomic) NSArray *arrayData;
@property (strong, nonatomic) NSArray *arrayListFilter;
@property (nonatomic, strong) COOfferModel *offerModel;

@end	
@implementation HomeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_reloadListHome)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    [self _setupUI];
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

- (void)_reloadListHome {
    [self _callWSGetListOfferFilter:@""];
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

#pragma mark - Call API

- (void)_callWSGetListOfferFilter:(NSString*)typeFilter {
    if (!self.arrayData && !self.arrayData.count > 0) {
        _noDataView.hidden = YES;
    }
    _leftButton.enabled = NO;
    [UIHelper showLoadingInView:self.view];
    [[WSURLSessionManager shared] wsGetListOffersWithRequest:[self _createGetListOfferRequestWithType:typeFilter] handle:^(id responseObject, NSURLResponse *response, NSError *error) {
        [UIHelper hideLoadingFromView:self.view];
        if (!error && [responseObject isKindOfClass:[NSArray class]]) {
            self.arrayData = nil;
            self.arrayData = (NSArray *)responseObject;
            if (self.arrayData.count > 0) {
                _noDataView.hidden = YES;
                NSIndexPath *_indexPath = nil;
                
                //update item offer after reload
                for (NSInteger i = 0 ; i < [self.arrayData count] ; i++) {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                    if ([_selectedOfferID isEqual:[[self.arrayData[i] numberOfOfferId] stringValue]]) {
                        _indexPath = indexPath;
                    }
                }
                [_tableView reloadData];
                
                //scroll come item offer after reload
                if (_indexPath) {
                    [_tableView scrollToRowAtIndexPath:_indexPath atScrollPosition:UITableViewScrollPositionNone animated:NO];
                    _selectedOfferID = nil;
                }
                
                //Check and show offer of notification
                if (_offerIdOfNotification) {
                    [self checkIsShowLoginVCAndPushDetailOffer:_offerIdOfNotification];
                }
                
            } else {
                [self _showViewNoData:typeFilter];
            }
        } else {
            [UIHelper showError:error];
        }
        _leftButton.enabled = YES;
    }];
}

//Push Detail With Offer ID
- (void)pushDetailOfferWithID {
    if (_offerIdOfNotification) {
        [self _checkOfferAndPushDetailOfferWithID:_offerIdOfNotification];
    }
}

- (WSGetListOfferRequest *)_createGetListOfferRequestWithType:(NSString *)offerType {
    WSGetListOfferRequest *request = [[WSGetListOfferRequest alloc] init];
    [request setHTTPMethod:METHOD_GET];
    [request setURL:[NSURL URLWithString:WS_METHOD_GET_LIST_OFFERS]];
    request.offerType = offerType;
    return request;
}

- (void)callWSGetDetailsWithModel:(NSString*)offerID {
    [UIHelper showLoadingInView:self.view];
    [[WSURLSessionManager shared] wsGetOfferInforWithRequest:[self _createOfferInfoRequestWithOfferID:offerID] handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            self.offerModel = responseObject;
            [self _callWSGetFundInfo];
        } else {
            [UIHelper hideLoadingFromView:self.view];
            _leftButton.enabled = YES;
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
    [[WSURLSessionManager shared] wsGetProjectFundInfoWithRequest:[self _createFundInfoRequest] handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            self.offerModel.offerProject.projectFundedAmount = responseObject;
            [self _pushDetailVcWithID:self.offerModel];
        } else {
            [UIHelper showError:error];
        }
        [UIHelper hideLoadingFromView:self.view];
        _leftButton.enabled = YES;
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
    _selectedOfferID = [[self.arrayData[indexPath.row] numberOfOfferId]stringValue];
    [self checkIsShowLoginVCAndPushDetailOffer:_selectedOfferID];
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
        case DismissLoginVC: {
            [[kAppDelegate baseTabBarController] dismissViewControllerAnimated:YES completion:nil];
        } break;
            
        case PushLoginVC: {
            [[kAppDelegate baseTabBarController] dismissViewControllerAnimated:YES completion:^{
                if (_selectedOfferID) {
                    [self _checkOfferAndPushDetailOfferWithID:_selectedOfferID];
                }
                if (_offerIdOfNotification) {
                    [self _checkOfferAndPushDetailOfferWithID:_offerIdOfNotification];
                }
            }];
        } break;
            
        default: break;
    }
}

#pragma mark - Check Login

- (void)checkIsShowLoginVCAndPushDetailOffer:(NSString *)offerId {
    if (![[COLoginManager shared] userModel]) {
        [self showLoginView];
    } else {
        [self _checkOfferAndPushDetailOfferWithID:offerId];
    }
}

- (void)_checkOfferAndPushDetailOfferWithID:(NSString*)offerID {
    if ([self _checkOfferIdInList:offerID]) {
        [self callWSGetDetailsWithModel:offerID];
        _offerIdOfNotification = nil;
    } else {
        DBG(@"***__Offer ID Not Invaild__***");
    }
}

- (BOOL)_checkOfferIdInList:(NSString*)offerId {
    for (NSInteger i = 0; i < self.arrayData.count; i++) {
        NSString *offderIdInList = [[self.arrayData[i] numberOfOfferId]stringValue];
        if ([offerId isEqualToString:offderIdInList]) {
            return YES;
        }
    }
    return NO;
}

- (void)showLoginView {
    LoginViewController *vcLogin = [[LoginViewController alloc]init];
    vcLogin.delegate = self;
    BaseNavigationController *base = [[BaseNavigationController alloc] initWithRootViewController:vcLogin];
    [[kAppDelegate baseTabBarController] presentViewController:base animated:YES completion:nil];
    [[COLoginManager shared] setIsReloadListHome:YES];
}

#pragma mark - Set offerId Notification

- (void)setNotificationOfferId:(NSString *)offerId isCheckNotificationBanner:(BOOL)isCheck {
    _offerIdOfNotification = offerId;
    if (isCheck) {
        [self _reloadListHome];
    }
}

- (void)dealloc {
    [kNotificationCenter removeObserver:self forKeyPath:UIApplicationDidBecomeActiveNotification];
}

@end
