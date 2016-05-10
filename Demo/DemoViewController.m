//
//  DemoViewController.m
//  Demo
//
//  Created by 熊伟 on 16/5/5.
//  Copyright © 2016年 TY. All rights reserved.
//

#import "DemoViewController.h"
#import "HeaderView.h"
#import "GKSliderView.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"

#define kScreenSize [UIScreen mainScreen].bounds.size

@interface DemoViewController ()

@property (nonatomic, strong)HeaderView *headerView;
@property (nonatomic, strong)GKSliderView *sliderView;

@end

@implementation DemoViewController
{
    CGFloat _headerY;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpHeaderView];
    [self setUpSliderView];
}

- (void)setUpHeaderView {
    self.headerView = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil] lastObject];
    self.headerView.frame = CGRectMake(0, 0, kScreenSize.width, 250);
    
    __weak DemoViewController *weakSelf = self;
    
    self.headerView.block = ^(){
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    [self.view addSubview:self.headerView];
    
}

- (void)setUpSliderView {
    NSArray *titleArr = @[@"体检报告",@"照片病例",@"健康咨询",@"日常体征"];
    OneViewController *one = [[OneViewController alloc] init];
    one.scrolBlock = ^(CGPoint point) {
        [self changeFrameWithPoint:point];
    };

    TwoViewController *two = [[TwoViewController alloc] init];
    two.scrolBlock = ^(CGPoint point) {
        [self changeFrameWithPoint:point];
    };
    
    ThirdViewController *three = [[ThirdViewController alloc] init];
    three.scrolBlock = ^(CGPoint point) {
        [self changeFrameWithPoint:point];
    };
    
    FourthViewController *fourth = [[FourthViewController alloc] init];
    fourth.scrolBlock = ^(CGPoint point) {
        [self changeFrameWithPoint:point];
    };

    NSArray *controller = @[one,two,three,fourth];
    self.sliderView = [[GKSliderView alloc] initWithFrame:CGRectMake(0, 250, kScreenSize.width, kScreenSize.height - 250) titleArr:titleArr controllerNameArr:controller];
    
    __weak DemoViewController *weakSelf = self;
    self.sliderView.resetBlock = ^(){
        weakSelf.headerView.frame = CGRectMake(0, 0, kScreenSize.width, 250);
        weakSelf.sliderView.frame = CGRectMake(0, 250, kScreenSize.width, kScreenSize.height - 250);
        one.tableView.contentOffset = CGPointMake(0, 0);
        two.tableView.contentOffset = CGPointMake(0, 0);
        three.tableView.contentOffset = CGPointMake(0, 0);
        fourth.tableView.contentOffset = CGPointMake(0, 0);
    };
    
    [self.view addSubview:self.sliderView];
}


- (void)changeFrameWithPoint:(CGPoint )point {
   // point = CGPointMake(0, 0);
    if (point.y <= 186) {
        CGRect headerFrame = self.headerView.frame;
        headerFrame.origin.y = -point.y;
        self.headerView.frame = headerFrame;
        
        CGRect sliderFrame = self.sliderView.frame;
        sliderFrame.origin.y = 250 - point.y;
        sliderFrame.size.height = kScreenSize.height - sliderFrame.origin.y;
        self.sliderView.frame = sliderFrame;
    }else {
        self.headerView.frame = CGRectMake(0, -187, kScreenSize.width, 250);
        self.sliderView.frame = CGRectMake(0, 64, kScreenSize.width, kScreenSize.height - 64);
    }
    
}


#pragma mark -- 显示和隐藏导航栏
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
