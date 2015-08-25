//
//  WaterFlowLayout.h
//  WaterFlowDemo
//
//  Created by lanouhn on 15/5/19.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterFlowLayout;
//声明扩展协议，扩展自UICollectionViewDelegate协议
@protocol waterFlowLayoutDelegate<UICollectionViewDelegate>
//定义协议方法，并返回每一个item的最终高度
- (CGFloat) collectionView:(UICollectionView *)collectionView
           waterFlowLayout:(WaterFlowLayout *) waterFlowLayout
  heightForItemAtIndexPath:(NSIndexPath *) indexPath;
@end

@interface WaterFlowLayout : UICollectionViewLayout
@property (nonatomic, assign) id<waterFlowLayoutDelegate> delegate;
@property (nonatomic, assign) NSUInteger numberOfColumns;//瀑布流的列数
@property (nonatomic, assign) CGFloat itemWidth;//每一个item的宽度
@property (nonatomic, assign) UIEdgeInsets sectionInset;//集合视图分区的内边距
@end
