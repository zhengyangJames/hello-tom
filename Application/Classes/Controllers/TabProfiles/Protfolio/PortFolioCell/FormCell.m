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
#import "COCurrencyModel.h"


@interface FormCell() {
    __weak IBOutlet CoDropListButtom *_btnDrop;
}

@property (nonatomic, strong) NSNumber *index;
@property (nonatomic, strong) NSArray *arrCurrency;
@property (nonatomic, strong) NSDictionary *currencyModel;

@end

@implementation FormCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    _btnDrop.layer.cornerRadius = 4;
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    NSDictionary *dic = self.arrCurrency[[self.index integerValue]];
//    NSString *value = [dic objectForKey:@"currencySymbol"];
//    [_btnDrop setTitle:value forState:UIControlStateNormal];
    
}

#pragma mark - setter, getter
- (NSArray *)arrCurrency {
    if (_arrCurrency) {
        return _arrCurrency;
    }

    return _arrCurrency = [self.currencyModel allKeys];
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
    
    DBG(@"%@",self.currencyModel);

    [CODropListView presentWithTitle:@"Currency" data:self.arrCurrency selectedIndex:[self.index integerValue] didSelect:^(NSInteger index) {
        [kUserDefaults setObject:[NSNumber numberWithInteger:index] forKey:UPDATE_CURRENCY];
        [kUserDefaults synchronize];
        
        NSString *value = [self.currencyModel objectForKey:self.arrCurrency[index]];
        [_btnDrop setTitle:value forState:UIControlStateNormal];
    }];
}

@end
