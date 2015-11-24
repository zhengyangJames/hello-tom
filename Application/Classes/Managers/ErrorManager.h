//
//  ErrorManager.h
//  CoAssets
//
//  Created by TruongVO07 on 11/24/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ErrorManager : NSObject

@property (nonatomic, assign) BOOL isExpiredAuth;

+ (ErrorManager *)shared;
+ (void)showError:(NSError *)error;

@end
