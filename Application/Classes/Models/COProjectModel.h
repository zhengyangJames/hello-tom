//
//  COProjectModel.h
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/14/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface COProjectModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *projectCity;
@property (nonatomic, strong) NSString *projectCountry;
@property (nonatomic, strong) NSNumber *projectId;
@property (nonatomic, strong) NSString *projectAddress1;
@property (nonatomic, strong) NSString *projectStateRegion;
@property (nonatomic, strong) NSNumber *projectDeveloper;
@property (nonatomic, strong) NSString *projectPhoto;
@property (nonatomic, strong) NSString *projectAddress2;
@property (nonatomic, strong) NSString *projectType;
@property (nonatomic, strong) NSString *projectName;

@end
