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
#import "HomeListViewController.h"
#import "LoadFileManager.h"
#import "WebViewSetting.h"


@interface NotificationViewController ()<UITableViewDataSource, UITableViewDelegate> {
    __weak IBOutlet UITableView *_tableview;
    NSString *_selectedOfferID;
    NSInteger count1 ;
}

@property (strong, nonatomic) NSArray *arrayData;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self _checkCreadDeviceToken];
}
#pragma mark - SetupUI

- (void)_setupUI {
    self.title = m_string(@"NOTIFICATIONS");
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
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self _loadDetailNotification:indexPath];
}

- (void)_loadDetailNotification:(NSIndexPath *)indexPath {
    CONotificationModel *notification = [self.arrayData objectAtIndex:indexPath.row];
    if (notification != nil) {
        if ([notification.notifiData.notifiStatus isEqualToString:UNREAD]) {
            NSString *badge = [NSString stringWithFormat:@"%tu",count1 - 1];
            if (![badge isEqualToString:@"0"]) {
                [[self.tabBarController.tabBar.items objectAtIndex:2] setBadgeValue:badge];
            } else {
                [[self.tabBarController.tabBar.items objectAtIndex:2] setBadgeValue: nil];
            }
            [self _callReadNotification:notification];
            notification.notifiData.notifiStatus = READ;
            [_tableview reloadData];
        }
        
        if (notification.notifiData.notifiUrl != nil) {
            WebViewSetting *webViewSetting = [[WebViewSetting alloc]init];
            webViewSetting.webLink = notification.notifiData.notifiUrl;
            webViewSetting.titler = m_string(@"NOTIFICATION");
            [self.navigationController pushViewController:webViewSetting animated:YES];
        } else if([notification.notifiData.notifiType isEqualToString:@"offer"]) {
            _selectedOfferID = [notification.notifiData.notifiId stringValue];
            [kUserDefaults setObject:_selectedOfferID forKey:NOTIFICATION_ID];
            [kUserDefaults synchronize];
            
            if (![[kAppDelegate baseHomeNAV].topViewController isKindOfClass:[HomeListViewController class]]) {
                [[kAppDelegate baseHomeNAV] popToRootViewControllerAnimated:NO];
            }
            
            [kAppDelegate baseTabBarController].selectedIndex = 0;
        }
    }
}

- (void)_checkCreadDeviceToken {
    COUserProfileModel *userModel = [[COLoginManager shared] userModel];
    NSString *headerString = [NSString stringWithFormat:@"%@",userModel.stringOfTokenType];
    NSString *deviceToken = [kUserDefaults objectForKey:KEY_DEVICE_TOKEN];
    if (deviceToken != nil && headerString != NULL) {
        [self _callGetNotificationList];
    }
}

#pragma mark - Web Service
#pragma mark - POST Notification

- (void)_callGetNotificationList {
    [UIHelper showLoadingInView:[kAppDelegate window]];
    [kAppDelegate checkGetNotificationCountHandler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject && [responseObject isKindOfClass:[NSArray class]]) {
            self.arrayData = nil;
            self.arrayData = (NSArray*)responseObject;
            NSString *str = [UIHelper setBadgeValueNotification:responseObject];
            count1 = [str integerValue];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [_tableview reloadData];
            }];
        } else {
            [ErrorManager showError:error];
        }
        [UIHelper hideLoadingFromView:[kAppDelegate window]];
    }];
}

- (void)_callReadNotification:(CONotificationModel *)notification {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    NSString *device_token = [kUserDefaults objectForKey:KEY_DEVICE_TOKEN];
    [dic setObject:device_token forKey:device_token_dic];
    [dic setObject:device_type forKey:device_type_dic];
    [dic setObject:application_name forKey:application_name_dic];
    [dic setObject:client_key forKey:client_key_dic];
    [dic setObject:notification.notifiData.notifiStatus forKey:NOTIFICATION_STATUS_DICT];
    [dic setObject:notification.notifiData.notifiUnique forKey:NOTIFICATION_ID_DICT];
    [[WSURLSessionManager shared] wsReadNotificationList:dic handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (error) {
            [ErrorManager showError:error];
        }
    }];
}

@end
