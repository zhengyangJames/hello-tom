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
#import "COLoginManager.h"


@interface FormCell() {
    __weak IBOutlet CoDropListButtom *_btnDrop;
}

@property (nonatomic, strong) NSNumber *index;
@property (nonatomic, strong) NSDictionary *arrCurrency;
@property (nonatomic, strong) NSDictionary *currencyModel;

@end

@implementation FormCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _btnDrop.layer.cornerRadius = 4;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    NSDictionary *dic = self.arrCurrency[[self.index integerValue]];
//    NSString *value = [dic objectForKey:@"currencySymbol"];
//    [_btnDrop setTitle:value forState:UIControlStateNormal];
    
}

#pragma mark - setter, getter
- (NSDictionary *)arrCurrency {
    if (_arrCurrency) {
        return _arrCurrency;
    }
    NSMutableArray *keys = [[NSMutableArray alloc] init];
    NSMutableArray *values = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < self.currencyModel.allKeys.count; i++) {
        NSString *key = self.currencyModel.allKeys[i];
        NSString *value = [self.currencyModel objectForKey:key];
        [keys addObject:key];
        [values addObject:value];
    }
    
    return _arrCurrency = @{@"keys":keys, @"values":values};
}

- (NSNumber *)index {
    if ([kUserDefaults objectForKey:UPDATE_CURRENCY]) {
        return  _index = [kUserDefaults objectForKey:UPDATE_CURRENCY];
    }
    return 0;
}

- (NSDictionary *)currencyModel {
    if (_currencyModel) {
        return _currencyModel;
    }
    return  _currencyModel = [[COLoginManager shared] currencyPortpolio];
}


#pragma mark - Action

- (IBAction)__actionInvestor:(id)sender {
    [self endEditing:NO];
    
    DBG(@"%@",[self.currencyModel allKeys]);

    [CODropListView presentWithTitle:@"Currency" data:self.arrCurrency[@"values"] selectedIndex:[self.index integerValue] didSelect:^(NSInteger index) {
        [kUserDefaults setObject:[NSNumber numberWithInteger:index] forKey:UPDATE_CURRENCY];
        [kUserDefaults synchronize];
        [_btnDrop setTitle:self.arrCurrency[@"keys"] [index] forState:UIControlStateNormal];
    }];
}

@end
