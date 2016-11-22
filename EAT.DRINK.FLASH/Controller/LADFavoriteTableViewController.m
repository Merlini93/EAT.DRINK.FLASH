//
//  LADFavoriteTableViewController.m
//  EAT.DRINK.FLASH
//
//  Created by 李遨东 on 16/3/17.
//  Copyright © 2016年 Merlini. All rights reserved.
//

#import "LADFavoriteTableViewController.h"
#import "LADTableViewCell.h"
#import "LADDeatailViewController.h"
#import "LADDealModel.h"
#import "LADDataBase.h"

static NSString * const reuseidentifier = @"reuseidentifier";

@interface LADFavoriteTableViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation LADFavoriteTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.dataArray = [[[[LADDataBase alloc] init] findAll] mutableCopy];
    [self.tableView reloadData];
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[[[LADDataBase alloc] init] findAll] mutableCopy];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[LADTableViewCell class] forCellReuseIdentifier:reuseidentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    LADDealModel *model = self.dataArray[indexPath.row];
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        [self.dataArray removeObject:model];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [[[LADDataBase alloc] init] deleteByRowid:[NSNumber numberWithInteger:model.rowid]];
    }
}

#pragma mark - Tableview点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LADDealModel *model = self.dataArray[indexPath.row];
    LADDeatailViewController *dvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LADDeatailViewController"];
    dvc.model = model;
    [self.navigationController pushViewController:dvc animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LADTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseidentifier forIndexPath:indexPath];
    
    LADDealModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    
    return cell;
}
@end
