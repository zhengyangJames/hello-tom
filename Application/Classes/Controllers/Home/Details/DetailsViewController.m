//
//  DetailsViewController.m
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "DetailsViewController.h"
#import "CODetailsDataSource.h"
#import "CODetailsDelegate.h"
#import "COSlidingView.h"
#import "WSURLSessionManager+ListHome.h"
#import "UIImageView+Networking.h"
#import "COInterestedViewController.h"
#import "COQuestionView.h"
#import "CODetailsProfileObj.h"
#import "COOfferItemObj.h"
#import "COOferObj.h"
#import "COListProfileObject.h"
#import "WebViewSetting.h"
#import "WebViewManager.h"

@interface DetailsViewController ()<UIGestureRecognizerDelegate>
{
    UIWebView   *_webView;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) CODetailsDataSource *detailsDataSource;
@property (strong, nonatomic) CODetailsDelegate *detailsDelegate;
@property (nonatomic, weak) IBOutlet COSlidingView *headerSliderView;


@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
    if (![kUserDefaults boolForKey:KDEFAULT_LOGIN]) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}

#pragma mark - Setup

- (void)_setupUI {
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self _setupHeaderView];
    self.detailsDataSource = [[CODetailsDataSource alloc]initWithController:self tableView:self.tableView];
    self.tableView.dataSource = self.detailsDataSource;
    [self _getHeightWebview];
    self.detailsDelegate      = [[CODetailsDelegate alloc]initWithController:self];
    self.tableView.delegate   = self.detailsDelegate;
    [self _reloadData];
}

- (void)_reloadData {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.detailsDataSource.progressBarObj = self.progressBarObj;
        self.detailsDataSource.arrObject = self.arrayObj;
        [self.tableView reloadData];
    }];
}

- (void)_getHeightWebview {
    COOferObj *offerObj = self.arrayObj[3];
    COOfferItemObj *offerItemObj = [offerObj.offerItemObjs lastObject];
    [[WebViewManager shared] getHeightWebViewWithStringHtml:offerItemObj.linkOrDetail heightForWebView:^(CGFloat height) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.detailsDataSource.heightWebview = height;
            [self.tableView reloadData];
        }];
    }];
}

#pragma mark Set Get 


- (void)setArrayObj:(NSArray *)arrayObj {
    _arrayObj = arrayObj;
    [self _reloadData];
}

- (void)setProgressBarObj:(COProgressbarObj *)progressBarObj {
    _progressBarObj = progressBarObj;
    [self _reloadData];
}

#pragma mark - Action 
- (IBAction)__actionBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Private 
- (void)_setupHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 200)];
    [headerView setBackgroundColor:[UIColor clearColor]];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, headerView.frame.size.height)];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    COOferObj *offerObj = [self.arrayObj lastObject];
    COOfferItemObj *offerItemObj = [offerObj.offerItemObjs lastObject];
    
    
    NSURL *url = [NSURL URLWithString:offerItemObj.photo];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [imageView setImage:[UIImage imageNamed:@"ic_placeholder"]];
    [imageView setImageURL:url];
    [headerView addSubview:imageView];
    [imageView pinToSuperviewEdges:JRTViewPinAllEdges inset:0];
    self.tableView.tableHeaderView = headerView;
}

#pragma mark - Delegate
- (void)detailsProfileAction:(CODetailsProjectBottomTVCell *)detailsProfileCell didSelectAction:(CODetailsProjectAction)detailsProjectAction {
    switch (detailsProjectAction) {
        case CODetailsProjectActionInterested:
        {
            COInterestedViewController *vc = [[COInterestedViewController alloc]init];
            COOferObj *offerObj = [self.arrayObj firstObject];
            COOfferItemObj *offerItemObj = [offerObj.offerItemObjs lastObject];
            COOferObj *offerObj2 = self.arrayObj[1];
            CODetailsProfileObj *profileObj2 = [offerObj2.offerItemObjs lastObject];
            COListProfileObject *listProfile = [[COListProfileObject alloc]initWithDictionary:[kUserDefaults objectForKey:kPROFILE_OBJECT]];
            vc.object = @{@"offerID":offerItemObj.offerID,@"offerTitle":offerItemObj.title,@"amount":profileObj2.min_investment,@"email":listProfile.email};
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case CODetailsProjectActionQuestions:
        {
            COQuestionView *vc = [[COQuestionView alloc]init];
            COOferObj *offerObj = [self.arrayObj firstObject];
            COOfferItemObj *offerItemObj = [offerObj.offerItemObjs lastObject];
            vc.object = @{@"offerID":offerItemObj.offerID};
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)detailsViewController:(CODetailsDelegate *)detailViewController didSelectedAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section > 4 && indexPath.section < 11 && indexPath.row != 0) {
        COOferObj *obj = [self _getItemAtindexPath:indexPath];
        COOfferItemObj *coOOfferItemObj = [obj.offerItemObjs objectAtIndex:indexPath.row - 1];
        if (coOOfferItemObj.linkOrDetail && ![coOOfferItemObj.linkOrDetail isEmpty]) {
            WebViewSetting *vc = [[WebViewSetting alloc]init];
            vc.titler = m_string(coOOfferItemObj.title);
            vc.webLink = coOOfferItemObj.linkOrDetail;
            vc.isPresion = NO;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (COOferObj *)_getItemAtindexPath:(NSIndexPath *)indexpath {
    COOferObj *obj = [self.arrayObj objectAtIndex:indexpath.section];
    return obj;
}

@end

