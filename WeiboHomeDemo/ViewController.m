//
//  ViewController.m
//  WeiboHomeDemo
//
//  Created by 郭凯 on 2017/6/14.
//  Copyright © 2017年 郭凯. All rights reserved.
//

#import "ViewController.h"
#import "HZSliderViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)push:(id)sender {
    HZSliderViewController *sliderVC = [[HZSliderViewController alloc] init];
    [self.navigationController pushViewController:sliderVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
