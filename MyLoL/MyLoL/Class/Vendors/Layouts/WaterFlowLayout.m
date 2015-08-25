//
//  WaterFlowLayout.m
//  瀑布流
//
//  Created by lanouhn on 15/5/22.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "WaterFlowLayout.h"

@interface WaterFlowLayout ()
//集合视图中item的个数
@property (nonatomic, assign) NSUInteger numberOfItems;
//item之间的间距
@property (nonatomic, assign) CGFloat interItemSpacing;
//保存每一列的高度的数组
@property (nonatomic, retain) NSMutableArray *columnHeights;
//保存最终计算得到的每一个item的Attribute的数组
@property (nonatomic, retain) NSMutableArray *itemAttributes;

//返回columnHeights数组中的最短高度列的下标
- (NSInteger) _shortestColumnIndex;

//返回columnHeights数组中的最高 高度列的下标
- (NSInteger) _longestColumnIndex;

//计算每一个item的frame
- (void) _calcluateItemFrame;
@end

@implementation WaterFlowLayout
- (NSMutableArray *)columnHeights{
    if (!_columnHeights) {
        self.columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

- (NSMutableArray *)itemAttributes{
    if (!_itemAttributes) {
        self.itemAttributes = [NSMutableArray array];
    }
    return _itemAttributes;
}

- (NSInteger)_shortestColumnIndex{
    //记录最短高度列的下标
    NSInteger index = 0;

    //记录最短列的高度，并设置初始值为最大数
    CGFloat shortestHeight = CGFLOAT_MAX;

    for (int i = 0; i < self.columnHeights.count; i++) {

        //记录当前列的高度
        CGFloat currentHeight = [self.columnHeights[i] floatValue];
        if (shortestHeight > currentHeight) {
            //记录下当前列的高度
            shortestHeight = currentHeight;
            //记录下当前列的下标
            index = i;
        }
    }
    return index;
}

- (NSInteger)_longestColumnIndex{
    //记录最高高度列的下标
    NSInteger index = 0;
    //记录最高高度列的高度
    CGFloat longestHeight = CGFLOAT_MIN;
    for (int i  = 0; i < self.columnHeights.count; i++) {
        //记录当前列的高度
        CGFloat currentHeight = [self.columnHeights[i] floatValue];
        if (longestHeight < currentHeight) {
            //记录最高列的高度
            longestHeight =  currentHeight;
            //记录最高高度列的下标
            index = i;
        }
    }
    return index;
}


- (void)prepareLayout{
    [super prepareLayout];
    //一旦布局对象交给集合视图后，布局对象就会调用自己的prepareLayout方法计算布局
    [self _calcluateItemFrame];
}
- (void)_calcluateItemFrame{
    //通过集合视图对象获得当前集合视图对应分区中item的个数
    self.numberOfItems = [self.collectionView numberOfItemsInSection:0];

    //获取collectionView的有效宽度
    CGFloat contentWidth = CGRectGetWidth(self.collectionView.frame) - self.sectionInset.right - self.sectionInset.left;

    //计算item之间的列间距
    self.interItemSpacing = (contentWidth - self.itemWidth * self.numberOfColumns) / (self.numberOfColumns - 1);

    //保存两列的初始高度
    for (int i = 0; i < self.numberOfColumns; i++) {
        self.columnHeights[i] = @(self.sectionInset.top);
    }

    //根据collectionView所管理的item的数量产生循环，每一次循环计算当前item的frame
    for (int i = 0; i < self.numberOfItems; i++) {
        //为每一个item对象创建对应的indexPath对象
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];

        //通过代理对象的协议方法获取当前的item的高度
        CGFloat itemHeight = 0;
        if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:waterFlowLayout:heightForItemAtIndexPath:)]) {
            itemHeight = [self.delegate collectionView:self.collectionView waterFlowLayout:self heightForItemAtIndexPath:indexPath];
        }

        //获取当前最短列在columnHeights数组中的下标
        NSInteger shortestIndex = [self _shortestColumnIndex];

        //计算当前item的x轴坐标和y轴坐标
        CGFloat origin_x = self.sectionInset.left + (self.itemWidth + self.interItemSpacing) * shortestIndex;
        CGFloat origin_y = [self.columnHeights[shortestIndex] floatValue];

        //根据indexPath创建布局属性对象
        UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

        //设置布局属性对象的frame的值
        layoutAttributes.frame = CGRectMake(origin_x, origin_y, self.itemWidth, itemHeight);

        //向保存item的布局属性数组中添加最终计算出frame大小的布局属性对象
        [self.itemAttributes addObject:layoutAttributes];

        //更新columnHeights数组中的当前的最短列的高度
        self.columnHeights[shortestIndex] = @(origin_y + itemHeight + self.interItemSpacing);
    }
}

//设置文本显示区域的size(大小)的协议方法
- (CGSize)collectionViewContentSize{
    //获取集合视图的size大小
    CGSize contentSize = self.collectionView.frame.size;

    //获取最长列的下标
    NSInteger longestIndex = [self _longestColumnIndex];

    //根据最长列在数组中的高度
    CGFloat longestHeight = [self.columnHeights[longestIndex] floatValue];
    //根据最长列的高度设置内容的高度
    contentSize.height = longestHeight - self.interItemSpacing + self.sectionInset.bottom;
    return contentSize;
}

//为每一个item设置布局属性对象
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.itemAttributes[indexPath.item];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.itemAttributes;
}
@end
