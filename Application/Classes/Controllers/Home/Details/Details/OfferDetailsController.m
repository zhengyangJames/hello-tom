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
    __weak IBOutlet UITextView  *_detailsTextView;
}
@end

@implementation OfferDetailsController

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [super viewWillAppear:animated];
    if (self.offerDescription) {
        self.offerDescription = self.offerDescription;
    }
    if (self.offerAddress) {
        self.offerAddress = self.offerAddress;
    }
    if (self.offerProject) {
        self.offerProject = self.offerProject;
    }
}

#pragma mark - Set Get
- (void)setOfferDescription:(id<COOfferDescription>)offerDescription {
    _offerDescription = offerDescription;
    self.title = offerDescription.offerDescriptionTitle;
    NSString *string = [NSString stringWithFormat:@"%@",offerDescription.offerDescriptionContent];
    _detailsTextView.text = string;
    _webView.hidden = YES;
    _detailsTextView.hidden = NO;
}

- (void)setOfferAddress:(id<COOfferAddress>)offerAddress {
    _offerAddress = offerAddress;
    self.title = offerAddress.offerAddressTitle;
    NSString *string = [NSString stringWithFormat:@"%@", offerAddress.offerAddressContent];
    _detailsTextView.text = string;
    _webView.hidden = YES;
    _detailsTextView.hidden = NO;
}

- (void)setOfferProject:(id<COOfferProject>)offerProject {
    _offerProject = offerProject;
    self.title = offerProject.offerProjectTitle;
    NSString *formartHTML = [NSString stringWithFormat:DEFINE_HTML_FRAME,offerProject.offerProjectContent];
    [_webView loadHTMLString:formartHTML baseURL:nil];
    _webView.hidden = NO;
    _detailsTextView.hidden = YES;
}

@end
