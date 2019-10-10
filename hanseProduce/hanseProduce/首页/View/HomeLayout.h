//
//  HomeLayout.h
//  hanseProduce
//
//  Created by 文长林 on 2019/9/19.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol HomeViewLayoutDelegate <NSObject>

-(CGSize)boxProductCellSizeForIndexPath:(NSIndexPath*)indexpath;
-(BOOL)hasHotProducts; // 是否显示热销商品

@end
@interface HomeLayout : UICollectionViewFlowLayout
@property(nonatomic,assign)CGFloat collectionViewWidth;
// 分类cell
@property(nonatomic)UIEdgeInsets section0Inset;
@property(nonatomic,assign)CGFloat section0ItemHeight;
@property(nonatomic,assign)NSInteger sectionLineItemCount;
// 上下2张产品的推广cell
@property(nonatomic)UIEdgeInsets section1Inset;
@property(nonatomic,assign)CGFloat section1LineSpace;
@property(nonatomic,assign)CGFloat section1Row0Height;
@property(nonatomic,assign)CGFloat section1RowDefaultHeight;
// 左右3个大小不一样的推广cell
@property(nonatomic)UIEdgeInsets section2Inset;
@property(nonatomic,assign)CGFloat section2ItemHeight;
// 热销产品cell
@property(nonatomic)UIEdgeInsets section3Inset;
@property(nonatomic,assign)CGFloat section3ItemHeight;
@property(nonatomic,assign)CGFloat section3HeaderHeight;
// 产品cell
@property(nonatomic)UIEdgeInsets section4Inset;
@property(nonatomic,assign)CGFloat section4HeaderHeight;

@property(nonatomic,assign)CGFloat maxY;
@property(nonatomic,assign)CGFloat section0CellMaxY;
@property(nonatomic,assign)CGFloat section1CellMaxY;
@property(nonatomic,assign)CGFloat section2CellMaxY;
@property(nonatomic,assign)CGFloat section3CellMaxY;
@property(nonatomic,assign)CGFloat section4CellMaxY;

@property(nonatomic,assign)CGFloat section3HeaderMaxY;
@property(nonatomic,assign)CGFloat section4HeaderMaxY;
@property(nonatomic,strong)NSMutableArray<UICollectionViewLayoutAttributes*>*cellAttributes;
@property(nonatomic,strong)NSMutableArray<UICollectionViewLayoutAttributes*>*headerAttributes;
@property(nonatomic,weak)id<HomeViewLayoutDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
