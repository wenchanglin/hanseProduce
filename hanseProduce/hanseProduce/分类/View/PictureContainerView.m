//
//  PictureContainerView.m
//  AiYaoLe
//
//  Created by sks on 2017/6/22.
//  Copyright © 2017年 sks. All rights reserved.
//

#import "PictureContainerView.h"
#import "SDPhotoBrowser.h"

@interface PictureContainerView ()<SDPhotoBrowserDelegate>

@property(nonatomic,strong) NSMutableArray *imageViewsArray;

@end

static CGFloat const photoMaxWidth = 120.f;
static CGFloat const photoMaxHeight = 240.f;

@implementation PictureContainerView

- (instancetype)init{

    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<9; i++) {
        UIImageView *imageView = [UIImageView new];
        imageView.tag = i;
        [self addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.userInteractionEnabled = YES;
        imageView.clipsToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(imageViewHasClick:)];
        [imageView addGestureRecognizer:tap];
        [temp addObject:imageView];
    }
    self.imageViewsArray = [temp copy];
}

- (void)setPicArray:(NSMutableArray *)picArray {
    
    _picArray = picArray;
    
    if (picArray.count>9) {
        
        _picArray = [picArray subarrayWithRange:NSMakeRange(0, 9)];
        
    }
    
    for (long i = _picArray.count; i<_imageViewsArray.count; i++) {
        UIImageView *imageView = [_imageViewsArray objectAtIndex:i];
        imageView.hidden = YES;
    }
    
    if (self.picArray.count == 0) {
        self.height = 0;
        self.fixedHeight = @(0);
        return;
    }
    
    CGSize itemSize = [self imageItemWidthWithImage:self.picArray];
    CGFloat itemWidth = itemSize.width;
    CGFloat itemHeight = itemSize.height;
    
    long perRowItemCount = [self perRowImageCountWithTotalImageCount:self.picArray.count];
    CGFloat margin = 5.f;
    [self.picArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx>8) {
            
        }
        
        long rowIndex = idx / perRowItemCount;
        long columnIndex = idx % perRowItemCount;
        
        UIImageView *imageView = [self.imageViewsArray objectAtIndex:idx];
        imageView.frame = CGRectMake(columnIndex * (itemWidth + margin), rowIndex * (itemHeight+margin), itemWidth, itemHeight);
        imageView.hidden = NO;
                
        if ([obj isKindOfClass:[NSString class]]) {
            [imageView showImgUrl:obj placeholder:DZImageNamed(@"loading_image2")];
        }else if ([obj isKindOfClass:[UIImage class]]){
            imageView.image = obj;
        }else{
        }
    }];
    
    // 计算图片容器视图的大小 
    CGFloat w = perRowItemCount * itemWidth + margin * (perRowItemCount - 1);
    int rowCount = ceilf(_picArray.count * 1.0 / perRowItemCount);
    CGFloat h = rowCount * itemHeight + (rowCount - 1) * margin;
    self.height = h;
    self.width = w;
    self.fixedWidth = @(w);
    self.fixedHeight = @(h);
}

//图片的宽度
- (CGSize)imageItemWidthWithImage:(NSArray *)images{
    
//    NSInteger count = images.count;
    CGFloat width = 0;
    CGFloat height = 0;
//    if (count == 1) {
//
//
//        width = photoMaxWidth;
//        height = photoMaxHeight;
//
//        return CGSizeMake(width, height);
//    }else {
//        height = width = [UIScreen mainScreen].bounds.size.width > 320 ? 80 : 70;
//        return CGSizeMake(width, height);
//    }
    height = width = [UIScreen mainScreen].bounds.size.width > 320 ? 80 : 70;
    return CGSizeMake(width, height);
}

// 每行的图片数量
- (NSInteger)perRowImageCountWithTotalImageCount:(long) count {
    
    if (count <=3) {
        return count;
    }else if (count <= 4){
        return 2;
    }else{
        return 3;
    }
    
}


- (void)imageViewHasClick:(UITapGestureRecognizer *) tap{
    
    UIImageView *imageView = (UIImageView *)tap.view;
    SDPhotoBrowser *photoBrowser = [[SDPhotoBrowser alloc] init];
    photoBrowser.currentImageIndex = imageView.tag;
    photoBrowser.sourceImagesContainerView = self;
    photoBrowser.imageCount = self.picArray.count;
    photoBrowser.delegate = self;
    [photoBrowser show];
}


- (UIImage *) photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    
    UIImageView *imageView = [self.imageViewsArray objectAtIndex:index];
    return imageView.image;
}

- (NSURL *) photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index{
    
//    NSString *imagePath = [(DiaryPhotoModel *)[self.picArray objectAtIndex:index] pic];
//    imagePath = [imagePath stringByReplacingOccurrencesOfString:@"_thumb" withString:@""];
//    NSURL *url = [NSURL URLWithString:imagePath];
//    return url;
    return nil;
}



#pragma mark - 懒加载
- (NSMutableArray *)imageViewsArray {
    
    if (!_imageViewsArray) {
        _imageViewsArray = [[NSMutableArray alloc] init];
    }
    return _imageViewsArray;
}



@end
