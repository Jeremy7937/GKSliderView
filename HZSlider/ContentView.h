//
//  ContentView.h
//  WeiboHomeDemo
//
//  Created by 郭凯 on 2017/6/14.
//  Copyright © 2017年 郭凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"

@protocol ContentViewDelegate <NSObject>

- (void)contentViewScrollIndex:(NSInteger)index;

- (void)contentViewDidScroll:(UIScrollView *)scrollView;

@end

@interface ContentView : UIView

@property (nonatomic, strong) NSArray <BaseTableViewController*> *childVc;
@property (nonatomic, weak) id<ContentViewDelegate>delegate;

- (void)scrollIndex:(NSInteger)index;

@end
