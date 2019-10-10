//
//  WCLCateCollectionView.m
//  hanseProduce
//
//  Created by 文长林 on 2019/9/27.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "WCLCateCollectionView.h"
#import "WCLHomeThemeCollectionCell.h"
@implementation WCLCateCollectionView
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self==[super initWithFrame:frame collectionViewLayout:layout]) {
        self.backgroundColor=VIEW_BASE_COLOR;
        self.dataSource=self;
        self.delegate=self;
        [self registerClass:[WCLHomeThemeCollectionCell class] forCellWithReuseIdentifier:@"WCLCateThemeCollectionCell"];
    }
    return self;
}
-(void)setCateDataArr:(NSMutableArray *)cateDataArr
{
    _cateDataArr=cateDataArr;
    [self reloadData];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _cateDataArr.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WCLHomeThemeModel *deModel = _cateDataArr[indexPath.item];
    WCLHomeThemeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WCLCateThemeCollectionCell" forIndexPath:indexPath];
    cell.model=deModel;
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH/2-5, 282);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WCLHomeThemeModel *deModel = _cateDataArr[indexPath.item];
    self.cateSelectItemBlock(deModel);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
