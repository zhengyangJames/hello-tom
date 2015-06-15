//
//  CODropListView.m
//  CoAssest
//
//  Created by TUONG DANG on 6/14/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODropListView.h"
#import "DropListCell.h"

@interface CODropListView()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *_arrayListCustomCell;
}
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UIView *contentView;

@end

@implementation CODropListView

- (instancetype)init {
    if (self = [super init]) {
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"CODropListView" owner:self options:nil];
        self = [subviewArray objectAtIndex:0];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.contentView setTransform:CGAffineTransformMakeTranslation(0,0)];
};

- (void)viewDidLoad {
    [self _setupUI];
}

- (void)_setupUI {
    [UIView animateWithDuration:1.195
                          delay:0.0
         usingSpringWithDamping:0.495
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
        [self.contentView setTransform:CGAffineTransformMakeTranslation( 0, self.bounds.size.height)];
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - Actions
- (IBAction)__actionDone:(id)sender {
    if(self.didSelect) {
        self.didSelect(self.selectedIndex);
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self.contentView setTransform:CGAffineTransformMakeTranslation( 0, -self.bounds.size.height)];
    } completion:^(BOOL finished) {
        [self dismissWithAnimation:UIViewAnimationOptionTransitionCrossDissolve duration:0.235];
    }];
}

- (IBAction)__actionClose:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        [self.contentView setTransform:CGAffineTransformMakeTranslation( 0, -self.bounds.size.height)];
    } completion:^(BOOL finished) {
        [self dismissWithAnimation:UIViewAnimationOptionTransitionCrossDissolve duration:0.235];
    }];
}

#pragma mark - Setters
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    [_tableView reloadData];
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    if (_dataArray && _dataArray.count) {
        if ([_dataArray[0] isKindOfClass:[NSDictionary class]]) {
            _arrayListCustomCell = [_dataArray copy];
            [self.tableView registerNib:[UINib nibWithNibName:[DropListCell identifier] bundle:nil] forCellReuseIdentifier:[DropListCell identifier]];
        }
    }
    [_tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_arrayListCustomCell && _arrayListCustomCell.count) {
        return _arrayListCustomCell.count;
    } else {
        return self.dataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //set up with custom cell
    if (_arrayListCustomCell &&_arrayListCustomCell.count) {
        DropListCell *cell = [tableView dequeueReusableCellWithIdentifier:[DropListCell identifier]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.object = _arrayListCustomCell[indexPath.row];
        if (self.selectedIndex == indexPath.row) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
        
        return cell;
    //set up default cell
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell identifier]];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[UITableViewCell identifier]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.text = self.dataArray[indexPath.row];
        if (self.selectedIndex == indexPath.row) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // don't do anything
    if(indexPath.row == self.selectedIndex) {
        return;
    }
    // remove previous selected cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0]];
    if(cell) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    // select new cell
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    if(selectedCell) {
        selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.selectedIndex = indexPath.row;
    }
}

#pragma mark - Public

+ (void)presentWithTitle:(NSString*)title data:(NSArray*)data selectedIndex:(NSInteger)index didSelect:(void (^)(NSInteger))didSelect {
    CODropListView *dropList = [CODropListView autoLayoutView];
    dropList.tableView.delegate = dropList;
    dropList.tableView.dataSource = dropList;
    dropList.tableView.tableFooterView = [UIView new];
    dropList.dataArray = data;
    dropList.selectedIndex = index;
    dropList.title.text = title;
    dropList.didSelect = [didSelect copy];
    [[kAppDelegate window] addSubview:dropList];
    [dropList pinToSuperviewEdges:JRTViewPinAllEdges inset:0];
}


@end
