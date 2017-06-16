//
//  BaseTableViewController.m
//  WeiboHomeDemo
//
//  Created by 郭凯 on 2017/6/15.
//  Copyright © 2017年 郭凯. All rights reserved.
//

#import "BaseTableViewController.h"
#import "Define.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellId"];
    self.tableView.contentInset = UIEdgeInsetsMake(kTopViewH, 0, 0, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"测试数据%ld",indexPath.row];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat offset = scrollView.contentOffset.y+kTopViewH;
//    NSLog(@"______offset:%lf",offset);
    
    if ([self.delegate respondsToSelector:@selector(tableViewDidScroll:)]) {
        [self.delegate tableViewDidScroll:scrollView];
    }
}

@end
