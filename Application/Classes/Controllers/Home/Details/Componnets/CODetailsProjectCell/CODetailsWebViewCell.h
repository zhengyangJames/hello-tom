//
//  CODetailsWebViewCell.h
//  CoAssets
//
//  Created by TUONG DANG on 7/13/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "COOfferItemObj.h"

@protocol  CODetailsWebViewCellDelegate;

@interface CODetailsWebViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *titler;
@property (weak, nonatomic) IBOutlet UITextView *textViewLoad;
@property (nonatomic, strong) COOfferItemObj *cOOfferItemObj;

@property (weak, nonatomic) id<CODetailsWebViewCellDelegate> delegate;

@end

@protocol  CODetailsWebViewCellDelegate <NSObject>

@optional
- (void)coDetailsWebViewCell:(CODetailsWebViewCell*)CODetailsWebViewCell heightWebview:(CGFloat)heightWebview;

@end