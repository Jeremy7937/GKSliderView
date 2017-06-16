//
//  HZNavigationBar.m
//  PlamExam
//
//  Created by 郭凯 on 2017/3/30.
//  Copyright © 2017年 guokai. All rights reserved.
//

#import "HZNavigationBar.h"
#import "Define.h"

@interface HZNavigationBar ()
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *rightTitles;
@property (nonatomic, strong) NSArray *rightImages;
@property (nonatomic, strong) NSMutableArray <UIButton *> *rightBtns;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) NSString *backBtnImageStr;
//@property (nonatomic, assign) BOOL isHidenTitle;
@property (nonatomic, copy) ClickEventHandle backEventHandle;
@property (nonatomic, copy) ClickEventHandle rightEventHandle;
@end

@implementation HZNavigationBar

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title backImageStr:(NSString *)backImageStr rightTitles:(NSArray *)rightTitles rightNormalImagesName:(NSArray *)noramlImages rightChangeImagesName:(NSArray *)changeImages backEvent:(ClickEventHandle)backEvent rightEvent:(ClickEventHandle)rightEvent {
    if (self = [super initWithFrame:frame]) {
        _rightBtns = [NSMutableArray array];
        _title = title;
        _rightTitles = rightTitles;
        _rightImages = noramlImages;
        _rightBtnWhiteImages = noramlImages;
        _rightBtnBlackImages = changeImages;
        _backBtnImageStr = backImageStr;
        
        self.backgroundColor = [UIColor clearColor];
        self.rightEventHandle = rightEvent;
        self.backEventHandle = backEvent;
        
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title rightTitles:(NSArray *)rightTitles rightImages:(NSArray *)rightImages backImageName:(NSString *)backImageName backEvent:(ClickEventHandle)backEvent rightEvent:(ClickEventHandle)rightEvent {
    if (self = [super initWithFrame:frame]) {

        if ([backImageName isEqualToString:@"navigation_back"]) {
            self.backgroundColor = [UIColor clearColor];
        }else {
//            [self setBorder];
            self.backgroundColor = [UIColor whiteColor];
        }
        _rightBtns = [NSMutableArray array];
        _title = title;
        _rightTitles = rightTitles;
        _rightImages = rightImages;
//        _isHidenTitle = isHidenTitle;
        _backBtnImageStr = backImageName;
        self.backEventHandle = backEvent;
        self.rightEventHandle = rightEvent;
        [self setupNormalNav];
    }
    return self;
}

+ (instancetype)barWithTitle:(NSString *)title backImageStr:(NSString *)backImageStr rightTitles:(NSArray *)rightTitles rightNormalImages:(NSArray *)normalImages rightChangeImages:(NSArray *)changeImages backEvent:(ClickEventHandle)backEvent RightEvents:(ClickEventHandle)rightEvent {
    
    return [[self alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeW, 64) title:title backImageStr:(NSString *)backImageStr rightTitles:rightTitles rightNormalImagesName:normalImages rightChangeImagesName:changeImages backEvent:backEvent rightEvent:rightEvent];
}

+ (instancetype)barWithTitle:(NSString *)title rightTitles:(NSArray *)rightTitles righImages:(NSArray *)images backBtnImageName:(NSString *)backImageName backEvent:(ClickEventHandle)backEvent rightEvents:(ClickEventHandle)rightEvent {
    return [[self alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeW, 64) title:title rightTitles:rightTitles rightImages:images backImageName:backImageName backEvent:backEvent rightEvent:rightEvent];
}

- (void)setupNormalNav {
    
    UIColor *titleColor = kSetRGBColor(74, 74, 74);
    if ([_backBtnImageStr isEqualToString:@"navigation_back"]) {
        titleColor = [UIColor whiteColor];
    }
    
    UILabel *navTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.bounds)-200)*0.5, 20+7, 200, 30)];
    navTitleLabel.textAlignment = NSTextAlignmentCenter;
    navTitleLabel.text = _title;
    navTitleLabel.textColor = titleColor;
    navTitleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self addSubview:navTitleLabel];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, 20+7, 50, 30);
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -28, 0, 0);
    [backBtn setImage:[UIImage imageNamed:_backBtnImageStr] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:_backBtnImageStr] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    
//    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, kScreenSizeWidth, 0.5)];
//    lineLabel.backgroundColor = kSetRGBColor(155, 155, 155);
//    [self addSubview:lineLabel];
    
    if (self.rightImages.count) {
        for (NSInteger i = 0; i < self.rightImages.count; i++) {
            UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            rightBtn.frame = CGRectMake(CGRectGetWidth(self.bounds) - 12 -33*(i+1), 20+7, 40, 30);
            [rightBtn setImage:[UIImage imageNamed:_rightImages[i]] forState:UIControlStateNormal];
            rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            rightBtn.tag = 101+i;
            [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:rightBtn];
            [self.rightBtns addObject:rightBtn];
        }
    }
    
    if (self.rightTitles.count) {
        for (NSInteger i = 0; i < self.rightTitles.count; i++) {
            UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            rightBtn.frame = CGRectMake(CGRectGetWidth(self.bounds) - 12 -33*(i+1), 20+7, 40, 30);
            [rightBtn setTitle:_rightTitles[i] forState:UIControlStateNormal];
            [rightBtn setTitleColor:kSetRGBColor(74, 74, 74) forState:UIControlStateNormal];
            rightBtn.titleLabel.font = [UIFont systemFontOfSize:17];
            rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            rightBtn.tag = 101+i;
            [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:rightBtn];
            [self.rightBtns addObject:rightBtn];
        }
    }
}

- (void)setupUI {
    self.gradientView = [[UIView alloc] initWithFrame:self.bounds];
    self.gradientView.alpha = 0.0;
    self.gradientView.backgroundColor = [UIColor whiteColor];
    self.gradientView.layer.borderWidth = 0.5;
    self.gradientView.layer.borderColor = kSetRGBColor(200, 200, 200).CGColor;
    [self addSubview:self.gradientView];
    
    UILabel *navTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.bounds)-200)*0.5, 20+7, 200, 30)];
    navTitleLabel.textAlignment = NSTextAlignmentCenter;
    navTitleLabel.text = _title;
    navTitleLabel.textColor = kSetRGBColor(74, 74, 74);
    navTitleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.gradientView addSubview:navTitleLabel];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, 20+7, 50, 30);
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -28, 0, 0);
//    backBtn.backgroundColor = [UIColor lightGrayColor];
    [backBtn setImage:[UIImage imageNamed:_backBtnImageStr] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:_backBtnImageStr] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    self.backBtn = backBtn;
    
    if (self.rightImages.count) {
        for (NSInteger i = 0; i < self.rightImages.count; i++) {
            UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            rightBtn.frame = CGRectMake(CGRectGetWidth(self.bounds) - 12 -33*(i+1), 20+7, 40, 30);
            //    rightBtn.backgroundColor = [UIColor lightGrayColor];
            [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            [rightBtn setTitle:_rightTitles[i] forState:UIControlStateNormal];
            [rightBtn setImage:[UIImage imageNamed:_rightImages[i]] forState:UIControlStateNormal];
            rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            rightBtn.tag = 101+i;
            [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:rightBtn];
            [self.rightBtns addObject:rightBtn];
        }
    }
    
    if (self.rightTitles.count) {
        for (NSInteger i = 0; i < self.rightTitles.count; i++) {
            UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            rightBtn.frame = CGRectMake(CGRectGetWidth(self.bounds) - 12 -33*(i+1), 20+7, 40, 30);
            //    rightBtn.backgroundColor = [UIColor lightGrayColor];
            [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [rightBtn setTitle:_rightTitles[i] forState:UIControlStateNormal];
//            [rightBtn setImage:[UIImage imageNamed:_rightImages[i]] forState:UIControlStateNormal];
            rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            rightBtn.tag = 101+i;
            [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:rightBtn];
            [self.rightBtns addObject:rightBtn];
        }
    }
}

- (void)changeWhite {
    [self.backBtn setImage:[UIImage imageNamed:@"navigation_back"] forState:UIControlStateNormal];
    
    if (self.rightTitles.count) {
        for (UIButton *btn in self.rightBtns) {
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }else {
        
        for (NSInteger i = 0; i < self.rightBtns.count; i++) {
            UIButton *btn = self.rightBtns[i];
            [btn setImage:[UIImage imageNamed:self.rightBtnWhiteImages[i]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:self.rightBtnWhiteImages[i]] forState:UIControlStateHighlighted];
        }
    }
    
}

- (void)changeBlack {
    [self.backBtn setImage:[UIImage imageNamed:@"navigation_back_gray"] forState:UIControlStateNormal];
    //[self.rightBtn setTitleColor:kSetRGBColor(74, 74, 74) forState:UIControlStateNormal];
    if (self.rightTitles) {
        for (UIButton *btn in self.rightBtns) {
            [btn setTitleColor:kSetRGBColor(74, 74, 74) forState:UIControlStateNormal];
            [btn setTitleColor:kSetRGBColor(74, 74, 74) forState:UIControlStateHighlighted];
        }
    }else {
        
        for (NSInteger i = 0; i < self.rightBtns.count; i++) {
            UIButton *btn = self.rightBtns[i];
            [btn setImage:[UIImage imageNamed:self.rightBtnBlackImages[i]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:self.rightBtnBlackImages[i]] forState:UIControlStateHighlighted];
        }
    }
    
}

- (void)backBtnClick {
    if (self.backEventHandle) {
        self.backEventHandle(0);
    }
}

- (void)rightBtnClick:(UIButton *)btn {
    if (self.rightEventHandle) {
        self.rightEventHandle(btn.tag-101);
    }
}

@end
