//
//  FormCell.m
//  CoAssets
//
//  Created by Macintosh HD on 1/15/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import "FormCell.h"
#import "CODropListView.h"
#import "CoDropListButtom.h"

@interface FormCell() {
    __weak IBOutlet CoDropListButtom *_btnDrop;
}
@property (nonatomic, strong) NSArray *arrayCurrency;

@end

@implementation FormCell

- (NSArray *)arrayCurrency {
    if (_arrayCurrency) {
        return _arrayCurrency;
    }
    return _arrayCurrency = [UIHelper getArrayCurrency];
}

- (void)awakeFromNib {
    _btnDrop.layer.cornerRadius = 4;
     self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (IBAction)__actionInvestor:(id)sender {
    [self endEditing:NO];
    [CODropListView presentWithTitle:@"Currency" data:self.arrayCurrency selectedIndex:0 didSelect:^(NSInteger index) {
        [_btnDrop setTitle:self.arrayCurrency[index] forState:UIControlStateNormal];
    }];
}
@end
