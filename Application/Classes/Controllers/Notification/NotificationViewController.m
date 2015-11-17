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


@interface NotificationViewController ()<UITableViewDataSource, UITableViewDelegate, LoginViewControllerDelegate> {
    __weak IBOutlet UITableView *_tableview;
    NSString *_selectedOfferID;
    
}
@property (strong, nonatomic) NSArray *arrayData;
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
    [kUserDefaults setObject:_selectedOfferID forKey:NOTIFICATION_ID];
    [kUserDefaults synchronize];
    [kAppDelegate baseTabBarController].selectedIndex = 0;
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

@end
