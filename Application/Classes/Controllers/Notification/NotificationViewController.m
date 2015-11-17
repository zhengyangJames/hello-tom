//
//  NotificationViewController.m
//  CoAssets
//
//  Created by Nikmesoft_M007 on 11/16/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "NotificationViewController.h"
#import "NotificationCell.h"
#import "WSPostDeviceTokenRequest.h"
#import "WSURLSessionManager+Notification.h"
#import "COLoginManager.h"
#import "LoadFileManager.h"
#import "LoginViewController.h"
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
#import <Parse/Parse.h>
#import "OfferViewController.h"


@interface NotificationViewController ()<UITableViewDataSource, UITableViewDelegate, LoginViewControllerDelegate> {
    __weak IBOutlet UITableView *_tableview;
    NSString *_selectedOfferID;
    
}
@property (strong, nonatomic) NSArray *arrayData;
@property (strong, nonatomic) COOfferModel *offerModel;
@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _checkCreadDeviceToken];
    [self _setupUI];
}

#pragma mark - SetupUI
- (void)_setupUI {
    self.title = m_string(@"NOTIFICATION");
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.tableFooterView = [UIView new];
    [_tableview registerNib:[UINib nibWithNibName:[NotificationCell identifier] bundle:nil] forCellReuseIdentifier:[NotificationCell identifier]];
}

#pragma mark - setData

- (NSArray*)arrayData {
    if (!_arrayData) {
        return _arrayData = [[NSArray alloc] init];
    }
    return _arrayData;
}

//- (void)_reloadListNotification {
//    [self _checkCreadDeviceToken];
//}

#pragma mark - UITableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.arrayData != nil) {
        return self.arrayData.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:[NotificationCell identifier] forIndexPath:indexPath];
    cell.notifiModel = [self.arrayData objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CONotificationModel *notifiModel = [[CONotificationModel alloc]init];
    notifiModel = [self.arrayData objectAtIndex:indexPath.row];
    _selectedOfferID = [notifiModel.notifiData.notifiId stringValue];
    [self checkIsShowLoginVCAndPushDetailOffer:_selectedOfferID];
}

- (void)_checkCreadDeviceToken {
    
    if ([kUserDefaults objectForKey:DEVICE_TOKEN_EXIST] != nil) {
        self.deviceTokenExist = [kUserDefaults boolForKey:DEVICE_TOKEN_EXIST];
    } else {
        self.deviceTokenExist = NO;
        [kUserDefaults setBool:self.deviceTokenExist forKey:DEVICE_TOKEN_EXIST];
    }
    
    [self _callGetNotificationList];
    COUserProfileModel *userModel = [[COLoginManager shared] userModel];
    NSString *headerString = [NSString stringWithFormat:@"%@",userModel.stringOfTokenType];

    NSString *deviceToken = [kUserDefaults objectForKey:KEY_DEVICE_TOKEN];
    if (self.deviceTokenExist == YES && deviceToken != nil && headerString != NULL) {
//        [self _callPostDeviceToken];
//        [self _callGetNotificationList];
        //        [self _callReadNotification];
    }
}

#pragma mark - Web Service
#pragma mark - POST Notification

- (void)_callPostDeviceToken {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    NSString *device_token = [kUserDefaults objectForKey:KEY_DEVICE_TOKEN];
    [dic setObject:device_token forKey:device_token_dic];
    [dic setObject:device_type forKey:device_type_dic];
    [dic setObject:application_name forKey:application_name_dic];
    [dic setObject:client_key forKey:client_key_dic];
    
    [[WSURLSessionManager shared]wsPostDeviceTokenRequest:dic handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        
    }];
}

- (void)_callGetNotificationList {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    NSString *device_token = [kUserDefaults objectForKey:KEY_DEVICE_TOKEN];
    [dic setObject:@"18a2950defe16fad7b3b218569a954506e208c8b292a3718f48996c499ebe325" forKey:device_token_dic];
    [dic setObject:device_type forKey:device_type_dic];
    [dic setObject:application_name forKey:application_name_dic];
    
    [[WSURLSessionManager shared] wsGetNotificationListRequest:dic handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        
        if (!error && [responseObject isKindOfClass:[NSArray class]]) {
            self.arrayData = nil;
            self.arrayData = (NSArray*)responseObject;
            DBG(@"%lu",(unsigned long)self.arrayData.count);
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [_tableview reloadData];
            }];
        } else {
            [UIHelper hideLoadingFromView:self.view];
            [UIHelper showError:error];
        }
        [UIHelper hideLoadingFromView:self.view];

    }];
}

- (void)_callReadNotification {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    NSString *device_token = [kUserDefaults objectForKey:KEY_DEVICE_TOKEN];
    [dic setObject:device_token forKey:device_token_dic];
    [dic setObject:device_type forKey:device_type_dic];
    [dic setObject:application_name forKey:application_name_dic];
    [dic setObject:@"a" forKey:NOTIFICATION_STATUS_DICT];
    [dic setObject:@"id" forKey:NOTIFICATION_ID_DICT];
    
    [[WSURLSessionManager shared] wsReadNotificationList:dic handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        
    }];
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
//        _offerIdOfNotification = nil;
    } else {
        DBG(@"***__Offer ID Not Invaild__***");
    }
}

- (BOOL)_checkOfferIdInList:(NSString*)offerId {
    for (NSInteger i = 0; i < self.arrayData.count; i++) {
        NSString *offderIdInList = [[self.arrayData[i] notifiId]stringValue];
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

- (void)callWSGetDetailsWithModel:(NSString*)offerID {
    [UIHelper showLoadingInView:self.view];
    [[WSURLSessionManager shared] wsGetOfferInforWithRequest:[self _createOfferInfoRequestWithOfferID:offerID] handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            self.offerModel = responseObject;
            [self _callWSGetFundInfo];
        } else {
            [UIHelper hideLoadingFromView:self.view];

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
    [[WSURLSessionManager shared] wsGetProjectFundInfoWithRequest:[self _createFundInfoRequest] handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            self.offerModel.offerProject.projectFundedAmount = responseObject;
            [self _pushDetailVcWithID:self.offerModel];
        } else {
            [UIHelper showError:error];
        }
        [UIHelper hideLoadingFromView:self.view];
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
- (void)_pushDetailVcWithID:(COOfferModel *)model {
    OfferViewController *vc = [[OfferViewController alloc]init];
    vc.offerModel = model;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
