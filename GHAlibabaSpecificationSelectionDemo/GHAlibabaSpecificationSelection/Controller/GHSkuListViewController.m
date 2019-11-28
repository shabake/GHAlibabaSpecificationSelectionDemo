//
//  GHSkuListViewController.m
//  GHAlibabaSpecificationSelectionDemo
//
//  Created by mac on 2019/11/28.
//  Copyright © 2019 macBookPro. All rights reserved.
//

#import "GHSkuListViewController.h"
#import "GHSpecificationSelectionModel.h"
#import "GHSpecificationSelectionTitleModel.h"

@interface GHSkuListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *table;

@end

@implementation GHSkuListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

- (void)setupUI {
    [self.view addSubview:self.table];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10.01f)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10.01f)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    GHSpecificationSelectionTitleModel *titleModel = self.dataArray[section];
    return titleModel.skuList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GHSpecificationSelectionTitleModel *titleModel = self.dataArray[indexPath.section];
    GHSpecificationSelectionModel *skuModel = titleModel.skuList[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    cell.textLabel.text = skuModel.sku_name;
    return cell;
}

- (UITableView *)table {
    if (_table == nil) {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, kSafeAreaTopHeight, kScreenWidth, kScreenHeight - kSafeAreaTopHeight) style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        _table.tableFooterView = [UIView new];
        [_table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCellID"];
    }
    return _table;
}

@end
