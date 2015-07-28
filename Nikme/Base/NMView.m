//
//  NMView.m
//  NikmeCamera
//
//  Created by Linh NGUYEN on 10/22/14.
//  Copyright (c) 2014 Nikmesoft Ltd. All rights reserved.
//

#import "NMView.h"

@implementation NMView

- (id)initWithNibName:(NSString*)nibNameOrNil
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    if (nibNameOrNil && [bundle pathForResource:nibNameOrNil ofType:@"nib"])
    {
        NSArray *arrayOfViews = [bundle loadNibNamed:nibNameOrNil owner:self options:nil];
        if([arrayOfViews count] > 0) {
            for (id v in arrayOfViews) {
                if([v isKindOfClass:[self class]])
                {
                    self = v;
                }
            }
        }
    }
    
    if(!self)
    {
        self = [super init];
    }
    return self;
}

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
        self = [self initWithNibName:nibFile];
    } else {
        self = [super init];
        [self viewDidLoad];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self viewDidLoad];
}

- (void)viewDidLoad
{
    
}


@end
