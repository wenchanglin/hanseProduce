//
//  SlideTypesController.m
//  hanseProduce
//
//  Created by 文长林 on 2019/9/19.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "SlideTypesController.h"
#import "WCLCateChildsViewController.h"
#import "XXPageTabView.h"
@interface SlideTypesController ()<XXPageTabViewDelegate>
@property (nonatomic, strong) XXPageTabView *pageTabView;
@property(nonatomic,strong)NSMutableArray*cate_idArr;

@end

@implementation SlideTypesController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor=VIEW_BASE_COLOR;
    NSArray*titleArr= [[NSUserDefaults standardUserDefaults]objectForKey:@"slidertitle"];
    NSArray*idArr=[[NSUserDefaults standardUserDefaults]objectForKey:@"cateid"];
    NSMutableArray*titleArrsss=[NSMutableArray array];
    self.cate_idArr=[NSMutableArray array];
    int i=0;
    for (NSString*title in titleArr) {
        [titleArrsss addObject:title];
        [self.cate_idArr addObject:idArr[i]];
        WCLCateChildsViewController*nvc = [[WCLCateChildsViewController alloc]init];
        UINavigationController*nav = [[UINavigationController alloc]initWithRootViewController:nvc];
        nvc.cate_id = [idArr[i]integerValue];
        nvc.view.tag=nvc.cate_id;
        [self addChildViewController:nav];
        i++;
    }
    if (titleArrsss.count>0&&self.childViewControllers.count>0) {
        
        self.pageTabView = [[XXPageTabView alloc] initWithChildControllers:self.childViewControllers childTitles:titleArrsss];
        self.pageTabView.delegate = self;
        self.pageTabView.unSelectedColor = [UIColor colorWithHexString:@"#999999"];
        self.pageTabView.selectedColor = [UIColor colorWithHexString:@"#333333"];
        self.pageTabView.selectedIndiactorColor = [UIColor colorWithHexString:@"#E70014"];
        self.pageTabView.titleStyle = XXPageTabTitleStyleDefault;
        self.pageTabView.indicatorStyle = XXPageTabIndicatorStyleDefault;
        self.pageTabView.indicatorHeight=2;
        self.pageTabView.tabBackgroundColor=VIEW_BASE_COLOR;
        self.pageTabView.bodyBackgroundColor=VIEW_BASE_COLOR;
        [self.view addSubview:self.pageTabView];
        [self.pageTabView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.bottom.mas_equalTo([ShiPeiIphoneXSRMax isIPhoneX]?88:64);
        }];
    }
    
    
}
-(void)pageTabViewDidEndChange
{
    if(self.cate_idArr.count==0)
    {
        return;
    }
    else
    {
        NSInteger index= self.pageTabView.selectedTabIndex%10;
        NSString* cateid= self.cate_idArr[index];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"cateScroll" object:nil userInfo:@{@"cateid":cateid}];
    }
    
    
}
@end
