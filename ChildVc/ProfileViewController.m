//
//  ProfileViewController.m
//  HomePageDemo
//
//  Created by 郭凯 on 2017/9/29.
//  Copyright © 2017年 guokai. All rights reserved.
//

#import "ProfileViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"个人中心";
    //添加子控制器
    OneViewController *one = [[OneViewController alloc] init];
    one.title = @"个人";
    [self addChildViewController:one];
    
    TwoViewController *two = [[TwoViewController alloc] init];
    two.title = @"微博";
    [self addChildViewController:two];
    
    ThreeViewController *three = [[ThreeViewController alloc] init];
    three.title = @"相册";
    [self addChildViewController:three];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
