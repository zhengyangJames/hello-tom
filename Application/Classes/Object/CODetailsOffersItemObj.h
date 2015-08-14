//
//  CODetailsOffersItemObj.h
//  CoAssets
//
//  Created by TUONG DANG on 8/13/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CODetailsOffersItemObj : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *offerID;
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) NSString *linkOrDetail;
@property (nonatomic, strong) NSAttributedString *htmlDetail;
@property (nonatomic, strong) NSString *stringDetail;

@end
