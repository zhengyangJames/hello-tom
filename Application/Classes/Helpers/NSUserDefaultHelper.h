//
//  NSUserDefaultHelper.h
//  CoAssets
//
//  Created by TUONG DANG on 7/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "COListProfileObject.h"

@interface NSUserDefaultHelper : NSObject
+ (void)saveUserDefaultWithProfileObject:(COListProfileObject *)object key:(NSString *)key;
+ (COListProfileObject *)loadUserDefaultWithProfileObjectAndKey:(NSString *)key;
@end
