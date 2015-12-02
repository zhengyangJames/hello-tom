//
//  COFilterListModel.h
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/20/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Mantle/Mantle.h>

@protocol COFilterList <NSObject>

- (NSString *)filterTitle;
- (NSString *)filterValue;

@end
@interface COFilterListModel : MTLModel<MTLJSONSerializing,COFilterList>

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *value;
@end

