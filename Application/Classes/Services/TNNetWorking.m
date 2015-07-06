//
//  TNNetWorking.m
//  CoAssets
//
//  Created by TUONG DANG on 7/5/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "TNNetWorking.h"

@implementation TNNetWorking

+ (id)shared {
    static TNNetWorking *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        _netOperationQueue = [[NSOperationQueue alloc] init];
        _netOperationQueue.maxConcurrentOperationCount = 3;
        _netOperationQueue.name = @"Net Operations";
        
        NSURLSessionConfiguration *sessionImageConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionImageConfiguration.timeoutIntervalForResource = 6;
        sessionImageConfiguration.HTTPMaximumConnectionsPerHost = 1;
        sessionImageConfiguration.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;
        
        _connectionSession = [NSURLSession sessionWithConfiguration:sessionImageConfiguration delegate:nil delegateQueue:_netOperationQueue];
    }
    return self;
}

- (void)cacheImage:(UIImage *)image {
    if (image && self.URL) {
        [self.cache setObject:image forKey:self.URL];
    }
}

- (NSURLSessionTask*)startDownloadForURL:(NSURL *)URL cache:(NSCache *)cache completionBlock:(CompletionBlock)completionBlock {
    NSURLSessionTask *downloadImage = [self.connectionSession downloadTaskWithRequest:[NSURLRequest requestWithURL:self.URL] completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
            [self cacheImage:image];
            if (self.downloadedBlock) {
                self.downloadedBlock(YES, image, response.URL, nil);
            }
        } else {
            if (self.downloadedBlock) {
                self.downloadedBlock(NO, nil, response.URL, error);
            }
        }
    }];
    [downloadImage resume];
    return downloadImage;
}


@end
