//
//  GKSliderView.m
//  Demo
//
//  Created by 郭凯 on 16/5/5.
//  Copyright © 2016年 TY. All rights reserved.
//

#import "GKSliderView.h"
#define kScreenSize [UIScreen mainScreen].bounds.size
#define kTabBarHeight 60
#define kItemWidth 60
#define kItemHeight 54
#import <AFNetworking.h>

//#define kItemSpace (kScreenSize.width - kItemWidth *itemCount)/(itemCount +1)

@interface GKSliderView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)NSArray *titleArr;
@property (nonatomic, strong)NSArray *controllerArr;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)UIView *tabBar;//
@property (nonatomic, strong)UIView *sliderView; //滑块
@end

@implementation GKSliderView

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr controllerNameArr:(NSArray *)nameArr {
    
    if (self = [super initWithFrame:frame]) {
        
        self.titleArr = titleArr;
        self.controllerArr = nameArr;
        [self setUpTabBar];
        
        [self setUpCollectionView];
    }
    
    return self;
}

//创建滑动头部滑动视图
- (void)setUpTabBar {
    self.tabBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kTabBarHeight)];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    UIImageView *bgImageView =[[UIImageView alloc] initWithFrame:self.tabBar.bounds];
    bgImageView.image = [UIImage imageNamed:@"tabbarBk"];
    [self.tabBar addSubview:bgImageView];
    
    NSInteger itemCount = self.titleArr.count;
    //每个item之间的间距
    CGFloat itemSpace = (kScreenSize.width - kItemWidth *itemCount)/(itemCount +1);
    
    //循环添加tabBar上的View
    for (NSInteger index = 0; index < self.titleArr.count; index++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(itemSpace*(index+1) + kItemWidth*index, 3, kItemWidth, kItemHeight)];
      //  view.backgroundColor = [UIColor redColor];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kItemWidth/2 - 15, 2, 30, 30)];
        imageView.image = [UIImage imageNamed:@"goodsNew"];
        [view addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, kItemHeight - 22, 60, 20)];
        label.text = self.titleArr[index];
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        
        [self.tabBar addSubview:view];
    }
    
    //添加滑块
    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(itemSpace, kItemHeight, kItemWidth, 2)];
    self.sliderView.backgroundColor = [UIColor redColor];
    [self.tabBar addSubview:self.sliderView];

    [self addSubview:self.tabBar];
}

//创建collectionView
- (void)setUpCollectionView {
//    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kTabBarHeight, kScreenSize.width, self.bounds.size.height - kTabBarHeight)];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(kScreenSize.width, kScreenSize.height);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kTabBarHeight, kScreenSize.width, kScreenSize.height) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self addSubview:self.collectionView];
    self.collectionView.pagingEnabled = YES;
   // self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.bounces = NO;
   // self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CellId"];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / kScreenSize.width;
    [self selectedIndex:index];
    
    if (self.resetBlock) {
        self.resetBlock();
    }
}

- (void)selectedIndex:(NSInteger)index {
    NSInteger itemCount = self.titleArr.count;
    //每个item之间的间距
    CGFloat itemSpace = (kScreenSize.width - kItemWidth *itemCount)/(itemCount +1);
    
    CGFloat x = index*(itemSpace + kItemWidth) + itemSpace;
    [UIView animateWithDuration:0.3 animations:^{
       
        self.sliderView.frame = CGRectMake(x, kItemHeight, kItemWidth, 2);
    }];
}
#pragma mark -- UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleArr.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellId" forIndexPath:indexPath];
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIViewController *ViewController = self.controllerArr[indexPath.item];
   // ViewController.view.frame = CGRectMake(0, 0, kScreenSize.width, self.bounds.size.height - kTabBarHeight);
    [cell.contentView addSubview:ViewController.view];
    return cell;
    
}
@end
