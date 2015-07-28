//
//  WebViewManager.h
//  CoAssets
//
//  Created by Macintosh HD on 7/14/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebViewManager : NSObject
@property (nonatomic, copy) void (^heightForWebView)(CGFloat height, UIWebView *);


+ (id)shared;

- (void)getHeightWebViewWithStringHtml:(NSString *)stringHtml
                      heightForWebView:(void (^)(CGFloat height, UIWebView *))heightForWebView;

@end
