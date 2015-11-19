//
//  COFundStatusModel.h
//  CoAssets
//
//  Created by Macintosh HD on 11/18/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COFundStatusModel : MTLModel<MTLJSONSerializing>
@property (nonatomic, assign) BOOL dealFundStatusIsPaid;
@property (nonatomic, assign) BOOL dealFundStatusIsSigned;
@end
