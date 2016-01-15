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
@property (nonatomic, strong) NSArray *arrayInvertor;

@end

@implementation FormCell

- (NSArray *)arrayInvertor {
    if (_arrayInvertor) {
        return _arrayInvertor;
    }
    return _arrayInvertor = [UIHelper getInvestorType];
}

- (void)awakeFromNib {
    _btnDrop.layer.cornerRadius = 4;
}

- (IBAction)__actionInvestor:(id)sender {
    //[self.view endEditing:NO];
    [CODropListView presentWithTitle:@"Investor Type" data:self.arrayInvertor selectedIndex:0 didSelect:^(NSInteger index) {
        [_btnDrop setTitle:self.arrayInvertor[index] forState:UIControlStateNormal];
    }];
}
@end
