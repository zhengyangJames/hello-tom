//
//  TNNetWorking.h
//  CoAssets
//
//  Created by TUONG DANG on 7/5/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

//CompletionBlock ImageDownloader which get actual Image on succes and error on failure in completionBlock
typedef void (^CompletionBlock) (BOOL succes, UIImage *image, NSURL *url, NSError *error);

@interface TNNetWorking : NSObject

@property (nonatomic, strong) NSURLSession *connectionSession;
@property (nonatomic, strong) NSURL *URL;
@property (nonatomic, strong) NSCache *cache;
@property (nonatomic, copy) CompletionBlock downloadedBlock;
@property(nonatomic, strong) NSOperationQueue *netOperationQueue;
+ (id)shared;
- (NSURLSessionTask*)startDownloadForURL:(NSURL *)URL cache:(NSCache *)cache completionBlock:(CompletionBlock)completionBlock;

@end
