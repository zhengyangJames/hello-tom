//
//  CODetailsProjectCell.m
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsProjectTBVCell.h"
#import "CODetailsProjectBottomTVCell.h"
#import "CODetailsProjectTypeCell.h"

#define kCORNER_RADIUS_IMAGE 6

@interface CODetailsProjectTBVCell () <UITableViewDataSource,UITableViewDelegate,CODetailsProjectBottomTVCellDelegate>
{
    __weak IBOutlet UITableView *_tableView;
}

@property (strong, nonatomic) NSArray *arrayData;

@end

@implementation CODetailsProjectTBVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _tableView.layer.cornerRadius = kCORNER_RADIUS_IMAGE;
    [self setNeedsDisplay];
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    self.contentView.frame = self.bounds;
}

- (void)viewDidLoad {
    
}

#pragma mark - Set Get
- (void)setObject:(NSDictionary *)object {
    _object = object;

}

#pragma mark - Private

#pragma mark - Action

#pragma mark - Delegate - Tableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayData.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CODetailsProjectTypeCell *cell;
    return cell;
}

#pragma mark - Delegate - Bottom Tableview
- (void)detailsProfileAction:(CODetailsProjectBottomTVCell *)detailsProfileCell didSelectAction:(CODetailsProjectAction)detailsProjectAction {
    
}


@end
