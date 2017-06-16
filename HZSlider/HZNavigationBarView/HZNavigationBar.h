//
//  HZNavigationBar.h
//  PlamExam
//
//  Created by 郭凯 on 2017/3/30.
//  Copyright © 2017年 guokai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickEventHandle)(NSInteger btnIndex);

@interface HZNavigationBar : UIView

@property (nonatomic, strong) UIView *gradientView;

@property (nonatomic, strong) NSArray *rightBtnWhiteImages;
@property (nonatomic, strong) NSArray *rightBtnBlackImages;

//创建 可改变导航字体颜色的导航栏
+ (instancetype)barWithTitle:(NSString *)title backImageStr:(NSString *)backImageStr rightTitles:(NSArray *)rightTitles rightNormalImages:(NSArray *)normalImages rightChangeImages:(NSArray *)changeImages backEvent:(ClickEventHandle)backEvent RightEvents:(ClickEventHandle)rightEvent;

//创建一般title不隐藏 标题
+ (instancetype)barWithTitle:(NSString *)title rightTitles:(NSArray *)rightTitles righImages:(NSArray *)images backBtnImageName:(NSString *)backImageName backEvent:(ClickEventHandle)backEvent rightEvents:(ClickEventHandle)rightEvent;

- (void)changeWhite;
- (void)changeBlack;

@end
