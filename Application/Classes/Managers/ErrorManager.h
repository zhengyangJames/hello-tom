//
//  ErrorManager.h
//  CoAssets
//
//  Created by TruongVO07 on 11/24/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^requitedLoginCompleted)(BOOL);

@interface ErrorManager : NSObject

+ (ErrorManager *)shared;
+ (void)showError:(NSError *)error;

- (void)requitedLogin:(requitedLoginCompleted)completed;

@end
