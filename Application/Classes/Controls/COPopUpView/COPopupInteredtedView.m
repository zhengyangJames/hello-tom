//
//  COPopupInteredtedView.m
//  CoAssets
//
//  Created by TUONG DANG on 7/7/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COPopupInteredtedView.h"

@interface COPopupInteredtedView()
{
    __weak IBOutlet UILabel *_lblOfferTitle;
    
}
@property (nonatomic, weak) IBOutlet UIView *contentView;

@end

@implementation COPopupInteredtedView

- (instancetype)init {
    if (self = [super init]) {
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"COPopupInteredtedView" owner:self options:nil];
        self = [subviewArray objectAtIndex:0];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.alpha = 1.0;
    self.contentView.transform = CGAffineTransformMakeScale(1.0, 1.0);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.offerTitle = self.offerTitle;
    [UIView animateWithDuration:0.15
                          delay:0
                        options:kAnimationOptionCurveIOS7
                     animations:^{
                         self.contentView.alpha = 1.0;
                         self.contentView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                     } completion:^(BOOL finished) {

                     }];
}

- (void)setOfferTitle:(NSString *)offerTitle {
    _offerTitle = offerTitle;
    _lblOfferTitle.text = offerTitle;
}

- (IBAction)_actionCancel:(id)sender {
    [UIView animateWithDuration:0.15
                          delay:0
                        options:kAnimationOptionCurveIOS7
                     animations:^{
                         self.alpha = 0.0;
                         self.transform = CGAffineTransformMakeScale(1.1, 1.1);
                     } completion:^(BOOL finished) {
                        [self removeFromSuperview];
                     }];
}

+ (void)showPopup:(NSString*)offerTitler{
    COPopupInteredtedView *popup = [COPopupInteredtedView autoLayoutView];
    popup.translatesAutoresizingMaskIntoConstraints = NO;
    popup.offerTitle = offerTitler;
    [[kAppDelegate window] addSubview:popup];
    [popup pinToSuperviewEdges:JRTViewPinAllEdges inset:0];
}

@end
