//
//  NMSecurityHelper.h
//  ToeicTestPro
//
//  Created by Linh NGUYEN on 10/6/14.
//  Copyright (c) 2014 Nikmesoft Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NMSecurityHelper : NSObject

+ (NSString*)hashMAC256:(NSString*)data key:(NSString*)key;

@end
