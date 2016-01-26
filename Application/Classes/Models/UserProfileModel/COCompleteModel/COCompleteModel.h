//
//  COCompleteModel.h
//  CoAssets
//
//  Created by Macintosh HD on 1/26/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COCompleteModel : MTLModel<MTLJSONSerializing>
@property (strong, nonatomic) NSString *keyComplete;
@property (strong, nonatomic) NSNumber *valueComplete;
@end
