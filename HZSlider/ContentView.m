//
//  ContentView.m
//  WeiboHomeDemo
//
//  Created by 郭凯 on 2017/6/14.
//  Copyright © 2017年 郭凯. All rights reserved.
//

#import "ContentView.h"
#import "Define.h"

@interface ContentView ()<UIScrollViewDelegate,BaseTableViewControllerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation ContentView

- (void)setChildVc:(NSArray<BaseTableViewController *> *)childVc {
    _childVc = childVc;
    
    [self setupScrollView];
}

- (void)setupScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.contentSize = CGSizeMake(kScreenSizeW*_childVc.count, kScreenSizeH);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    [self addSubview:self.scrollView];
    
    for (NSInteger i = 0; i < _childVc.count; i++) {
        BaseTableViewController *vc = _childVc[i];
        vc.delegate = self;
        vc.view.frame = CGRectMake(i*kScreenSizeW, 0, kScreenSizeW, kScreenSizeH);
        [self.scrollView addSubview:vc.view];
    }
}

- (void)scrollIndex:(NSInteger)index {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.scrollView.contentOffset = CGPointMake(index*kScreenSizeW, 0);
    }];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x/kScreenSizeW;
    
    if ([self.delegate respondsToSelector:@selector(contentViewScrollIndex:)]) {
        [self.delegate contentViewScrollIndex:index];
    }
}

#pragma mark -- BaseTableViewControllerDelegate
- (void)tableViewDidScroll:(UIScrollView *)tableView {
    CGFloat offset = tableView.contentOffset.y+kTopViewH;
    
    if (offset < kHeaderViewH-kNavigaBarH) {
        for (BaseTableViewController *vc in _childVc) {
            if (vc.tableView != tableView) {
                vc.tableView.contentOffset = tableView.contentOffset;
            }
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(contentViewDidScroll:)]) {
        [self.delegate contentViewDidScroll:tableView];
    }
}

@end
