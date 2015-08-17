//
//  CODocumentModel.m
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/17/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODocumentModel.h"
#import "CODocumentItemModel.h"

@implementation CODocumentModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"documentLicenses" : @"licenses",
        @"documentOther" : @"others",
        @"documentDeclarationFormList" : @"declaration_form_list",
        @"documentRegistrationFormList" : @"registration_form_list",
        @"documentLegalAppointment" : @"legal_appointment",
        @"documentOwnership" : @"ownership",
    };
}

@end
