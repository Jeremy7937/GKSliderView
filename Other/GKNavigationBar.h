//
//  GKNavigationBar.h
//  微博个人主页
//
//  Created by 郭凯 on 2017/9/26.
//  Copyright © 2017年 guokai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BarBackAction)(void);

@interface GKNavigationBar : UIView

@property (nonatomic, strong) UIView *gradentView;

+ (instancetype)barWithTitle:(NSString *)title backAction:(BarBackAction)backAction;

@end
