//
//  OneViewController.h
//  Demo
//
//  Created by 郭凯 on 16/5/5.
//  Copyright © 2016年 TY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TableViewScrollBlock)(CGPoint point);
typedef void(^TableViewDidEndScrollBlock)(CGPoint point);

@interface OneViewController : UIViewController

@property (nonatomic, copy)TableViewScrollBlock scrolBlock;
@property (nonatomic, copy)TableViewDidEndScrollBlock didEndBlock;
@property (nonatomic, strong)UITableView *tableView;

@end
