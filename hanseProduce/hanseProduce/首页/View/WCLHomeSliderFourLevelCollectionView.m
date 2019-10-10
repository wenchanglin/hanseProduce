//
//  WCLHomeSliderFourLevelCollectionView.m
//  hanseProduce
//
//  Created by 文长林 on 2019/9/26.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "WCLHomeSliderFourLevelCollectionView.h"
#import "WCLHomeCateListLevelCell.h"
static NSString * const reuseIdentifier = @"Cell";

@implementation WCLHomeSliderFourLevelCollectionView
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self==[super initWithFrame:frame collectionViewLayout:layout]) {
        self.scrollEnabled=NO;
        self.backgroundColor=VIEW_BASE_COLOR;
        self.dataSource=self;
        self.delegate=self;
        [self registerClass:[WCLHomeCateListLevelCell class] forCellWithReuseIdentifier:reuseIdentifier];

    }
    return self;
}
-(void)setDataArr:(NSMutableArray *)dataArr
{
    _dataArr=dataArr;
    WCLLog(@"%@",dataArr);
    [self reloadData];
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WCLHomeCateListLevelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH/2, 282);
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
