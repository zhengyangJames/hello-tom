//
//  CODocumentModel.h
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/17/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CODocumentModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSArray *documentLicenses;
@property (nonatomic, strong) NSArray *documentOther;
@property (nonatomic, strong) NSArray *documentDeclarationFormList;
@property (nonatomic, strong) NSArray *documentRegistrationFormList;
@property (nonatomic, strong) NSArray *documentLegalAppointment;
@property (nonatomic, strong) NSArray *documentOwnership;

@end
