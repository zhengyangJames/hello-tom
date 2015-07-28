//
//  NSMutableString+FontSize.m
//  CoAssets
//
//  Created by TUONG DANG on 7/8/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "NSMutableString+FontSize.h"

@implementation NSAttributedString (FontSize)

- (NSAttributedString*) attributedStringWithFontSize:(CGFloat) fontSize
{
    NSMutableAttributedString* attributedString = [self mutableCopy];
    
    {
        [attributedString beginEditing];
        
        [attributedString enumerateAttribute:NSFontAttributeName inRange:NSMakeRange(0, attributedString.length) options:0 usingBlock:^(id value, NSRange range, BOOL *stop) {
            
            UIFont* font = value;
            font = [font fontWithSize:fontSize];
            
            [attributedString removeAttribute:NSFontAttributeName range:range];
            [attributedString addAttribute:NSFontAttributeName value:font range:range];
        }];
        
        [attributedString endEditing];
    }
    
    return [attributedString copy];
}


@end
