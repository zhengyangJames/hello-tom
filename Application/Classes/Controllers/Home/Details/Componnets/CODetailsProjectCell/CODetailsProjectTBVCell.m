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
#import "NSString_stripHtml.h"

#define kCORNER_RADIUS_IMAGE 6

@interface CODetailsProjectTBVCell () <UITableViewDataSource,UITableViewDelegate,CODetailsProjectBottomTVCellDelegate>
{
    __weak IBOutlet UITableView *_tableView;
    
}

@property (strong, nonatomic) NSArray *arrayData;
@property (strong, nonatomic) NSArray *arrayImage;
@property (strong, nonatomic) CODetailsProjectBottomTVCell *bottomTableView;
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

- (void)viewDidLoad {
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:[CODetailsProjectTypeCell identifier] bundle:nil] forCellReuseIdentifier:[CODetailsProjectTypeCell identifier]];
    [_tableView registerNib:[UINib nibWithNibName:[CODetailsProjectBottomTVCell identifier] bundle:nil] forCellReuseIdentifier:[CODetailsProjectBottomTVCell identifier]];
}

#pragma mark - Set Get
- (void)setObject:(CODetailsOffersObject *)object {
    _object = object;
    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
        [_tableView reloadData];
    }];

}

- (NSArray*)arrayImage {
    if (!_arrayImage) {
        return  _arrayImage = @[@"ic_info",@"ic_peropel"];
    }
    return  _arrayImage;
}

#pragma mark - Private


#pragma mark - Action

#pragma mark - Delegate - Tableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row == 1) {
        return [self _setupCellProjectType:tableView indexPath:indexPath];
    } else {
        return [self _setupButtonCell:tableView indexPath:indexPath];
    }
}

- (CODetailsProjectTypeCell*)_setupCellProjectType:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    CODetailsProjectTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODetailsProjectTypeCell identifier] forIndexPath:indexPath];
    if (DetailsProjectType == indexPath.row) {
        cell.imageLogo.image = [UIImage imageNamed:self.arrayImage[indexPath.row]];
        cell.lblType.text = @"Project Type:";
        cell.lblDetails.text = self.object.projectType ;
    } else if (DetailsProjectSite == indexPath .row) {
        cell.imageLogo.image = [UIImage imageNamed:self.arrayImage[indexPath.row]];
        cell.lblType.text = @"Project Site:";
        cell.lblDetails.text = [NSString stringWithFormat:@"%@, %@",self.object.city,self.object.country];
    }
    return cell;
}

- (CODetailsProjectBottomTVCell*)_setupButtonCell:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    CODetailsProjectBottomTVCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODetailsProjectBottomTVCell identifier] forIndexPath:indexPath];
    cell.delegate = self;
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:self.object.offerID forKey:@"id"];
    [dic setValue:self.object.amount forKey:@"amount"];
    cell.object = dic;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row == 1) {
        return 44;
    } else {
        return 116;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Delegate - Bottom Tableview
- (void)detailsProfileAction:(CODetailsProjectBottomTVCell *)detailsProfileCell didSelectAction:(CODetailsProjectAction)detailsProjectAction {
    switch (detailsProjectAction) {
        case CODetailsProjectActionInterested:
            if ([self.delegate respondsToSelector:@selector(actionButtonDetailsProject)]) {
                [self.delegate actionButtonDetailsProject];
            }
            break;
        case CODetailsProjectActionQuestions: break;
        default: break;
    }
}


@end
