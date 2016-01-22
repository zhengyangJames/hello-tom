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

@property (nonatomic, strong) NSNumber *index;
@property (nonatomic, strong) NSArray *arrCurrency;

@end

@implementation FormCell

- (void)awakeFromNib {
    _btnDrop.layer.cornerRadius = 4;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = self.arrCurrency[[self.index integerValue]];
    NSString *value = [dic objectForKey:@"currencySymbol"];
    [_btnDrop setTitle:value forState:UIControlStateNormal];
    
}

#pragma mark - setter, getter
- (NSArray *)arrCurrency {
    if (_arrCurrency) {
        return _arrCurrency;
    }
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Currency" ofType:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
    return _arrCurrency = arr;
}

- (NSNumber *)index {
    if ([kUserDefaults objectForKey:UPDATE_CURRENCY]) {
        return  _index = [kUserDefaults objectForKey:UPDATE_CURRENCY];
    }
    return 0;
}

#pragma mark - Action

- (IBAction)__actionInvestor:(id)sender {
    [self endEditing:NO];
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in self.arrCurrency) {
        NSString *key = [dic objectForKey:@"currencyName"];
        [arr addObject:key];
    }
    [CODropListView presentWithTitle:@"Currency" data:arr selectedIndex:[self.index integerValue] didSelect:^(NSInteger index) {
        [kUserDefaults setObject:[NSNumber numberWithInteger:index] forKey:UPDATE_CURRENCY];
        [kUserDefaults synchronize];
        NSString *value = [self.arrCurrency[index] objectForKey:@"currencySymbol"];
        [_btnDrop setTitle:value forState:UIControlStateNormal];
    }];
}

@end
