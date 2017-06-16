//
//  BaseTableViewController.h
//  WeiboHomeDemo
//
//  Created by 郭凯 on 2017/6/15.
//  Copyright © 2017年 郭凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseTableViewControllerDelegate <NSObject>

- (void)tableViewDidScroll:(UIScrollView *)tableView;

@end

@interface BaseTableViewController : UITableViewController

@property (nonatomic, weak) id<BaseTableViewControllerDelegate>delegate;

@end
