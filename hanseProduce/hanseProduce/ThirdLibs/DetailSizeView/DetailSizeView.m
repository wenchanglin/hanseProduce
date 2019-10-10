//
//  DetailSizeView.m
//  BaseProject
//
//  Created by Sunsgne on 2018/7/31.
//  Copyright © 2018年 Sunsgne. All rights reserved.
//

#import "DetailSizeView.h"
 
@interface DetailSizeView ()<UITableViewDelegate,UITableViewDataSource>
{
    
}
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *whiteView;
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,strong)NSDictionary *dataDic;
@end

@implementation DetailSizeView

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor=[UIColor whiteColor];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        
        [self setup];
    }
    return self;
}

- (void)setP_id:(NSString *)p_id{
    _p_id = p_id;
    
    [self loadData];
}

- (void)loadData{
    
    NSString *url = @"/api/product/parameters";
    [[wclNetTool sharedTools]request:GET urlString:url parameters:@{@"p_id":self.p_id}.mutableCopy finished:^(id responseObject, NSError *error) {
        if ([responseObject[@"code"]integerValue]==1) {
            self.dataDic = responseObject[@"data"];
            [self.tableView reloadData];
        }
    }];

    
}
- (void)setup{
    
    [self addSubview:self.maskView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self.maskView addGestureRecognizer:tap];
    
    [self addSubview:self.whiteView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"规格参数";
    title.textColor = [UIColor f3];
    title.font = [UIFont systemFontOfSize:16];
    [self.whiteView addSubview:title];
    
    UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20-10, 0, 20, 20)];
    cancel.centerY = title.centerY;
    [cancel setImage:[UIImage imageNamed:@"black_cancel"] forState:0];
    [cancel addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self.whiteView addSubview:cancel];
    
    //line
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
    line.backgroundColor = [UIColor customGray];
    [self.whiteView addSubview:line];
    
    [self.whiteView addSubview:self.tableView];
    
    
}
- (void)show{
    
//    CGRect frame = self.whiteView.frame;
//    CGFloat height = self.whiteView.frame.size.height;
//
    
    self.alpha = 0;
    [UIView animateWithDuration:0.15 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            self.whiteView.transform = CGAffineTransformMakeTranslation(0, [ShiPeiIphoneXSRMax isIPhoneX]?-0.618*self.height-34:-0.618*self.height-0);
        }];
        
    }];
}

- (void)hide{
    
    [self endEditing:YES];
    
    self.alpha = 1;
    [UIView animateWithDuration:0.15 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.15 animations:^{
            self.whiteView.transform = CGAffineTransformIdentity;
        }];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataDic.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cid"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cid"];
    }
    cell.selectionStyle = 0;
    
    cell.textLabel.textColor = [UIColor f3];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    cell.detailTextLabel.textColor = [UIColor f6];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.numberOfLines = 2;
    
    if (_dataDic) {
        NSArray *keyArr = [_dataDic allKeys];
        NSArray *valueArr = [_dataDic allValues];
        cell.textLabel.text = keyArr[indexPath.row];
        cell.detailTextLabel.text = valueArr[indexPath.row];
    }

    return cell;
}


- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:self.bounds];
        _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }
    return _maskView;
}
- (UIView *)whiteView{
    if (!_whiteView) {
        _whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, self.width, 0.618*self.height+20)];
        _whiteView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteView;
}
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, self.whiteView.height-40) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor customGray];
        _tableView.tableFooterView = [UIView new];
        _tableView.estimatedRowHeight = 0;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.estimatedRowHeight = 0;
    }
    
    return _tableView;
}


@end
