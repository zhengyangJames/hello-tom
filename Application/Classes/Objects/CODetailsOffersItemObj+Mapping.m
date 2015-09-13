//
//  CODetailsOffersItemObj+Mapping.m
//  CoAssets
//
//  Created by TUONG DANG on 8/13/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsOffersItemObj+Mapping.h"



@implementation CODetailsOffersItemObj (Mapping)

- (CODetailsOffersObj*)mappingDetailsOffersItemTitle:(NSDictionary*)dicObj {
    self.title = [dicObj objectForKeyNotNull:@"offer_title"];
    self.offerID = [dicObj objectForKeyNotNull:@"id"];
    self.linkOrDetail = [dicObj objectForKeyNotNull:@"company_logo"];
    CODetailsOffersObj *obj = [[CODetailsOffersObj alloc]init];
    [obj setDetailsOffersItemObj:self type:@"Title"];
    return obj;
}

- (CODetailsOffersObj*)mappingDetailsOffersItemDescription:(NSDictionary*)dicObj {
    self.title = NSLocalizedString(@"OFFER", nil);;
    self.htmlDetail = [UIHelper _getStringFromHtml:[dicObj objectForKeyNotNull:@"short_description"]];
    CODetailsOffersObj *obj = [[CODetailsOffersObj alloc]init];
    [obj setDetailsOffersItemObj:self type:@"Description"];
    return obj;
}

- (CODetailsOffersObj*)mappingDetailsOffersItemProjectDesc:(NSDictionary*)dicObj {
    self.title = NSLocalizedString(@"PROJECT", nil);
    self.htmlDetail = [UIHelper _getStringFromHtml:[dicObj objectForKeyNotNull:@"project_description"]];
    self.linkOrDetail = [dicObj objectForKeyNotNull:@"project_description"];
    CODetailsOffersObj *obj = [[CODetailsOffersObj alloc]init];
    [obj setDetailsOffersItemObj:self type:@"ProjectDesc"];
    return obj;
}

- (CODetailsOffersObj*)mappingDetailsOffersItemDocument {
    self.title = NSLocalizedString(@"DOCUMENTS", nil);
    self.stringDetail = NSLocalizedString(@"DETAIL_DOCUMENT", nil);
    CODetailsOffersObj *obj = [[CODetailsOffersObj alloc]init];
    [obj setDetailsOffersItemObj:self type:@"Document"];
    return obj;
}

- (CODetailsOffersItemObj*)mappingDetailsOffersItemSubDocument:(NSDictionary*)dicObj andKey:(NSString*)key {
    CODetailsOffersItemObj *obj = [[CODetailsOffersItemObj alloc]init];
    if (dicObj && key) {
        if ([[dicObj objectForKeyNotNull:@"url"] isEqualToString:@"N/A"]) {
            obj.linkOrDetail = nil;
            obj.title = NSLocalizedString(@"NoDocumentsUploaded", nil);
        } else {
            obj.linkOrDetail = [dicObj objectForKeyNotNull:@"url"];
            obj.title = [dicObj objectForKeyNotNull:@"title"];
        }
    } else {
        obj.linkOrDetail = nil;
        obj.title = NSLocalizedString(@"NoDocumentsUploaded", nil);
    }
    return obj;
}

- (CODetailsOffersObj*)mappingDetailsOffersItemAddress:(NSDictionary*)dicObj {
    NSString *address = @"";
    NSMutableDictionary *dictObject = [dicObj objectForKeyNotNull:@"project"];
    NSString *address1 = [dictObject objectForKeyNotNull:@"address_1"];
    if (address1 && ![address1 isEmpty]) {
        address = [address stringByAppendingString:address1];
    }
    NSString *address2 = [dictObject objectForKeyNotNull:@"address_2"];
    if (address2 && ![address2 isEmpty]) {
        address = [[address stringByAppendingString:@"\n"] stringByAppendingString:address2];
    }
    NSString *city = [dictObject objectForKeyNotNull:@"city"];
    if (city && ![city isEmpty]) {
        address = [[address stringByAppendingString:@"\n"] stringByAppendingString:city];
    }
    NSString *country = [dictObject objectForKeyNotNull:@"country"];
    if (country && ![country isEmpty]) {
        address = [[address stringByAppendingString:@"\n"] stringByAppendingString:country];
    }
    self.title = NSLocalizedString(@"ADDRESS", nil);
    self.stringDetail = address;
    self.photo = [dictObject objectForKeyNotNull:@"photo"];
    CODetailsOffersObj *obj = [[CODetailsOffersObj alloc]init];
    [obj setDetailsOffersItemObj:self type:@"Address"];
    return obj;
}

@end
