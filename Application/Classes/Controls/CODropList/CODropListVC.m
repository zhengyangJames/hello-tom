//
//  DropListVC.m
//  Albameet
//
//  Created by Linh NGUYEN on 5/9/15.
//  Copyright (c) 2015 Linh NGUYEN. All rights reserved.
//

#import "CODropListVC.h"
#import "BaseNavigationController.h"
#import "COListFilterObject.h"

@interface CODropListVC()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation CODropListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
}

- (void)_setupUI {
    UITableView *tableView = [UITableView autoLayoutView];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
    [self.view addSubview:tableView];
    [tableView pinToSuperviewEdges:JRTViewPinAllEdges inset:0];
    self.tableView = tableView;

    UIBarButtonItem *btDone = [[UIBarButtonItem alloc]initWithTitle:m_string(@"Done")
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(__actionDone:)];
    [btDone setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Raleway-Regular" size:17]}forState:UIControlStateNormal];
    
    UIBarButtonItem *btCancel = [[UIBarButtonItem alloc]initWithTitle:m_string(@"Cancel")
                                                              style:UIBarButtonItemStyleDone
                                                             target:self
                                                             action:@selector(__actionDCancel:)];
    [btCancel setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Raleway-Regular" size:17]}forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btDone;
    self.navigationItem.leftBarButtonItem = btCancel;
}

#pragma mark - Actions
- (void)__actionDone:(id)sender {
    if(self.didSelect) {
        self.didSelect(self.selectedIndex);
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)__actionDCancel:(id)sender {

    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - Setters
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    [self.tableView reloadData];
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [self.tableView reloadData];
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataArray) {
        return self.dataArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell identifier]];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[UITableViewCell identifier]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (self.dataArray && self.dataArray.count > 0) {
        COListFilterObject *obj = self.dataArray[indexPath.row];
        cell.textLabel.text = obj.key;
    }
    if (self.selectedIndex == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    [cell.textLabel setFont:[UIFont systemFontOfSize:16]];
    
    return cell;
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
        for (int i = 0; i < self.dataArray.count; i++) {
            COListFilterObject *filterObj = self.dataArray[i];
            filterObj.indexSelected = (i!=indexPath.row)?-1:i;
        }
        self.selectedIndex = indexPath.row;
    }
}

+ (void)presentWithTitle:(NSString*)title data:(NSArray*)data parentVC:(UIViewController*)parentVC didSelect:(void (^)(NSInteger))didSelect {
    CODropListVC *dropList = [[CODropListVC alloc] init];
    int i = 0;
    dropList.selectedIndex = 0;
    for (; i< data.count;i++) {
        COListFilterObject *obj = data[i];
        if (obj.indexSelected>=0) {
            dropList.selectedIndex = i;
            break;
        }
    }
    dropList.dataArray = data;
    dropList.navigationItem.title = title;
    dropList.didSelect = [didSelect copy];
    BaseNavigationController *navController = [[BaseNavigationController alloc] initWithRootViewController:dropList];
    [parentVC presentViewController:navController animated:YES completion:nil];
}
@end
