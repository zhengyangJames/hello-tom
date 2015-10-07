//
//  COLabelTextAligin.m
//  CoAssets
//
//  Created by Tony Tuong on 10/7/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "COLabelTextAligin.h"

@implementation COLabelTextAligin

- (void)awakeFromNib {
    self.textColor = [UIColor blackColor];
    self.font = [UIFont fontWithName:@"Raleway-Regular" size:15];
}

- (void)drawTextInRect:(CGRect)rect {
    if (self.text) {
        CGSize labelStringSize = [self.text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame), CGFLOAT_MAX)
                                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                      attributes:@{NSFontAttributeName:self.font}
                                                         context:nil].size;
        [super drawTextInRect:CGRectMake(0, 0, ceilf(CGRectGetWidth(self.frame)),ceilf(labelStringSize.height))];
    } else {
        [super drawTextInRect:rect];
    }
}

- (void)prepareForInterfaceBuilder {
    [super prepareForInterfaceBuilder];
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor blackColor].CGColor;
}

@end


//Swift
//@IBDesignable class TopAlignedLabel: UILabel {
//    override func drawTextInRect(rect: CGRect) {
//        if let stringText = text {
//            let stringTextAsNSString = stringText as NSString
//            var labelStringSize = stringTextAsNSString.boundingRectWithSize(CGSizeMake(CGRectGetWidth(self.frame), CGFloat.max),
//                                                                            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
//                                                                            attributes: [NSFontAttributeName: font],
//                                                                            context: nil).size
//            super.drawTextInRect(CGRectMake(0, 0, CGRectGetWidth(self.frame), ceil(labelStringSize.height)))
//        } else {
//            super.drawTextInRect(rect)
//        }
//    }
//    override func prepareForInterfaceBuilder() {
//        super.prepareForInterfaceBuilder()
//        layer.borderWidth = 1
//        layer.borderColor = UIColor.blackColor().CGColor
//    }
//}