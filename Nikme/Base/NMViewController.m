//
//  NMViewController.m
//  NikmeCamera
//
//  Created by Linh NGUYEN on 10/22/14.
//  Copyright (c) 2014 Nikmesoft Ltd. All rights reserved.
//

#import "NMViewController.h"

@implementation NMViewController

- (id)init
{
    NSString *nibFile = NSStringFromClass([self class]);
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *suffix = NSStringFromClass([self class]);
    if ([bundle pathForResource:nibFile ofType:@"nib"])
    {
        if(IS_IPHONE)
        {
            if(IS_IPHONE_5)
            {
                suffix = @"-568h";
            } else if(IS_IPHONE_6)
            {
                suffix = @"-667h";
            } else if(IS_IPHONE_6PLUS)
            {
                suffix = @"-736h";
            }
        } else
        {
            suffix = @"~ipad";
        }
        NSString *nibNameSuffix = [NSString stringWithFormat:@"%@%@", nibFile, suffix];
        if ([bundle pathForResource:nibNameSuffix ofType:@"nib"]) {
            nibFile = nibNameSuffix;
        }
        self = [super initWithNibName:nibFile bundle:nil];
    } else {
        self = [super init];
    }
    return self;
}

@end
