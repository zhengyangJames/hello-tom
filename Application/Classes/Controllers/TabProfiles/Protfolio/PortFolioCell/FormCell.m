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
@property (nonatomic, strong) NSDictionary *dicCurrency;

@end

@implementation FormCell

- (void)awakeFromNib {
    _btnDrop.layer.cornerRadius = 4;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - setter, getter
- (NSDictionary *)dicCurrency {
    if (_dicCurrency) {
        return _dicCurrency;
    }
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Curency" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return _dicCurrency = dic;
}


- (IBAction)__actionInvestor:(id)sender {
    [self endEditing:NO];
    [CODropListView presentWithTitle:@"Currency" data:[self.dicCurrency allKeys]  selectedIndex:1 didSelect:^(NSInteger index) {
        [_btnDrop setTitle:[self.dicCurrency objectForKey:[self.dicCurrency allKeys][index]] forState:UIControlStateNormal];
    }];
}

@end
