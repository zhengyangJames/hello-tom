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
    CODetailsProjectBottomTVCell *_bottomTableView;
}

@property (strong, nonatomic) NSArray *arrayData;
@property (strong, nonatomic) NSArray *arrayImage;

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
    [self _setupBottomTableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:[CODetailsProjectTypeCell identifier] bundle:nil] forCellReuseIdentifier:[CODetailsProjectTypeCell identifier]];
}

#pragma mark - Set Get
- (void)setObject:(CODetailsOffersObject *)object {
    _object = object;
    [_tableView reloadData];

}

- (NSArray*)arrayImage {
    if (!_arrayImage) {
        return  _arrayImage = @[@"ic_info",@"ic_peropel"];
    }
    return  _arrayImage;
}

#pragma mark - Private
- (void)_setupBottomTableView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 116)];
    [view setBackgroundColor:[UIColor redColor]];
    _bottomTableView = [[CODetailsProjectBottomTVCell alloc]initWithNibName:[CODetailsProjectBottomTVCell identifier]];
//    _bottomTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:_bottomTableView];
    [_bottomTableView pinToSuperviewEdges:JRTViewPinAllEdges inset:0];
    _tableView.tableFooterView = view;
}

#pragma mark - Action

#pragma mark - Delegate - Tableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self _setupCellProjectType:tableView indexPath:indexPath];
}

- (CODetailsProjectTypeCell*)_setupCellProjectType:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    CODetailsProjectTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODetailsProjectTypeCell identifier] forIndexPath:indexPath];
    if (DetailsProjectType == indexPath.row) {
        cell.imageLogo.image = [UIImage imageNamed:self.arrayImage[indexPath.row]];
        cell.lblType.text = @"Project Type:";
        cell.lblDetails.text = self.object.projectType;
    } else {
        cell.imageLogo.image = [UIImage imageNamed:self.arrayImage[indexPath.row]];
        cell.lblType.text = @"Project Site:";
        cell.lblDetails.text = [NSString stringWithFormat:@"%@, %@",self.object.city,self.object.country];
    }
    return cell;
}

#pragma mark - Delegate - Bottom Tableview
- (void)detailsProfileAction:(CODetailsProjectBottomTVCell *)detailsProfileCell didSelectAction:(CODetailsProjectAction)detailsProjectAction {
    
}


@end
