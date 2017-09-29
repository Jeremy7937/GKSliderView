//
//  GKHomePagseeViewController.m
//  微博个人主页
//
//  Created by 郭凯 on 2017/9/26.
//  Copyright © 2017年 guokai. All rights reserved.
//

#import "GKHomePageViewController.h"
#import "Define.h"
#import "GKNavigationBar.h"
#import "FSSegmentTitleView.h"
#import "GKHomePageTableViewController.h"

static CGFloat const headerViewH = 200;
static CGFloat const sectionBarH = 44;

@interface GKHomePageViewController () <FSSegmentTitleViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) GKNavigationBar *navBar;
@property (nonatomic, strong) FSSegmentTitleView *sectionBar;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIScrollView *contentScrollView;

@property (nonatomic, assign) NSInteger selectedIndex;
@end

@implementation GKHomePageViewController

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, headerViewH+sectionBarH)];
        _topView.backgroundColor = [UIColor orangeColor];
        _topView.userInteractionEnabled = NO;
        
        [_topView addSubview:self.headerView];
        [_topView addSubview:self.sectionBar];
        
    }
    return _topView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, headerViewH)];
        _headerView.backgroundColor = [UIColor lightGrayColor];
        
    }
    return _headerView;
}

- (FSSegmentTitleView *)sectionBar {
    if (!_sectionBar) {
        _sectionBar = [[FSSegmentTitleView alloc] initWithFrame:CGRectMake(0, headerViewH, kScreenSizeWidth, sectionBarH) delegate:self indicatorType:2];
        _sectionBar.isDivide = YES;
        
        NSMutableArray *titlesArr = [NSMutableArray array];
        for (UIViewController *vc in self.childViewControllers) {
            [titlesArr addObject:vc.title];
        }
        _sectionBar.titlesArr = titlesArr;
        _sectionBar.titleSelectColor = kSetRGBColor(16, 142, 233);
        _sectionBar.titleNormalColor = kSetRGBColor(51, 51, 51);
        _sectionBar.indicatorColor = kSetRGBColor(16, 142, 233);
        _sectionBar.backgroundColor = [UIColor whiteColor];
        _sectionBar.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _sectionBar.layer.borderWidth = 0.5;
    }
    return _sectionBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //设置内容滚动视图
        [self setupContentScrollView];
        
        //设置头视图
        [self.view addSubview:self.topView];
        
        //设置导航
        [self setupNavBar];
        
        //传递数据
        [self setupChildVc];
    });
    
}

- (void)setupContentScrollView {

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, kScreenSizeHeight)];
    [self.view addSubview:scrollView];
    _contentScrollView = scrollView;
    
    _contentScrollView.contentSize = CGSizeMake(kScreenSizeWidth*self.childViewControllers.count, kScreenSizeHeight);
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.bounces = NO;
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    
    _contentScrollView.delegate = self;
    
    [self FSSegmentTitleView:_sectionBar startIndex:0 endIndex:0];
    
}

- (void)setupNavBar {
    GKNavigationBar *bar = [GKNavigationBar barWithTitle:self.title backAction:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:bar];
    self.navBar = bar;
}

- (void)setupChildVc {
    for (GKHomePageTableViewController *vc in self.childViewControllers) {
        
        vc.topView = self.topView;
        vc.sectionBar = self.sectionBar;
        vc.gradentView = self.navBar.gradentView;
    }
}

#pragma mark -- ContentScrollView 滚动停止 代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger endIndex = scrollView.contentOffset.x / kScreenSizeWidth;
    self.sectionBar.selectIndex = endIndex;
    
    [self addOneChildViewControllerWithStartIndex:_selectedIndex endIndex:endIndex];
    
    _selectedIndex = endIndex;
}

//当视图滚动到一半的时候 同步偏移量
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat lastOffsetX = _selectedIndex * kScreenSizeWidth;
    CGFloat differenceOffsetX = scrollView.contentOffset.x - lastOffsetX;
    
    NSLog(@"_____differenceOffsetX:%f",differenceOffsetX);
    if (fabs(differenceOffsetX) > kScreenSizeWidth*0.5) {
        CGFloat endIndex = differenceOffsetX > 0 ? _selectedIndex+1 : _selectedIndex-1;
        [self synchronTableViewContetnOffsetWithStartIndex:_selectedIndex endIndex:endIndex];
    }
}

#pragma mark -- 点击sectionView btn 触发的事件
- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    
    NSLog(@"______endIndex:%ld",(long)endIndex);
    //添加对应的子控制器View
    [self addOneChildViewControllerWithStartIndex:_selectedIndex endIndex:endIndex];
    
    //内容滚动到相应的位置
    [UIView animateWithDuration:0.25 animations:^{
        self.contentScrollView.contentOffset = CGPointMake(kScreenSizeWidth*endIndex, 0);
    }];
    
    _selectedIndex = endIndex;
}

- (void)addOneChildViewControllerWithStartIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    
    GKHomePageTableViewController *vc = self.childViewControllers[endIndex];
    if (!vc.view.superview) {
        vc.view.frame = CGRectMake(endIndex*kScreenSizeWidth, 0, kScreenSizeWidth, kScreenSizeHeight);
        [self.contentScrollView addSubview:vc.view];
    }
    
    [self synchronTableViewContetnOffsetWithStartIndex:startIndex endIndex:endIndex];
}

//同步contentOffset
- (void)synchronTableViewContetnOffsetWithStartIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    
    GKHomePageTableViewController *vc = self.childViewControllers[endIndex];
    //获取上一个view
    UITableView *lastView = (UITableView *)[self.childViewControllers[startIndex] view];
    if (lastView.contentOffset.y < -108) {
        vc.tableView.contentOffset = lastView.contentOffset;
    }else {
        if (vc.tableView.contentOffset.y < -108) {
            vc.tableView.contentOffset = CGPointMake(0, -108);
        }
    }
}


@end
