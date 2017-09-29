//
//  GKHomePageTableViewController.h
//  微博个人主页
//
//  Created by 郭凯 on 2017/9/29.
//  Copyright © 2017年 guokai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSSegmentTitleView.h"

@interface GKHomePageTableViewController : UITableViewController

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) FSSegmentTitleView *sectionBar;
@property (nonatomic, strong) UIView *gradentView;

@end
