//
//  WCLHomeHotDataCell.m
//  hanseProduce
//
//  Created by 文长林 on 2019/9/24.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "WCLHomeHotDataCell.h"
#import "WCLHotDataTwoLevelCell.h"
#import "WCLHotDataModel.h"
@implementation WCLHomeHotDataCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame]) {
        [self setupLayout];
    }
    return self;
}
-(void)setupLayout{
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(12);
        make.right.bottom.mas_equalTo(-12);
    }];
    [self.backView layoutIfNeeded];
    [self.backView addCornerRadius:6 rectCorner:UIRectCornerAllCorners];
    
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.backView);
        make.height.mas_equalTo(YBLWidth_Scale*100);
    }];
    [self.titleImageView layoutIfNeeded];
    [self.titleImageView addCornerRadius:6 rectCorner:UIRectCornerAllCorners];

    [self.collectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleImageView.mas_bottom).offset(5);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(YBLWidth_Scale*320);
    }];
}
-(void)setHotDataArr:(NSMutableArray *)hotDataArr
{
    _hotDataArr=hotDataArr;
    [self.collectView reloadData];
}
-(UICollectionView *)collectView
{
    if (!_collectView) {
        UICollectionViewFlowLayout*flow=[[UICollectionViewFlowLayout alloc]init];
        [flow setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        flow.minimumLineSpacing = 0;
        _collectView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flow];
        _collectView.delegate=self;
        _collectView.dataSource=self;
        _collectView.backgroundColor=[UIColor colorWithHexString:@"#F6F6F6"];
        [_collectView registerClass:[WCLHotDataTwoLevelCell class] forCellWithReuseIdentifier:@"WCLHotDataTwoLevelCell"];
        [self.backView addSubview:_collectView];
    }
    return _collectView;
}
-(UIImageView *)backView
{
    if (!_backView) {
        _backView= [UIImageView new];
        _backView.contentMode=UIViewContentModeScaleAspectFit;
        _backView.backgroundColor=[UIColor whiteColor];
        _backView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.08].CGColor;
        _backView.layer.shadowOffset = CGSizeMake(0,0);
        _backView.layer.shadowRadius = 6;
        _backView.userInteractionEnabled=YES;
        _backView.layer.shadowOpacity = 1;
        [self addSubview:_backView];
    }
    return _backView;
}
-(UIImageView *)titleImageView
{
    if (!_titleImageView) {
        _titleImageView= [UIImageView new];
        _titleImageView.contentMode=UIViewContentModeScaleAspectFill;
        [self.backView addSubview:_titleImageView];
    }
    return _titleImageView;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _hotDataArr.count;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WCLHotDataModel *deModel = _hotDataArr[indexPath.item];
    WCLHotDataTwoLevelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WCLHotDataTwoLevelCell" forIndexPath:indexPath];
    cell.model=deModel;
    cell.NoLabel.text = [NSString stringWithFormat:@"NO.%@",@(indexPath.item+1)];
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH/2, YBLWidth_Scale*300);
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
    //    WCLGoodsModel *model =_goodSpecialArr[indexPath.item];
    //    self.goodSpecailBlock(model);
}
@end
