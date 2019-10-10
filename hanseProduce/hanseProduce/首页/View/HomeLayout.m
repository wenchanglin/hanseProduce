//
//  HomeLayout.m
//  hanseProduce
//
//  Created by 文长林 on 2019/9/19.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "HomeLayout.h"

@implementation HomeLayout
-(instancetype)init
{
    if (self==[super init]) {
        _collectionViewWidth=0;
        _section0Inset = UIEdgeInsetsMake(5, 0, 0, 0);
        _section0ItemHeight=91;
        _sectionLineItemCount=5;
        _section1Inset = UIEdgeInsetsMake(12, 0, 0, 0);
        _section1LineSpace=8;
        _section1Row0Height=75;
        _section1RowDefaultHeight=120;
        _section2Inset = UIEdgeInsetsMake(8, 0, 0, 0);
        _section2ItemHeight=208;
        _section3Inset = UIEdgeInsetsMake(0, 16, 0, 16);
        _section3ItemHeight=278;
        _section3HeaderHeight=50;
        _section4Inset = UIEdgeInsetsMake(0, 0, 5, 0);
        _section4HeaderHeight=50;
        _maxY=0;
        _section0CellMaxY=0;
        _section1CellMaxY=0;
        _section2CellMaxY=0;
        _section3CellMaxY=0;
        _section4CellMaxY=0;
        _section3HeaderMaxY=0;
        _section4HeaderMaxY=0;
        
    }
    return self;
}
-(void)prepareLayout
{
    [super prepareLayout];
    UICollectionView*c = [[UICollectionView alloc]init];
    NSInteger num = c.numberOfSections;
    if (num==5) {
        _collectionViewWidth=c.frame.size.width;
        for (int i=0;i<num;i++) {
            UICollectionViewLayoutAttributes*ha = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:i]];
            [_headerAttributes addObject:ha];
            [self attributesInView:c atSection:i];
        }
        
    }
    else
    {
        NSAssert(num<5,@"首页sections num 必须为5");
        return;
    }
}
-(CGSize)collectionViewContentSize
{
    return CGSizeMake(_collectionViewWidth, _maxY);
}
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            UICollectionViewLayoutAttributes*attr =[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            CGFloat w=(_collectionViewWidth - _section0Inset.left - _section0Inset.right) / (_sectionLineItemCount);
            CGFloat x = _section0Inset.left + w * (indexPath.item % _sectionLineItemCount);
            CGFloat y = _section0Inset.top + _section0ItemHeight * (indexPath.item / _sectionLineItemCount);
            attr.frame = CGRectMake(x, y, w, _section0ItemHeight);
            _section0CellMaxY = MAX(_section0CellMaxY, y + _section0ItemHeight + _section0Inset.bottom);
            _section1CellMaxY = MAX(_section1CellMaxY, _section0CellMaxY);
            _section2CellMaxY = MAX(_section2CellMaxY, _section1CellMaxY);
            _section3HeaderMaxY = MAX(_section2CellMaxY, _section3HeaderMaxY);
            _section3CellMaxY = MAX(_section3CellMaxY, _section3HeaderMaxY);
            _section4HeaderMaxY = MAX(_section3CellMaxY, _section4HeaderMaxY);
            _section4CellMaxY = MAX(_section4CellMaxY, _section4HeaderMaxY);
            _maxY = MAX(_maxY, _section4CellMaxY);
            return attr;
        }
            break;
        case 1: // 横向一个商品图一个cell
        {
            UICollectionViewLayoutAttributes*attr =[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            CGFloat y;
            CGFloat h;
            if(indexPath.row == 0){
                y =_section0CellMaxY + _section1Inset.top;
                h = _section1Row0Height;
            } else {
                h = _section1RowDefaultHeight;
                y = _section0CellMaxY + _section1Inset.top + _section1Row0Height + _section1LineSpace * indexPath.row + _section1RowDefaultHeight * (indexPath.row - 1);
            }
            attr.frame = CGRectMake(_section1Inset.left, y, _collectionViewWidth - _section1Inset.left - _section1Inset.right, h);
            _section1CellMaxY = MAX(_section1CellMaxY, y + h + _section1Inset.bottom);
            _section2CellMaxY = MAX(_section2CellMaxY, _section1CellMaxY);
            _section3HeaderMaxY = MAX(_section2CellMaxY, _section3HeaderMaxY);
            _section3CellMaxY = MAX(_section3CellMaxY, _section3HeaderMaxY);
            _section4HeaderMaxY = MAX(_section3CellMaxY, _section4HeaderMaxY);
            _section4CellMaxY = MAX(_section4CellMaxY, _section4HeaderMaxY);
            _maxY = MAX(_maxY, _section4CellMaxY);
            return attr;
        }break;
        case 2: // 3张推广图在一个cell
        {
            UICollectionViewLayoutAttributes*attr =[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            CGFloat y = _section1CellMaxY + _section2Inset.top + _section2ItemHeight * (indexPath.item);
            attr.frame = CGRectMake(_section2Inset.left, y, _collectionViewWidth - _section2Inset.left - _section3Inset.right, _section2ItemHeight);
            _section2CellMaxY = MAX(_section2CellMaxY, y + _section2ItemHeight + _section2Inset.bottom);
            _section3HeaderMaxY = MAX(_section2CellMaxY, _section3HeaderMaxY);
            _section4HeaderMaxY = MAX(_section4CellMaxY, _section4HeaderMaxY);
            _section4CellMaxY = MAX(_section4CellMaxY, _section4HeaderMaxY);
            _maxY = MAX(_maxY, _section4CellMaxY);
            return attr;
        }
            break;
        case 3:{//热销商品
            UICollectionViewLayoutAttributes*attr =[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            CGFloat y = _section3HeaderMaxY + _section3Inset.top + _section3ItemHeight * (indexPath.item);
            attr.frame = CGRectMake(_section3Inset.left, y, _collectionViewWidth - _section3Inset.left - _section3Inset.right, _section3ItemHeight);
            _section3CellMaxY = MAX(_section3CellMaxY, y + _section3ItemHeight + _section3Inset.bottom);
            _section4HeaderMaxY = MAX(_section3CellMaxY, _section4HeaderMaxY);
            _section4CellMaxY = MAX(_section4CellMaxY, _section4HeaderMaxY);
            _maxY = MAX(_maxY, _section4CellMaxY);
            return attr;
        }break;
        case 4://商品主会场
        {
            CGSize size = [self.delegate boxProductCellSizeForIndexPath:indexPath];
            CGFloat x, y;
            if(indexPath.item <= 1){
                y = _section4HeaderMaxY + _section4Inset.top;
                x = 16 + (indexPath.item % 2) * (size.width + 9);
            } else {
                let sortedAttrs = cellAttributes.filter { $0.indexPath.section == indexPath.section }.sorted { (a1, a2) -> Bool in
                    if (a1.frame.maxY != a2.frame.maxY) {
                        return a1.frame.maxY > a2.frame.maxY
                    }
                    return a1.frame.minX > a2.frame.minX
                }
                let minYAttr = sortedAttrs[1]
                x = minYAttr.frame.minX
                y = minYAttr.frame.maxY + Product.Layout.verticalSpace
            }
            let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attr.frame = CGRect(x: x, y: y, width: size.width, height: size.height)
            section4CellMaxY = max(section4CellMaxY, y + size.height)
            maxY = max(maxY, section4CellMaxY + section4Inset.bottom)
            return attr
        }
        break;
        default:
            return nil;
            break;
    }
}
-(void)attributesInView:(UICollectionView*)view atSection:(NSInteger)section{
    NSInteger items =[view numberOfItemsInSection:section];
    for (int i=0; i<items; i++) {
        NSIndexPath* ip = [NSIndexPath indexPathForItem:i inSection:section];
        UICollectionViewLayoutAttributes*cas = [self layoutAttributesForItemAtIndexPath:ip];
        if (cas!=nil) {
            [_cellAttributes addObject:cas];
        }
    }
}
-(UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if (elementKind==UICollectionElementKindSectionFooter ) {
        return nil;
    }
    if (indexPath.section==3) {
        UICollectionViewLayoutAttributes*att= [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        CGFloat h = [self.delegate hasHotProducts]?50:0;
        att.frame=CGRectMake(0, _section2CellMaxY, _collectionViewWidth, h);
        att.hidden=[self.delegate hasHotProducts]?YES:NO;
        _section3HeaderMaxY = _section2CellMaxY+h;
        _section3CellMaxY=_section3HeaderMaxY;
        _section4HeaderMaxY=_section3HeaderMaxY;
        _section4CellMaxY=_section3HeaderMaxY;
        _maxY=MAX(_maxY, _section4CellMaxY);
        return att;
    }
    else if (indexPath.section==4)
    {
        UICollectionViewLayoutAttributes*att= [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        att.frame=CGRectMake(0, _section3CellMaxY, _collectionViewWidth, _section4HeaderHeight);
        _section4HeaderMaxY=_section3CellMaxY+_section4HeaderHeight;
        _section4CellMaxY=_section4HeaderMaxY;
        _maxY=MAX(_maxY, _section4CellMaxY);
        return att;
    }
    return nil;
}
@end
