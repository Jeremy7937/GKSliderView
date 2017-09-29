//
//  GKNavigationBar.m
//  微博个人主页
//
//  Created by 郭凯 on 2017/9/26.
//  Copyright © 2017年 guokai. All rights reserved.
//

#import "GKNavigationBar.h"
#import "Define.h"

@interface GKNavigationBar()
@property (nonatomic, copy) BarBackAction backAction;
@property (nonatomic, copy) NSString *title;
@end

@implementation GKNavigationBar

+ (instancetype)barWithTitle:(NSString *)title backAction:(BarBackAction)backAction {
    return [[GKNavigationBar alloc] initWithTitle:title backAction:backAction];
}

- (instancetype)initWithTitle:(NSString *)title backAction:(BarBackAction)backAction {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kScreenSizeWidth, 64);
        self.backAction = backAction;
        self.title = title;
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.gradentView = [[UIView alloc] initWithFrame:self.bounds];
    self.gradentView.backgroundColor = [UIColor whiteColor];
    self.gradentView.alpha = 0.0;
    [self addSubview:self.gradentView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kScreenSizeWidth, 44)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:17];
    label.text = _title;
    label.textColor = kSetRGBColor(74, 74, 74);
    [self.gradentView addSubview:label];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, 20, 50, 44);
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -28, 0, 0);
    [backBtn setImage:[UIImage imageNamed:@"navigation_back_gray"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
}

- (void)backBtnClick:(UIButton *)btn {
    if (self.backAction) {
        self.backAction();
    }
}

@end
