//
//  NSDictionary+NotNULL.h
//  NikmeApp
//
//  Created by Linh NGUYEN on 9/6/14.
//  Copyright (c) 2014 Nikmesoft Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NotNULL)

- (id)valueForKeyNotNull:(NSString *)key;
- (id)objectForKeyNotNull:(NSString *)key;


@end
