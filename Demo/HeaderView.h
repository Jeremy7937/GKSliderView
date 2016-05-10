//
//  HeaderView.h
//  Demo
//
//  Created by 熊伟 on 16/5/5.
//  Copyright © 2016年 TY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PopVcBlock)();

@interface HeaderView : UIView

@property (nonatomic, copy)PopVcBlock block;

@end
