//
//  NSArray+Sort.h
//  CoAssets
//
//  Created by TUONG DANG on 6/25/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "UIImageView+Networking.h"
#import "EGOCache.h"

#define TRVSKVOBlock(KEYPATH, BLOCK) \
[self willChangeValueForKey:KEYPATH]; \
BLOCK(); \
[self didChangeValueForKey:KEYPATH];
/*
 Operation Download
 */
@interface TNURLSessionOperation : NSOperation

- (instancetype)initWithSession:(NSURLSession *)session URL:(NSURL *)url completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;
- (instancetype)initWithSession:(NSURLSession *)session request:(NSURLRequest *)request completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;

@property (nonatomic, strong, readonly) NSURLSessionDataTask *task;

@end

@implementation TNURLSessionOperation {
    BOOL _finished;
    BOOL _executing;
}

- (instancetype)initWithSession:(NSURLSession *)session URL:(NSURL *)url completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler {
    if (self = [super init]) {
        __weak typeof(self) weakSelf = self;
        _task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            [weakSelf completeOperationWithBlock:completionHandler data:data response:response error:error];
        }];
    }
    return self;
}

- (instancetype)initWithSession:(NSURLSession *)session request:(NSURLRequest *)request completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler {
    if (self = [super init]) {
        __weak typeof(self) weakSelf = self;
        _task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            [weakSelf completeOperationWithBlock:completionHandler data:data response:response error:error];
        }];
    }
    return self;
}

- (void)cancel {
    [super cancel];
    [self.task cancel];
}

- (void)start {
    if (self.isCancelled) {
        TRVSKVOBlock(@"isFinished", ^{ _finished = YES; });
        return;
    }
    TRVSKVOBlock(@"isExecuting", ^{
        [self.task resume];
        _executing = YES;
    });
}

- (BOOL)isExecuting {
    return _executing;
}

- (BOOL)isFinished {
    return _finished;
}

- (BOOL)isConcurrent {
    return YES;
}

- (void)completeOperationWithBlock:(void (^)(NSData *, NSURLResponse *, NSError *))block data:(NSData *)data response:(NSURLResponse *)response error:(NSError *)error {
    if (!self.isCancelled && block)
        block(data, response, error);
    [self completeOperation];
}

- (void)completeOperation {
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    
    _executing = NO;
    _finished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

@end

/*
 Image Download
 */

typedef void (^CompletionBlock) (BOOL succes, UIImage *image, NSURL *url, NSError *error);

@interface ImageDownloader : NSObject
@property (nonatomic, strong) NSOperationQueue *netOperationQueue;
@property (nonatomic, strong) NSURLSession     *connectionSession;
@property (nonatomic, strong) NSURL            *URL;
@property (nonatomic, strong) EGOCache         *eogCache;
@property (nonatomic, copy  ) CompletionBlock  downloadedBlock;

- (ImageDownloader *)startDownloadForURL:(NSURL *)URL
                                   cache:(EGOCache *)cache
                                 session:(NSURLSession *)session
                         completionBlock:(CompletionBlock)completionBlock;

@end


@implementation ImageDownloader

- (ImageDownloader *)startDownloadForURL:(NSURL *)URL
                                   cache:(EGOCache *)cache
                                 session:(NSURLSession *)session
                         completionBlock:(CompletionBlock)completionBlock
{
    if (URL) {
        self.netOperationQueue = [[NSOperationQueue alloc]init];
        self.netOperationQueue.maxConcurrentOperationCount = 3;
        self.URL = URL;
        self.eogCache = cache;
        self.connectionSession = session;
        self.downloadedBlock = completionBlock;
        [self loadImage];
    }
    return self;
}

- (void)cacheImage:(UIImage *)image {
    if (image && self.URL) {
        [self.eogCache setImage:image forKey:[self.URL absoluteString]];
    }
}

- (void)start {
    NSURLSessionDownloadTask *downloadImage = [self.connectionSession downloadTaskWithRequest:[NSURLRequest requestWithURL:self.URL]
                                                                            completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
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
}

- (void)loadImage {
    [self.netOperationQueue addOperation:[[TNURLSessionOperation alloc] initWithSession:self.connectionSession URL:self.URL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:[NSData dataWithData:data]];
            [self cacheImage:image];
            if (self.downloadedBlock) {
                self.downloadedBlock(YES, image, response.URL, nil);
            }
        } else {
            if (self.downloadedBlock) {
                self.downloadedBlock(NO, nil, response.URL, error);
            }
        }
    }]];
}

@end


@implementation UIImageView (Networking)

const char *keyForURLID = "imageURLID";
const char *keyForCompletionBlock = "completionBlockID";

@dynamic URLId;

- (NSString *)URLId {
    return objc_getAssociatedObject(self, keyForURLID);
}

- (void)setURLId:(NSString *)urlId {
    objc_setAssociatedObject(self, keyForURLID, urlId, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (EGOCache *)defaultCache {
    EGOCache *sharedCache = nil;
    sharedCache = [EGOCache globalCache];
    [sharedCache setDefaultTimeoutInterval:60*60*24*1];
    return sharedCache;
}

+ (NSURLSession *)defaultSession {
    static NSURLSession *sharedSession = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        sharedSession = [NSURLSession sessionWithConfiguration:sessionConfig];
    });
    return sharedSession;
}

- (void)setImageURL:(NSURL *)imageURL {
    [self setImageURL:imageURL withCompletionBlock:nil];
}

- (NSURL *)imageURL {
    return [NSURL URLWithString:self.URLId];
}

- (void)setImageURL:(NSURL *)imageURL withCompletionBlock:(DownloadCompletionBlock)block {
    self.URLId = [imageURL absoluteString];
    UIImage *img = [[UIImageView defaultCache] imageForKey:[imageURL absoluteString]];
    if (!img) {
        ImageDownloader *dowloader = [[ImageDownloader alloc] init];
        [dowloader startDownloadForURL:imageURL  cache:[UIImageView defaultCache] session:[UIImageView defaultSession] completionBlock:^(BOOL succes, UIImage *image, NSURL *imgURL, NSError *error) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if (succes) {
                    if ([[imgURL absoluteString] isEqualToString:self.URLId]) {
                        self.image = image;
                        [self setNeedsLayout];
                        if (block) {
                            block(YES, image, nil);
                        }
                    }
                } else {
                    if (block) {
                        block(NO, nil, error);
                    }
                }
            }];
        }];
        
    }
    else {
        self.image = img;
        [self setNeedsLayout];
    }
}


@end
