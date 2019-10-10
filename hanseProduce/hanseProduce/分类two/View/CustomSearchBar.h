//
//  CustomSearchBar.h
//  BaseProject
//
//  Created by 郑桂杰 on 2019/9/27.
//  Copyright © 2019 Sunsgne. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CustomSearchBarBlock)(void);
typedef void(^CustomSearchBarTextBlock)(NSString* _Nullable nonnull);

NS_ASSUME_NONNULL_BEGIN
@interface CustomSearchBar : UISearchBar
@property(nonatomic, copy, nullable) CustomSearchBarBlock beingEditing;
@property(nonatomic, copy, nullable) CustomSearchBarBlock cancelSearch;
@property(nonatomic, copy, nullable) CustomSearchBarTextBlock searchContent;
@end

NS_ASSUME_NONNULL_END
