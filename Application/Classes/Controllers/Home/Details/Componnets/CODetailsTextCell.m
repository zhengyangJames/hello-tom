//
//  CODetailsTextCell.m
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsTextCell.h"
#import "CODetailsOffersItemObj.h"
#import "COOfferData.h"

@interface CODetailsTextCell () <UIWebViewDelegate>
{
    __weak IBOutlet UITextView  *_detailsTextView;
    __weak IBOutlet UILabel     *_headerLabel;
}
@end

@implementation CODetailsTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - Set Get
- (void)setData:(id<COOfferData>)data {
    _data = data;
    if (_data) {
        NSString *as = [_data cellofferContent];
        DBG(@"%@",as);
    }

}

@end
