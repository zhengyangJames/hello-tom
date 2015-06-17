//
//  CODummyDataManager.m
//  CoAssest
//
//  Created by TUONG DANG on 6/15/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODummyDataManager.h"
#import "ListHomeObject.h"
#import "ContactObject.h"
#import "ProfileObject.h"

@implementation CODummyDataManager

+ (instancetype)shared {
    static CODummyDataManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (NSArray*)arrayListHomeObj {
    NSMutableArray *array = [[NSMutableArray alloc]init];
    ListHomeObject *obj = [[ListHomeObject alloc]init];
    obj.imageNameBig = @"1.jpg";
    obj.imageNameLogo = @"Earth_256.png";
    obj.lableDetail = @"Invest in Canyon de Boracay Premier to own a piece";
    obj.lableSate = @"Abkhazia";
    [array addObject:obj];
    
    ListHomeObject *obj1 = [[ListHomeObject alloc]init];
    obj1.imageNameBig = @"2.jpg";
    obj1.imageNameLogo = @"Earth_256.png";
    obj1.lableDetail = @"Invest in Canyon de Boracay Premier to own a piece";
    obj1.lableSate = @"Afghanistan";
    [array addObject:obj1];
    
    ListHomeObject *obj2 = [[ListHomeObject alloc]init];
    obj2.imageNameBig = @"3.jpg";
    obj2.imageNameLogo = @"Earth_256.png";
    obj2.lableDetail = @"Invest in Canyon de Boracay Premier to own a piece";
    obj2.lableSate = @"Albania";
    [array addObject:obj2];
    
    ListHomeObject *obj3 = [[ListHomeObject alloc]init];
    obj3.imageNameBig = @"4.jpg";
    obj3.imageNameLogo = @"Earth_256.png";
    obj3.lableDetail = @"Invest in Canyon de Boracay Premier to own a piece";
    obj3.lableSate = @"Algeria";
    [array addObject:obj3];
    
    ListHomeObject *obj4 = [[ListHomeObject alloc]init];
    obj4.imageNameBig = @"5.jpg";
    obj4.imageNameLogo = @"Earth_256.png";
    obj4.lableDetail = @"Invest in Canyon de Boracay Premier to own a piece";
    obj4.lableSate = @"American Samoa";
    [array addObject:obj4];
    
    ListHomeObject *obj5 = [[ListHomeObject alloc]init];
    obj5.imageNameBig = @"6.jpg";
    obj5.imageNameLogo = @"Earth_256.png";
    obj5.lableDetail = @"Invest in Canyon de Boracay Premier to own a piece";
    obj5.lableSate = @"Andorra";
    [array addObject:obj5];
    
    ListHomeObject *obj6 = [[ListHomeObject alloc]init];
    obj6.imageNameBig = @"7.jpg";
    obj6.imageNameLogo = @"Earth_256.png";
    obj6.lableDetail = @"Invest in Canyon de Boracay Premier to own a piece";
    obj6.lableSate = @"Angola";
    [array addObject:obj6];
    
    ListHomeObject *obj7 = [[ListHomeObject alloc]init];
    obj7.imageNameBig = @"8.jpg";
    obj7.imageNameLogo = @"Earth_256.png";
    obj7.lableDetail = @"Invest in Canyon de Boracay Premier to own a piece";
    obj7.lableSate = @"Anguilla";
    [array addObject:obj7];
    
    ListHomeObject *obj8 = [[ListHomeObject alloc]init];
    obj8.imageNameBig = @"9.jpg";
    obj8.imageNameLogo = @"Earth_256.png";
    obj8.lableDetail = @"Invest in Canyon de Boracay Premier to own a piece";
    obj8.lableSate = @"Argentina";
    [array addObject:obj8];
    
    ListHomeObject *obj10 = [[ListHomeObject alloc]init];
    obj10.imageNameBig = @"11.jpg";
    obj10.imageNameLogo = @"Earth_256.png";
    obj10.lableDetail = @"Invest in Canyon de Boracay Premier to own a piece";
    obj10.lableSate = @"Armenia";
    [array addObject:obj10];
    
    ListHomeObject *obj11 = [[ListHomeObject alloc]init];
    obj11.imageNameBig = @"12.jpg";
    obj11.imageNameLogo = @"Earth_256.png";
    obj11.lableDetail = @"Invest in Canyon de Boracay Premier to own a piece";
    obj11.lableSate = @"Aruba";
    [array addObject:obj11];
    
    ListHomeObject *obj12 = [[ListHomeObject alloc]init];
    obj12.imageNameBig = @"13.jpg";
    obj12.imageNameLogo = @"Earth_256.png";
    obj12.lableDetail = @"Invest in Canyon de Boracay Premier to own a piece";
    obj12.lableSate = @"Ascension";
    [array addObject:obj12];
    
    ListHomeObject *obj13 = [[ListHomeObject alloc]init];
    obj13.imageNameBig = @"14.jpg";
    obj13.imageNameLogo = @"Earth_256.png";
    obj13.lableDetail = @"Invest in Canyon de Boracay Premier to own a piece";
    obj13.lableSate = @"Australia";
    [array addObject:obj13];
    
    ListHomeObject *obj14 = [[ListHomeObject alloc]init];
    obj14.imageNameBig = @"15.jpg";
    obj14.imageNameLogo = @"Earth_256.png";
    obj14.lableDetail = @"Invest in Canyon de Boracay Premier to own a piece";
    obj14.lableSate = @"Bolivia";
    [array addObject:obj14];
    
    ListHomeObject *obj15 = [[ListHomeObject alloc]init];
    obj15.imageNameBig = @"16.jpg";
    obj15.imageNameLogo = @"Earth_256.png";
    obj15.lableDetail = @"Invest in Canyon de Boracay Premier to own a piece";
    obj15.lableSate = @"Austria";
    [array addObject:obj15];
    
    ListHomeObject *obj16 = [[ListHomeObject alloc]init];
    obj16.imageNameBig = @"17.jpg";
    obj16.imageNameLogo = @"Earth_256.png";
    obj16.lableDetail = @"Invest in Canyon de Boracay Premier to own a piece";
    obj16.lableSate = @"Azerbaijan";
    [array addObject:obj16];
    
    ListHomeObject *obj17 = [[ListHomeObject alloc]init];
    obj17.imageNameBig = @"18.jpg";
    obj17.imageNameLogo = @"Earth_256.png";
    obj17.lableDetail = @"Invest in Canyon de Boracay Premier to own a piece";
    obj17.lableSate = @"Bahamas";
    [array addObject:obj17];
    
    ListHomeObject *obj18 = [[ListHomeObject alloc]init];
    obj18.imageNameBig = @"19.jpg";
    obj18.imageNameLogo = @"Earth_256.png";
    obj18.lableDetail = @"Invest in Canyon de Boracay Premier to own a piece";
    obj18.lableSate = @"Barbados";
    [array addObject:obj18];
    
    ListHomeObject *obj19 = [[ListHomeObject alloc]init];
    obj19.imageNameBig = @"20.jpg";
    obj19.imageNameLogo = @"Earth_256.png";
    obj19.lableDetail = @"Invest in Canyon de Boracay Premier to own a piece";
    obj19.lableSate = @"Benin";
    [array addObject:obj19];
    
    return array;
}


- (NSArray*)arrayContactObj {
    NSMutableArray *array = [[NSMutableArray alloc]init];
    ContactObject *obj = [[ContactObject alloc]init];
    obj.lblCoAssets = @"CoAssets Pte Ltd ";
    obj.lblReg = @"(reg #:201310357R)";
    obj.lblAdress = @"38C North Canal Road, Singapore 059294";
    obj.lblTell = @"Tel: +65-6532 7008";
    [array addObject:obj];
    
    ContactObject *obj1 = [[ContactObject alloc]init];
    obj1.lblCoAssets = @"CoAssets Sdn Bhd";
    obj1.lblReg = @"(reg #: 1058756K)";
    obj1.lblAdress = @"Level 30, The Gardens North Tower,Mid Valley City, Lingkaran Syed Putra, 59200 Kuala Lumpur, Malaysia";
    obj1.lblTell = @"Tel: +60-320 359 662";
    [array addObject:obj1];
    
    ContactObject *obj2 = [[ContactObject alloc]init];
    obj2.lblCoAssets = @"CoAssets Ltd  ";
    obj2.lblReg = @"(ACN 604 341 826)";
    obj2.lblAdress = @"Office J, Level 2,1139 Hay Street West Perth WA 6005";
    obj2.lblTell = @"";
    [array addObject:obj2];
    
    return array;
}

- (NSArray*)arrayAboutProfileObj {
    NSMutableArray *array = [[NSMutableArray alloc]init];
    ProfileObject *obj = [[ProfileObject alloc]init];
    obj.salutation = @"Mr";
    obj.firstname = @"Daniel";
    obj.lastnameurname = @"NGUYEN";
    obj.email = @"email@example.com";
    obj.phone = @"+6501010101";
    obj.address = @"1st street 2rd NewYork";
    obj.image = @"6.jpg";
    obj.orgname = @"Nikmesoft Ltd";
    [array addObject:obj];
     
    return array;
}


@end
