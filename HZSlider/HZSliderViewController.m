//
//  HZSliderViewController.m
//  WeiboHomeDemo
//
//  Created by 郭凯 on 2017/6/14.
//  Copyright © 2017年 郭凯. All rights reserved.
//

#import "HZSliderViewController.h"
#import "Define.h"
#import "FSSegmentTitleView.h"
#import "ContentView.h"
#import "LeftTableViewController.h"
#import "RightTableViewController.h"
#import "CenterTableViewController.h"
#import "HZNavigationBar.h"

@interface HZSliderViewController ()<FSSegmentTitleViewDelegate,ContentViewDelegate>

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) FSSegmentTitleView *sectionView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) ContentView *contentView;
@property (nonatomic, strong) HZNavigationBar *bar;
@end

@implementation HZSliderViewController

- (UIView *)sectionView {
    if (!_sectionView) {
        _sectionView = [[FSSegmentTitleView alloc] initWithFrame:CGRectMake(0, kHeaderViewH, kScreenSizeW, kSectionViewH) delegate:self indicatorType:2];
        _sectionView.isDivide = YES;
        _sectionView.titlesArr = @[@"主页",@"微博",@"相册"];
        _sectionView.backgroundColor = [UIColor whiteColor];
        _sectionView.layer.borderColor = kSetRGBColor(175, 175, 175).CGColor;
        _sectionView.layer.borderWidth = 0.5;
    }
    return _sectionView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeW, kHeaderViewH)];
        _headerView.backgroundColor = [UIColor lightGrayColor];
    }
    return _headerView;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeW, kTopViewH)];
        _topView.backgroundColor = [UIColor lightGrayColor];
        
        [_topView addSubview:self.headerView];
        [_topView addSubview:self.sectionView];
    }
    return _topView;
}

- (ContentView *)contentView {
    if (!_contentView) {
        _contentView = [[ContentView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeW, kScreenSizeH)];
        LeftTableViewController *left = [[LeftTableViewController alloc] init];
        RightTableViewController *right = [[RightTableViewController alloc] init];
        CenterTableViewController *center = [[CenterTableViewController alloc] init];
        _contentView.childVc = @[left,center,right];
        _contentView.delegate = self;
    }
    return _contentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.topView];
    
    self.bar = [HZNavigationBar barWithTitle:@"个人中心" backImageStr:@"navigation_back_gray" rightTitles:nil rightNormalImages:nil rightChangeImages:nil backEvent:^(NSInteger btnIndex) {
        [self.navigationController popViewControllerAnimated:YES];
    } RightEvents:nil];
    [self.view addSubview:self.bar];
    
}

#pragma makr -- FSSegmentTitleViewDelegate
- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    
    [_contentView scrollIndex:endIndex];
}

#pragma  mark -- ContentViewDelegate
- (void)contentViewScrollIndex:(NSInteger)index {
    _sectionView.selectIndex = index;
}

- (void)contentViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y+kTopViewH;
    NSLog(@"________offset:%f",offset);
    
    self.bar.gradientView.alpha = offset>kHeaderViewH-kNavigaBarH?1.0:offset/(kHeaderViewH-kNavigaBarH);
    
    CGRect frame = _topView.frame;
    frame.origin.y = offset>kHeaderViewH-kNavigaBarH ? -(kHeaderViewH-kNavigaBarH) :-offset;
    _topView.frame = frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
