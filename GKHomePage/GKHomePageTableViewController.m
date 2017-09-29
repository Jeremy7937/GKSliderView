//
//  GKHomePageTableViewController.m
//  微博个人主页
//
//  Created by 郭凯 on 2017/9/29.
//  Copyright © 2017年 guokai. All rights reserved.
//

#import "GKHomePageTableViewController.h"
#import "GKTableView.h"

@interface GKHomePageTableViewController ()

@end

@implementation GKHomePageTableViewController

- (void)setSectionBar:(FSSegmentTitleView *)sectionBar {
    _sectionBar = sectionBar;
    
    GKTableView *tableView = (GKTableView *)self.tableView;
    tableView.sectionBar = _sectionBar;
}

- (void)loadView {
    GKTableView *tableView = [[GKTableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    self.view = tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.contentInset = UIEdgeInsetsMake(244, 0, 0, 0);
    [self.tableView setShowsVerticalScrollIndicator:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat contentOffsetY = scrollView.contentOffset.y + 244;
    NSLog(@"_______scrollViewContentOffsetY:%lf",contentOffsetY);
    
    CGFloat scrollDistance = 244-64-44;
    
    CGFloat alphaValue = contentOffsetY / scrollDistance;
    self.gradentView.alpha = contentOffsetY <= scrollDistance ? alphaValue : 1;
    
    CGRect frame = self.topView.frame;
    frame.origin.y = contentOffsetY <= scrollDistance ? -contentOffsetY : -scrollDistance;
    self.topView.frame= frame;
    
}

@end
