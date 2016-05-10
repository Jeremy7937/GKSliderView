//
//  HeaderView.m
//  Demo
//
//  Created by 熊伟 on 16/5/5.
//  Copyright © 2016年 TY. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView


- (IBAction)backBtnClick:(id)sender {
    
    if (self.block) {
        self.block();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
