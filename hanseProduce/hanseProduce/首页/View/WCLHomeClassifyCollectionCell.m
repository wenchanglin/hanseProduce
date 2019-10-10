//
//  WCLHomeClassifyCollectionCell.m
//  hanseProduce
//
//  Created by 文长林 on 2019/9/23.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "WCLHomeClassifyCollectionCell.h"
#import "WCLHomeClassifyTwoCell.h"
@implementation WCLHomeClassifyCollectionCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame]) {
        [self.collectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];

    }
    return self;
}
-(UICollectionView *)collectView
{
    if (!_collectView) {
        UICollectionViewFlowLayout*flow=[[UICollectionViewFlowLayout alloc]init];
        [flow setScrollDirection:UICollectionViewScrollDirectionVertical];
        flow.minimumLineSpacing = 0;
        _collectView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flow];
        _collectView.delegate=self;
        _collectView.dataSource=self;
        _collectView.backgroundColor=[UIColor colorWithHexString:@"#F6F6F6"];
        [_collectView registerClass:[WCLHomeClassifyTwoCell class] forCellWithReuseIdentifier:@"WCLHomeClassifyTwoCell"];
        [self addSubview:_collectView];
    }
    return _collectView;
}
-(void)setBtnArr:(NSMutableArray *)btnArr
{
    _btnArr=btnArr;
    [self.collectView reloadData];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _btnArr.count;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WCLHomeClassifyModel *deModel = _btnArr[indexPath.item];
    WCLHomeClassifyTwoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WCLHomeClassifyTwoCell" forIndexPath:indexPath];
    cell.models=deModel;
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH/5, 168/2);//168/2
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WCLHomeClassifyModel *deModel = _btnArr[indexPath.item];
    self.moreBtnClickBlock(deModel);
}

@end
