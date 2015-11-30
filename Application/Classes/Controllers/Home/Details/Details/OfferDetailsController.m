//
//  OfferDetailsController.m
//  CoAssets
//
//  Created by TruongVO07 on 11/30/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "OfferDetailsController.h"

@interface OfferDetailsController ()
{
    __weak IBOutlet UIWebView *_webView;
}
@end

@implementation OfferDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.offerDescription = self.offerDescription;
    self.offerAddress = self.offerAddress;
    self.offerProject = self.offerProject;
}

#pragma mark - Set Get
- (void)setOfferDescription:(id<COOfferDescription>)offerDescription {
    _offerDescription       = offerDescription;
    self.title       = self.offerDescription.offerDescriptionTitle;
    NSString *string = [NSString stringWithFormat:@"%@",offerDescription.offerDescriptionContent];
    NSString *formartHTML = [NSString stringWithFormat:DEFINE_HTML_FRAME,string];
    [_webView loadHTMLString:formartHTML baseURL:nil];
}

- (void)setOfferAddress:(id<COOfferAddress>)offerAddress {
    _offerAddress           = offerAddress;
    self.title       = self.offerAddress.offerAddressTitle;
     NSString *formartHTML = [NSString stringWithFormat:DEFINE_HTML_FRAME,offerAddress.offerAddressContent];
    [_webView loadHTMLString:formartHTML baseURL:nil];
}

- (void)setOfferProject:(id<COOfferProject>)offerProject {
    _offerProject = offerProject;
    self.title = offerProject.offerProjectTitle;
    NSString *formartHTML = [NSString stringWithFormat:DEFINE_HTML_FRAME,offerProject.offerProjectContent];
    [_webView loadHTMLString:formartHTML baseURL:nil];
}

@end
