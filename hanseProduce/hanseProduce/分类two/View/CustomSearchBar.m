//
//  CustomSearchBar.m
//  BaseProject
//
//  Created by 郑桂杰 on 2019/9/27.
//  Copyright © 2019 Sunsgne. All rights reserved.
//

#import "CustomSearchBar.h"

@interface CustomSearchBar ()<UISearchBarDelegate>

@end

@implementation CustomSearchBar

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.placeholder = @"搜索商品";
        self.delegate = self;
        UITextField *tf = (UITextField *)[self valueForKey:@"searchField"];
        if (tf) {
            tf.height = 25;
            tf.font = kRegularFont(YBLWidth_Scale*(16));
            tf.backgroundColor = [UIColor magentaColor];//UIColor.e;
            tf.layer.cornerRadius = tf.height * 0.5;
            tf.layer.masksToBounds = true;
        }
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
   
}

#pragma mark - UISearchBarDelegate

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    if (self.beingEditing) {
        self.beingEditing();
        return false;
    }
    return true;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar endEditing:true];
    NSString *t = searchBar.text;
    if (self.searchContent && t) {
        self.searchContent(t);
    }
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar endEditing:true];
    if (self.cancelSearch) {
        self.cancelSearch();
    }
}

@end
