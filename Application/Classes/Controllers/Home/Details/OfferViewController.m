//
//  DetailsViewController.m
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "OfferViewController.h"
#import "CODetailsDataSource.h"
#import "CODetailsDelegate.h"
#import "COSlidingView.h"
#import "WSURLSessionManager+ListHome.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "COInterestedViewController.h"
#import "COQuestionView.h"
#import "WebViewSetting.h"
#import "WebViewManager.h"
#import "COOfferModel.h"
#import "COProjectModel.h"
#import "COLoginManager.h"
#import "COOfferActionCell.h"
#import "CODocumentItemCell.h"
#import "OfferDetailsController.h"
#import "OfferDetailsDocumentController.h"

@interface OfferViewController ()<UIGestureRecognizerDelegate,DetailsDataSourceViewDelegate,CODetailsAccessoryCellDelegate,CODetailsTableViewDelegate,CODetailsProjectBottomTVCellDelegate>
{
    UIWebView   *_webView;
    id<COInterestedAction> offerInterested;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) CODetailsDataSource *detailsDataSource;
@property (strong, nonatomic) CODetailsDelegate *detailsDelegate;
@property (nonatomic, weak) IBOutlet COSlidingView *headerSliderView;
@end

@implementation OfferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    // enable slide-back
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
    if (![[COLoginManager shared] userModel]) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}

#pragma mark - Setup

- (void)_setupUI {
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self _setupHeaderView];
    self.detailsDataSource = [[CODetailsDataSource alloc]initWithController:self tableView:self.tableView];
    self.tableView.dataSource = self.detailsDataSource;
    self.detailsDelegate      = [[CODetailsDelegate alloc]initWithController:self];
    self.tableView.delegate   = self.detailsDelegate;
    self.detailsDataSource.delegate = self;
    self.detailsDataSource.heightWebview = 0;
    [self _reloadData];
    //[self _getHeightWebview];
}

- (void)_reloadData {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.detailsDataSource.offerModel = self.offerModel;
        self.detailsDelegate.offerModel = self.offerModel;
        self.detailsDataSource.heightWebview = 300;
        [self.tableView reloadData];
    }];
}

- (void)_getHeightWebview {
    [UIHelper showLoadingInView:[kAppDelegate window]];
    [[WebViewManager shared] getHeightWebViewWithStringHtml:self.offerModel.offerProjectDescription heightForWebView:^(CGFloat height, UIWebView *web) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.detailsDataSource.heightWebview = height;
            [self.tableView reloadData];
            [UIHelper hideLoadingFromView:[kAppDelegate window]];
        }];
    }];
}

#pragma mark Set Get 

- (void)setOfferModel:(COOfferModel *)offerModel {
    _offerModel = offerModel;
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
    
    NSURL *url = [NSURL URLWithString:self.offerModel.offerProject.projectPhoto];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"ic_placeholder"]];
    [headerView addSubview:imageView];
    [imageView pinToSuperviewEdges:JRTViewPinAllEdges inset:0];
    self.tableView.tableHeaderView = headerView;
}

#pragma mark - Delegate
- (void)detailsProfileAction:(COOfferActionCell *)detailsProfileCell didSelectAction:(CODetailsProjectAction)detailsProjectAction {
    switch (detailsProjectAction) {
        case CODetailsProjectActionInterested:
        {
            COInterestedViewController *vc = [[COInterestedViewController alloc]init];
            vc.coInterested = self.offerModel;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case CODetailsProjectActionQuestions:
        {
            COQuestionView *quesView = [[COQuestionView alloc]init];
            quesView.offerID = self.offerModel.numberIdOfOffer;
            [self.navigationController pushViewController:quesView animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)coDetailsWebViewCell:(COOfferWebViewCell *)CODetailsWebViewCell heightWebview:(CGFloat)heightWebview {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [UIView animateWithDuration:1.5f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             [_tableView reloadSections:[NSIndexSet indexSetWithIndex:1]
                                       withRowAnimation:UITableViewRowAnimationNone];
                         } completion:nil ];
    }];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}

- (void)showWebSiteAtDetailVCWithTitle:(NSString *)title andURl:(NSString *)url{
    WebViewSetting *vc = [[WebViewSetting alloc]init];
    vc.titler = title;
    vc.webLink = url;
    vc.isPresion = NO;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)detailsViewController:(CODetailsDelegate *)detailViewController didSelectedAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section > 1) {
        if (indexPath.section == 4) {
            OfferDetailsDocumentController *vc = [[OfferDetailsDocumentController alloc] initWithNibName:@"OfferDetailsDocumentController" bundle:nil];
            vc.offerModel = self.offerModel;
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            OfferDetailsController *vc = [[OfferDetailsController alloc] initWithNibName:@"OfferDetailsController" bundle:nil];
            if(indexPath.section == 2) {
                vc.offerDescription = self.offerModel;
            } else if (indexPath.section == 3) {
                vc.offerProject = self.offerModel;
            } else if (indexPath.section == 5) {
                vc.offerAddress = self.offerModel.offerProject;
            }
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

@end

