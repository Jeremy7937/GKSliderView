//
//  GKTableView.m
//  微博个人主页
//
//  Created by 郭凯 on 2017/9/29.
//  Copyright © 2017年 guokai. All rights reserved.
//

#import "GKTableView.h"

@implementation GKTableView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint curPoint = [touch locationInView:self];
    
    NSInteger index = 0;
    for (UIView *sectionSubView in _sectionBar.subviews.firstObject.subviews) {
        if ([sectionSubView isKindOfClass:[UIButton class]]) {
            
            CGPoint childPoint = [self convertPoint:curPoint toView:sectionSubView];
            
            if ([sectionSubView pointInside:childPoint withEvent:event]) {
                //点击了按钮
                //切换 控制器
                _sectionBar.selectIndex = index;
                [_sectionBar.delegate FSSegmentTitleView:_sectionBar startIndex:0 endIndex:index];
                return;
            }
            index ++;
        }
    }
    
    [super touchesBegan:touches withEvent:event];
}

@end
