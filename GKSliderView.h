//
//  GKSliderView.h
//  Demo
//
//  Created by 郭凯 on 16/5/5.
//  Copyright © 2016年 TY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ResetFrameBlock)();

@interface GKSliderView : UIView

@property (nonatomic, copy)ResetFrameBlock resetBlock;

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr controllerNameArr:(NSArray *)nameArr;

@end
