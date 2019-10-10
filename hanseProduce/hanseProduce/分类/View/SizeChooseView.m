//
//  SizeChooseView.m
//  DZProject
//
//  Created by Sunsgne on 2018/4/8.
//  Copyright © 2018年 Sunsgne. All rights reserved.
//

#import "SizeChooseView.h"
#import "CountChangeView.h"
#import "DWQSelectAttributes.h"
#import "UIButton+DZButton.h"
 
@interface SizeChooseView()
{
    UIImageView *_goodImg;
    UIButton *_goodPriceLabel;
    UILabel *_goodNameLabel;
    UILabel *_mesLabel;
    
    UILabel *lab1,*lab2;
    
    NSString *_currentSize;
    NSString *_currentPrice;
    NSString *_currentStock;
    NSString *_currentSizeId;
    
    NSString *_currentCash;
    NSString *_currentBalance;
    
    NSInteger _currentCount;
    
    UIButton *_finishBtn;
    UIView *_lineView;
    UILabel *_stockLabel;
}
@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UIView *sizeView;
@property (nonatomic, strong) UIScrollView *chooseScrollView;

@property (nonatomic, strong) NSMutableArray *sizeArray;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *sizeShowArray;

@property (nonatomic, strong) CountChangeView *countChangeView;

@property (nonatomic, strong) UIView *tagView;
//@property(nonatomic,strong)DWQSelectAttributes *selectAttributes;

@property (nonatomic, strong) UIImageView *icon1;
@property (nonatomic, strong) UIImageView *icon2;
@property (nonatomic, strong) UILabel *price1;
@property (nonatomic, strong) UILabel *price2;

@end

@implementation SizeChooseView

- (instancetype)init{
    
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
       
        
        [self addSubview:self.grayView];
        [self addSubview:self.sizeView];
        
        _currentCount = 0;

        [self initViews];
    }
    return self;
}
- (void)setP_id:(NSString *)p_id{
    _p_id = p_id;
    
    [self loadData];
}

- (void)setType:(ChooseSizeType)type{
    _type = type;
    
    if (type == 1) {
        [_finishBtn setTitle:@"加入购物车" forState:0];
    }else{
        [_finishBtn setTitle:@"立即购买" forState:0];
    }
}
- (void)setP_pic:(NSString *)p_pic{
    _p_pic = p_pic;
    [_goodImg showImgUrl:p_pic placeholder:DZImageNamed(@"loading_image2")];
}
- (void)setP_type:(NSNumber *)p_type{
    _p_type = p_type;
    
    NSString *price = self.p_cash.length>0?self.p_cash:@"0";//[MyTools changeIntoNumberWithString:self.p_cash?:@"0" Mul:@"1" type:mul_type];
    self.price1.text = [NSString stringWithFormat:@"¥ %@", price];
    if ([price isEqualToString:@"0"] || [price isEqualToString:@"0.0"] || [price isEqualToString:@"0.00"]) {
        [self.price1 setHidden:YES];
        self.icon2.sd_layout.leftSpaceToView(_goodImg, 20).topEqualToView(self.price1).heightIs(15).widthIs(20);
    } else {
        self.price1.sd_layout.leftSpaceToView(_goodImg, 20).topSpaceToView(self.sizeView, 10).heightIs(15);
        [self.price1 setHidden:NO];
        self.icon2.sd_layout.leftSpaceToView(_goodImg, 20 + 8 + _price1.width).topEqualToView(self.price1).heightIs(15).widthIs(20);
    }
    NSString *price2 = self.p_balance.length>0?self.p_balance:@"0";//[MyTools changeIntoNumberWithString:self.p_balance?:@"0" Mul:@"1" type:mul_type];
    if ([price2 isEqualToString:@"0"]) {
        self.icon2.hidden = self.price2.hidden = YES;
    }else{
        self.icon2.hidden = self.price2.hidden = NO;
        self.price2.text = price2;
    }
    self.countChangeView.p_type = self.p_type;
}

- (void)loadData{
    NSString *url = [[MoreUrlInterface URL_Server_String] stringByAppendingString:@"/api/product/showSize"];
    NSDictionary *dic = @{@"p_id":self.p_id?:@""};
    [[wclNetTool sharedTools] request:GET urlString:url parameters:dic finished:^(id responseObject, NSError *error) {
        if ([responseObject[@"code"] isEqualToString:@"1"]) {
            
            [self.sizeArray removeAllObjects];
            [self.titleArray removeAllObjects];
            [self.sizeShowArray removeAllObjects];
            
            for (NSDictionary *dic in responseObject[@"data"][@"sizes"]) {
                AllSizeCanChooseModel *model = [AllSizeCanChooseModel mj_objectWithKeyValues:dic];
                [self.sizeArray addObject:model];
            }
            
            for (NSDictionary *dic in responseObject[@"data"][@"shows"]) {
                SizeModel *model = [SizeModel mj_objectWithKeyValues:dic];
                
                NSMutableArray *arr = [NSMutableArray array];
                for (NSDictionary *d in dic[@"portoties"]) {
                    SizePortotiesModel *smodel = [SizePortotiesModel mj_objectWithKeyValues:d];
                    smodel.attr_val_name = [smodel.attr_val_name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    smodel.forbiddin = YES;
                    [arr addObject:smodel];
                }
                model.portoties = [arr copy];
                [self.sizeShowArray addObject:model.portoties];
                [self.titleArray addObject:model.attr_title];
            }
            
            //规格显示
            for (UIView *view in self.tagView.subviews) {
                [view removeFromSuperview];
            }
            
            
            CGFloat maxY = 0;
            CGFloat height = 0;
            
            //初始 可以选择的size
            NSMutableArray *primaryCanChooseArr = [NSMutableArray array];
            
            for (AllSizeCanChooseModel *model in self.sizeArray) {
                NSArray *arr = @[];
                //将库存为0的去除 从库存不为0的model里拿出可以点击的size
                if ([model.size_stock integerValue]!=0) {
                    arr = [self getTheSizeTitleByBind_id:model.size_portoties];
                }
                
                [primaryCanChooseArr addObjectsFromArray:arr];
            }
            
            //去重
            NSSet *set = [NSSet setWithArray:primaryCanChooseArr];
            primaryCanChooseArr = [[set allObjects] mutableCopy];
            
            for (NSInteger i =0; i<self.titleArray.count; i++) {
                
                DWQSelectAttributes *selectAttributes = [[DWQSelectAttributes alloc] initWithTitle:self.titleArray[i] titleArr:self.sizeShowArray[i] andFrame:CGRectMake(0, maxY, SCREEN_WIDTH, 40)];
                maxY = CGRectGetMaxY(selectAttributes.frame);
                height += selectAttributes.height;
                selectAttributes.primaryCanChooseArray = primaryCanChooseArr;
                __weak typeof(self) weakSelf = self;
                selectAttributes.didChooseTagBlock = ^(NSString *title, NSInteger index, BOOL flag) {
                    SizePortotiesModel *model = weakSelf.sizeShowArray[i][index];
                    NSString *bind_id = model.bind_id;
                    NSMutableArray *arr = [NSMutableArray array];
                    [arr addObject:bind_id];
                    NSArray *useArr = [weakSelf getTheUsefulTagWith:arr withPrimaryArray:primaryCanChooseArr];
                    [weakSelf reSetTheTagViews:useArr withBind_id:arr allChooseArray:primaryCanChooseArr];
                };
                [self.tagView addSubview:selectAttributes];
            }
            //修改frame
            self.tagView.frame = CGRectMake(0, 10, SCREEN_WIDTH, height);
            [self updateTheView];
        }else{
            if ([responseObject[@"errorCode"] isEqualToString:ErrorCode10001]){
//                [MyTools quit];
            }else{
//                [MyTools showMessageHud:responseObject[@"errorMsg"]];
            }
        }
        if (error) {
//            [MyTools showTheMessageWithInternetErrorCode:error.code];
        }
    }];
    
    
}

- (void)reSetTheTagViews:(NSArray *)arr withBind_id:(NSMutableArray *)bind_idArr allChooseArray:(NSMutableArray *)allChooseArray{
    for (UIView *view in self.tagView.subviews) {
        [view removeFromSuperview];
    }
    
    for (NSArray *s_arr in self.sizeShowArray) {
        for (SizePortotiesModel *pmodel in s_arr) {
            if (arr.count==0) {

                if (bind_idArr.count==0) {
                    pmodel.forbiddin = NO;
                }else{
                    
                    //如果在同一行 并且 规格没有选择 或者在同一行 并且只有一行
                    BOOL flag = [self compareTheBind_idIsSameWithTheArray:pmodel.bind_id arr:bind_idArr];
                    
                    if ((flag && (bind_idArr.count != self.sizeShowArray.count)) || (flag && self.sizeShowArray.count == 1)) {
                        
                        //判断是否在所有可选的当中
                        if (![allChooseArray containsObject:pmodel.attr_val_name]) {
                            pmodel.forbiddin = YES;
                        }else{
                            pmodel.forbiddin = NO;
                        }
                    }else{
                        
                        //规格已选满，但是已选中
                        if ([bind_idArr containsObject:pmodel.bind_id]) {
                            pmodel.forbiddin = NO;
                        }else{
                            //不在同一行 或者 规格已选满并且没有选择
                            pmodel.forbiddin = YES;
                        }
                    }
                }
                
            }else{
              
                //有其他可选的规格
                for (NSString *str in arr) {
                    
                    //与可选的不相同 并且已选中的不在同一行
                    if (![pmodel.bind_id isEqualToString:str] && ![self compareTheBind_idIsSameWithTheArray:pmodel.bind_id arr:bind_idArr]) {
                        
                        //判断是否在所有可选的当中
                        if (![allChooseArray containsObject:pmodel.attr_val_name]) {
                            pmodel.forbiddin = YES;
                        }else{
                            pmodel.forbiddin = NO;
                        }
                        
                    }else{
                        
                        //判断是否在所有可选的当中
                        if (![allChooseArray containsObject:pmodel.attr_val_name]) {
                            pmodel.forbiddin = YES;
                        }else{
                            pmodel.forbiddin = NO;
                        }

                        break;
                    }
                    
                }
                
            }

        }
    }
    
    
    
    CGFloat maxY = 0;
    CGFloat height = 0;
    
    for (NSInteger i =0; i<self.titleArray.count; i++) {
        
        
        DWQSelectAttributes *selectAttributes = [[DWQSelectAttributes alloc] initWithTitle:self.titleArray[i] titleArr:self.sizeShowArray[i] andFrame:CGRectMake(0, maxY, SCREEN_WIDTH, 40)];
        maxY = CGRectGetMaxY(selectAttributes.frame);
        height += selectAttributes.height;
        //已经选中的
        selectAttributes.canSelectArray = [self getTheSizeTitleByBind_id:bind_idArr];
        __weak typeof(self) weakSelf = self;
        selectAttributes.didChooseTagBlock = ^(NSString *title, NSInteger index, BOOL flag) {
            
            SizePortotiesModel *model = weakSelf.sizeShowArray[i][index];
            NSString *bind_id = model.bind_id;
            if (flag) {
                
                //如果是同一行 需要把之前的去除
                if ([weakSelf compareTheBind_idIsSameWithTheArray:bind_id arr:bind_idArr]) {
                    
                    for (NSInteger i = 0; i<bind_idArr.count; i++) {
                        
                        
                        //如果新选中的和 已选中的数组中 行数相同，则将已选中数组中相同行数的值删除
                        NSString *old_bind_id = bind_idArr[i];
                        if ([weakSelf compareTheBind_idIsSameWithTheArray:bind_id arr:@[old_bind_id]]) {
                            [bind_idArr removeObjectAtIndex:i];
                            i--;
                        }
                    }
                }
                
                //将新点击的值加入
                [bind_idArr addObject:bind_id];
                
            }else{
                [bind_idArr removeObject:bind_id];
                
            }
            
            NSArray *useArr = [weakSelf getTheUsefulTagWith:bind_idArr withPrimaryArray:allChooseArray];
            
            [weakSelf reSetTheTagViews:useArr withBind_id:bind_idArr allChooseArray:allChooseArray];
            
        };
        
        [self.tagView addSubview:selectAttributes];
    }
    
    //修改frame
    self.tagView.frame = CGRectMake(0, 10, SCREEN_WIDTH, height);
    
    [self updateTheView];
}
#pragma mark - 比较bing_id是否与 bind_arr中任意一个同行
- (BOOL)compareTheBind_idIsSameWithTheArray:(NSString *)bind_id arr:(NSArray *)bind_arr{
    
    for (NSString *str in bind_arr) {
        //拿到点击的行数
        NSString *line = [str componentsSeparatedByString:@":"][0];
        //对应的行数
        NSString *same_line = [bind_id componentsSeparatedByString:@":"][0];
        
        if ([line isEqualToString:same_line]) {
            return YES;
        }else{
            continue;
        }
    }
    return NO;
    
}
#pragma mark - 通过bind_ids数组获取对应的title数组
- (NSMutableArray *)getTheSizeTitleByBind_id:(NSArray *)bind_ids{
    
    NSMutableArray *a = [NSMutableArray array];
    
    for (NSArray *b in self.sizeShowArray) {
        
        for (SizePortotiesModel *model in b) {
            for (NSString *str in bind_ids) {
                if ([model.bind_id isEqualToString:str]) {
                    [a addObject:model.attr_val_name];
                    break;
                }
            }
        }
    }
    return a;
}

#pragma mark - 获取包含bind_idarr的规格 如果bind_arr的个数与总行数相同，则为空
- (NSMutableArray *)getTheUsefulTagWith:(NSMutableArray *)bind_idArr withPrimaryArray:(NSMutableArray *)pArray{
    
    NSMutableArray *useArr = [NSMutableArray array];
    //如果未选择 ，则所有可选
    if (bind_idArr.count==0) {
        for (NSArray *s_arr in self.sizeShowArray) {
            for (SizePortotiesModel *model in s_arr) {
                [useArr addObject:model.bind_id];
            }
        }
        return useArr;
    }
    for (NSInteger i = 0 ; i<self.sizeArray.count; i++) {
        
        AllSizeCanChooseModel *model = self.sizeArray[i];
        
//    规格已选满 返回可选为空
#warning 如果规格已经选满 返回可选的 而不是空 这里还需优化 需要把空库存的去除
        if (model.size_portoties.count == bind_idArr.count) {

            [self updateThePriceAndStock];
            
            return pArray;
        }
//        if (isSub) {
            //找出包含bind_idArr 但是还含有更多的值
            for (NSString *str in model.size_portoties) {
                    //找出所有0库存的规格 判断userArr里的可选单规格是否有包含在0库存的规格中
                    if ([model.size_stock integerValue] != 0) {
                        
                        if (![useArr containsObject:str]) {
                            [useArr addObject:str];
                        }
                        
                    }
//                }
                
            }
        
    }
    
    
    return useArr;
}


- (void)updateTheView{
    
    _lineView.frame = CGRectMake(20, self.tagView.bottom, SCREEN_WIDTH-40, 1);
    lab2.frame = CGRectMake(20, _lineView.bottom+45, 100, 20);
    
    self.countChangeView.frame = CGRectMake(SCREEN_WIDTH-140, _lineView.bottom+40, 130, 28);
    self.chooseScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.countChangeView.bottom+30);
}


- (void)look_image{
    
//    [MyTools showImage:_goodImg];
    
}
- (void)initViews{

    _goodImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, -40, 100, 100)];
    _goodImg.clipsToBounds = YES;
    _goodImg.contentMode = UIViewContentModeScaleAspectFill;
    _goodImg.layer.cornerRadius = 5;
    _goodImg.image = [UIImage imageNamed:@"test_1"];
    [self.sizeView addSubview:_goodImg];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(look_image)];
    [_goodImg addGestureRecognizer:tap];
    _goodImg.userInteractionEnabled = YES;
    
    self.price1 = [UILabel new];
    [self.self.sizeView addSubview:self.price1];
    self.price1.textColor = [UIColor py_colorWithHexString:@"#ef766a"];
    self.price1.font = kFont(13);
    
    self.icon2 = [UIImageView new];
    [self.self.sizeView addSubview:self.icon2];
    self.icon2.image = DZImageNamed(@"coupon_icon");
    
    self.price2 = [UILabel new];
    [self.self.sizeView addSubview:self.price2];
    self.price2.textColor = [UIColor whiteColor];
    self.price2.font = kFont(13);
    self.price2.backgroundColor = [UIColor py_colorWithHexString:@"e70014"];
    
    self.price1.sd_layout.leftSpaceToView(_goodImg, 20).topSpaceToView(self.sizeView, 10).heightIs(15);
    [self.price1 setSingleLineAutoResizeWithMaxWidth:100];
    
    self.icon2.sd_layout.leftSpaceToView(_goodImg, 20 + 8 + _price1.width).topEqualToView(self.price1).heightIs(15).widthIs(21);
    self.price2.sd_layout.leftSpaceToView(self.icon2, 0).topEqualToView(self.price1).heightIs(15);
    [self.price2 setSingleLineAutoResizeWithMaxWidth:100];
    
    _stockLabel = [[UILabel alloc] initWithFrame:CGRectMake(_goodImg.right+20, _goodImg.bottom-15, 150, 15)];
    _stockLabel.textColor = [UIColor f6];
    _stockLabel.font = [UIFont systemFontOfSize:13];
    _stockLabel.textAlignment = NSTextAlignmentLeft;
    _stockLabel.text = @"库存";
    [self.sizeView addSubview:_stockLabel];
    
    [self.sizeView addSubview:self.chooseScrollView];
    
    //规格展示
    self.tagView = [[UIView alloc] initWithFrame:CGRectMake(20, 5, SCREEN_WIDTH-40, 30)];
    [self.chooseScrollView addSubview:self.tagView];
    
    __weak typeof(self) weakSelf = self;

    _lineView = [[UIView alloc] initWithFrame:CGRectMake(20, self.tagView.bottom+5, SCREEN_WIDTH-40, 1)];
    _lineView.backgroundColor = [UIColor customGray];
    [self.chooseScrollView addSubview:_lineView];
    
    lab2 = [self createLabelWithTitle:@"购买数量"];
    lab2.frame = CGRectMake(20, _lineView.bottom+24, 100, 20);
    [self.chooseScrollView addSubview:lab2];
    
    self.countChangeView = [[CountChangeView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-130, _lineView.bottom+20, 130, 28)];
    [self.chooseScrollView addSubview:self.countChangeView];
    
    self.countChangeView.countChangeBlock = ^(NSInteger count) {
        
        _currentCount = count;
    
    };
    
    self.countChangeView.tfBeginEditingBlock = ^(CGFloat keyBoardHeight) {
        //键盘开始上移

        //输入框底部
        CGFloat h = weakSelf.chooseScrollView.height-weakSelf.countChangeView.bottom+45;

        if (h<keyBoardHeight) {
            weakSelf.sizeView.transform = CGAffineTransformMakeTranslation(0, -(keyBoardHeight-h));
        }
    };
 
    self.countChangeView.tfEndEditingBlock = ^{
        weakSelf.sizeView.transform = CGAffineTransformIdentity;
    };
    
    
    _finishBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, [ShiPeiIphoneXSRMax isIPhoneX]?self.sizeView.height-44-34:self.sizeView.height-44, SCREEN_WIDTH, 44)];
    [_finishBtn setBackgroundImage:[UIImage linerThemeImageWithSize:_finishBtn.size] forState:0];
    _finishBtn.layer.cornerRadius = 22;
    _finishBtn.layer.masksToBounds = YES;
    [_finishBtn setTitle:@"立即购买" forState:0];
    [_finishBtn setTitleColor:[UIColor whiteColor] forState:0];
    _finishBtn.titleLabel.font = kFont(16);
    [_finishBtn addTarget:self action:@selector(chooseDone:) forControlEvents:UIControlEventTouchUpInside];
    [self.sizeView addSubview:_finishBtn];
}
#pragma mark - 选择完成
- (void)chooseDone:(UIButton *)sender{
    
    [self endEditing:YES];
    
    _currentCount = self.countChangeView.currentCount;
    
    if (_currentCount == 0) {
//        [MyTools showMessageHud:@"商品数量不能为0"];
        return;
    }
    
    if ([[self updateThePriceAndStock] count]==0) {
//        [MyTools showMessageHud:@"您还有规格未选择!"];
        return;
    }
    
    if ([_currentStock integerValue] == 0) {
//        [MyTools showMessageHud:@"选中规格无库存！"];
        return;
    }
    
    if (_currentCount>[_currentStock integerValue]) {
//        [MyTools showMessageHud:@"所选数量大于商品库存"];
        return;
    }
    
    sender.enabled = NO;
    
    if (self.finishChooseBlock) {
        self.finishChooseBlock(_currentSize, _currentCount, self.type, _currentSizeId, _currentPrice, _currentStock, _currentCash, _currentBalance);
        sender.enabled = YES;
        [self hide];
    }
    
}

- (NSMutableArray *)updateThePriceAndStock{
    
    //获取已经选择的规格
    NSMutableArray *selectArr = [NSMutableArray array];
    for (DWQSelectAttributes *att in self.tagView.subviews) {
        if ([att isKindOfClass:[DWQSelectAttributes class]]) {
            for (UIButton *btn in att.btnView.subviews) {
                if ([btn isKindOfClass:[UIButton class]]) {
                    if (btn.selected) {
                        [selectArr addObject:btn.bind_id];
                    }
                }
            }
        }
    }
    
    
    if (selectArr.count != self.sizeShowArray.count) {
        return [@[] mutableCopy];
    }
    for (AllSizeCanChooseModel *model in self.sizeArray) {
        
        if ([model.size_portoties isEqualToArray:selectArr]) {
            _currentSize = model.size_title;
            _currentSizeId = [NSString stringWithFormat:@"%@",model.size_id];
            _currentPrice = [NSString stringWithFormat:@"%.2f",[model.size_balance floatValue]+[model.size_cash floatValue]];//[MyTools changeIntoNumberWithString:model.size_balance Mul:model.size_cash type:add_type];
            _currentCash = model.size_cash;
            _currentBalance = model.size_balance;
            
            _currentStock = [NSString stringWithFormat:@"%@",model.size_stock];
        }else{
        }
    }
    
    NSString *price =_currentCash.length>0?_currentCash:@"0";//[MyTools changeIntoNumberWithString:_currentCash?:@"0" Mul:@"1" type:mul_type];
    self.price1.text = [NSString stringWithFormat:@"¥ %@", price];
    if ([price isEqualToString:@"0"] || [price isEqualToString:@"0.0"] || [price isEqualToString:@"0.00"]) {
        [self.price1 setHidden:YES];
        self.icon2.sd_layout.leftSpaceToView(_goodImg, 20).topEqualToView(self.price1).heightIs(15).widthIs(20);
    } else {
        self.price1.sd_layout.leftSpaceToView(_goodImg, 20).topSpaceToView(self.sizeView, 10).heightIs(15);
        [self.price1 setHidden:NO];
        self.icon2.sd_layout.leftSpaceToView(_goodImg, 20 + 8 + _price1.width).topEqualToView(self.price1).heightIs(15).widthIs(20);
    }
    
    NSString *price2 = _currentBalance.length>0?_currentBalance:@"0";//[MyTools changeIntoNumberWithString:_currentBalance?:@"0" Mul:@"1" type:mul_type];
    if ([price2 isEqualToString:@"0"]) {
        self.icon2.hidden = self.price2.hidden = YES;
    }else{
        self.icon2.hidden = self.price2.hidden = NO;
        self.price2.text = price2;
    }

    _stockLabel.text = [NSString stringWithFormat:@"库存:%@",_currentStock];
    
    //修改最大输入值
    self.countChangeView.maxInputNumber = [_currentStock integerValue];
    
    return selectArr;
}

- (UILabel *)createLabelWithTitle:(NSString *)title{
    UILabel *l = [[UILabel alloc] init];
    l.textColor = YBLColor(88, 88, 88, 1);
    l.font = kFont(14);
    l.textAlignment = NSTextAlignmentLeft;
    l.text = title;
    return l;
}

- (void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.15 animations:^{
        self.sizeView.transform = CGAffineTransformMakeTranslation(0,[ShiPeiIphoneXSRMax isIPhoneX]? -0.618*SCREEN_HEIGHT-34: -0.618*SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
    }];
}

- (void)hide{
    
    [self.sizeShowArray removeAllObjects];
    [self.sizeArray removeAllObjects];
    [self.titleArray removeAllObjects];

    [self endEditing:YES];

    [UIView animateWithDuration:0.15 animations:^{
        self.sizeView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

- (UIView *)grayView{
    if (!_grayView) {
        _grayView = [[UIView alloc] initWithFrame:self.bounds];
        _grayView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [_grayView addGestureRecognizer:tap];
    }
    return _grayView;
}
- (UIView *)sizeView{
    if (!_sizeView) {
        _sizeView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, [ShiPeiIphoneXSRMax isIPhoneX]?0.618*SCREEN_HEIGHT+34:0.618*SCREEN_HEIGHT+0)];
        _sizeView.backgroundColor = [UIColor whiteColor];
    }
    return _sizeView;
}
- (UIScrollView *)chooseScrollView{
    if (!_chooseScrollView) {
        _chooseScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _goodImg.bottom+1, SCREEN_WIDTH, self.sizeView.height-_goodImg.bottom-1-45)];
    }
    return _chooseScrollView;
}
- (NSMutableArray *)sizeArray{
    if (!_sizeArray) {
        _sizeArray = [NSMutableArray array];
    }
    return _sizeArray;
}
- (NSMutableArray *)sizeShowArray{
    if (!_sizeShowArray) {
        _sizeShowArray = [NSMutableArray array];
    }
    return _sizeShowArray;
}
- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}
@end
