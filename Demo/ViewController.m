//
//  ViewController.m
//  Demo
//
//  Created by 熊伟 on 16/5/5.
//  Copyright © 2016年 TY. All rights reserved.
//

#import "ViewController.h"
#import "DemoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)push:(id)sender {
    
    DemoViewController *demo = [[DemoViewController alloc] init];
    [self.navigationController pushViewController:demo animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
