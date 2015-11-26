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
    [self _checkCreadDeviceToken];
    [self _setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self _checkCreadDeviceToken];
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
    CONotificationModel *notifiModel = [[CONotificationModel alloc]init];
    notifiModel = [self.arrayData objectAtIndex:indexPath.row];
    if (notifiModel != nil) {
        [self _loadDetailNotification:notifiModel];
        [self _checkCreadDeviceToken];
    }
}

- (void)_loadDetailNotification:(CONotificationModel *)notification {
    
    if ([notification.notifiData.notifiStatus isEqualToString:UNREAD]) {
        [[self.tabBarController.tabBar.items objectAtIndex:2] setBadgeValue: [NSString stringWithFormat:@"%tu",count1 - 1]];
         [self _callReadNotification:notification];
    }
   
    if (notification.notifiData.notifiUrl != nil) {
        WebViewSetting *webViewSetting = [[WebViewSetting alloc]init];
        webViewSetting.webLink = notification.notifiData.notifiUrl;
        webViewSetting.titler = m_string(@"Notification");
        [self.navigationController pushViewController:webViewSetting animated:YES];
    } else if([notification.notifiData.notifiType isEqualToString:@"offer"]) {
        _selectedOfferID = [notification.notifiData.notifiId stringValue];
        [kUserDefaults setObject:_selectedOfferID forKey:NOTIFICATION_ID];
        [kUserDefaults synchronize];
        [kAppDelegate baseTabBarController].selectedIndex = 0;
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
    [UIHelper showLoadingInView:self.view];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    NSString *device_token = [kUserDefaults objectForKey:KEY_DEVICE_TOKEN];
    [dic setObject:device_token forKey:device_token_dic];
    [dic setObject:device_type forKey:device_type_dic];
    [dic setObject:application_name forKey:application_name_dic];
    [[WSURLSessionManager shared] wsGetNotificationListRequest:dic handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        
        if (!error && [responseObject isKindOfClass:[NSArray class]]) {
            self.arrayData = nil;
            self.arrayData = (NSArray*)responseObject;
            NSString *str = [UIHelper setBadgeValueNotification:responseObject];
            if ([str isEqualToString:@"0"]) {
                 [[self.tabBarController.tabBar.items objectAtIndex:2] setBadgeValue: nil];
            } else {
                [[self.tabBarController.tabBar.items objectAtIndex:2] setBadgeValue: str];
            }
            count1 = [str integerValue];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [_tableview reloadData];
            }];
        } else {
            [ErrorManager showError:error];
        }
        [UIHelper hideLoadingFromView:self.view];
        
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
