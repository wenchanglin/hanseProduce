//
//  WCLCateScrollView.m
//  hanseProduce
//
//  Created by 文长林 on 2019/9/28.
//  Copyright © 2019 wenchanglin. All rights reserved.
//

#import "WCLCateScrollView.h"
#import "DetailSizeView.h"
#import "BaseCommentCell.h"
#import <WebKit/WebKit.h>
@interface WCLCateScrollView()<WKNavigationDelegate>
@property(nonatomic,strong)UILabel*goodsTitleLabel,*storeLabel;
@property(nonatomic,strong)UILabel*descTitleLabel;
@property(nonatomic,strong)UILabel*originPriceLabel,*noCommentLabel;
@property(nonatomic,strong)UILabel*goodPrice;
@property(nonatomic,strong)DetailSizeView*detailSizeShowView;
@property(nonatomic,strong)UIButton*shareBtn,*cateBtn,*look_all_comment;
@property(nonatomic,strong)BaseCommentCell *commentCell;
@property (nonatomic, strong) WKWebView *wkView;

@property(nonatomic,strong)UIImageView*couponImageView,*right_arrow;
@property(nonatomic,strong)UIView*firstView,*secondView,*noCommentView,*line3;
@property(nonatomic,strong)UILabel*couponPriceLabel;


@end
@implementation WCLCateScrollView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        self.userInteractionEnabled=YES;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        self.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
        [self createUI];
    }
    return self;
}
-(void)createUI{
    switch (self.goodsStyle) {
        case ProductStyleNormal:
            {
                [self addSubview:self.cycleScrollView];
                [self addSubview:self.goodsTitleLabel];
                [self addSubview:self.shareBtn];
                [self addSubview:self.descTitleLabel];
                [self addSubview:self.goodPrice];
                [self addSubview:self.originPriceLabel];
                [self addSubview:self.couponImageView];
                [self addSubview:self.couponPriceLabel];
                [self addSubview:self.storeLabel];
                [self addSubview:self.firstView];
                [self addSubview:self.cateBtn];
                [self addSubview:self.right_arrow];
                [self addSubview:self.secondView];
               
                self.cycleScrollView.sd_layout.leftEqualToView(self).rightEqualToView(self).widthIs(SCREEN_WIDTH).heightIs(375);
                self.goodsTitleLabel.sd_layout.
                leftSpaceToView(self, 15).topSpaceToView(self.cycleScrollView, 16).rightSpaceToView(self, 50).heightIs(60);
                self.shareBtn.sd_layout.centerYEqualToView(self.goodsTitleLabel).rightSpaceToView(self, 8).widthIs(19).heightEqualToWidth();
                self.descTitleLabel.sd_layout.topSpaceToView(self.goodsTitleLabel, 10).leftEqualToView(self.goodsTitleLabel).rightSpaceToView(self, 50).autoHeightRatio(0);
                [self.descTitleLabel setMaxNumberOfLinesToShow:1];
                self.goodPrice.sd_layout.leftSpaceToView(self, 15).topSpaceToView(self.descTitleLabel, 15).heightIs(17);
                [self.goodPrice setSingleLineAutoResizeWithMaxWidth:150];
                self.originPriceLabel.sd_layout.leftSpaceToView(self.goodPrice, 4).bottomEqualToView(self.goodPrice).heightIs(20).minWidthIs(1);
                [self.originPriceLabel setSingleLineAutoResizeWithMaxWidth:100];
                self.couponImageView.sd_layout.leftSpaceToView(self.originPriceLabel, 15).bottomEqualToView(self.goodPrice).heightIs(15).widthIs(21);
                self.couponPriceLabel.sd_layout.leftSpaceToView(self.couponImageView, 0).centerYEqualToView(self.couponImageView).heightIs(15).widthIs(0);
                self.storeLabel.sd_layout.rightSpaceToView(self, 15).bottomEqualToView(self.goodPrice).heightIs(15);
                [self.storeLabel setSingleLineAutoResizeWithMaxWidth:120];
                self.firstView.sd_layout.leftEqualToView(self).rightEqualToView(self).heightIs(1).topSpaceToView(self.couponPriceLabel, 16);
                self.cateBtn.sd_layout.leftEqualToView(self.goodPrice).topSpaceToView(self.firstView, 16).heightIs(17).widthIs(SCREEN_WIDTH-50);
                self.right_arrow.sd_layout.heightIs(16).widthIs(9).rightSpaceToView(self, 16).centerYEqualToView(self.cateBtn);
                self.secondView.sd_layout.leftEqualToView(self).rightEqualToView(self).heightIs(1).topSpaceToView(self.cateBtn, 16);
                
                [self addSubview:self.commentLabel];
                self.commentLabel.sd_layout.leftEqualToView(self.goodsTitleLabel).topSpaceToView(self.secondView, 10).heightIs(20).widthIs(80);
                [self addSubview:self.look_all_comment];
                self.look_all_comment.sd_layout.rightSpaceToView(self, 1).centerYEqualToView(self.commentLabel).heightIs(17).widthIs(100);
                [self addSubview:self.noCommentView];
                [self.noCommentView addSubview:self.noCommentLabel];
                self.noCommentView.sd_layout.leftEqualToView(self).topSpaceToView(self.commentLabel, 0).rightSpaceToView(self, 0);
                self.noCommentLabel.sd_layout.centerXEqualToView(_noCommentView).centerYEqualToView(_noCommentView).heightIs(20);
                [_noCommentLabel setSingleLineAutoResizeWithMaxWidth:200];
                [self.noCommentView addSubview:self.commentCell];
//                //line
                UIView *line3 = [UIView new];
                line3.backgroundColor = [UIColor customGray];
                [self addSubview:line3];
                _line3=line3;
                line3.sd_layout.centerXEqualToView(self).topSpaceToView(self.noCommentView,0).widthIs(SCREEN_WIDTH).heightIs(1);
                //detail
                [self addSubview:self.detailSecondLabel];
                self.detailSecondLabel.sd_layout.centerXEqualToView(self).topSpaceToView(line3, 10).heightIs(20);
                [self.detailSecondLabel setSingleLineAutoResizeWithMaxWidth:80];
                UIImageView *line_left = [UIImageView new];
                line_left.image = [UIImage imageNamed:@"left_line2"];
                line_left.contentMode = UIViewContentModeScaleAspectFit;
                [self addSubview:line_left];
                line_left.sd_layout.rightSpaceToView(self.detailSecondLabel, 10).widthIs(60).heightIs(5).centerYEqualToView(self.detailSecondLabel);

                UIImageView *line_right = [UIImageView new];
                line_right.image = [UIImage imageNamed:@"right_line2"];
                line_left.contentMode = UIViewContentModeScaleAspectFit;
                [self addSubview:line_right];
                line_right.sd_layout.leftSpaceToView(self.detailSecondLabel, 10).widthIs(60).heightIs(5).centerYEqualToView(self.detailSecondLabel);

            }
            break;
            case ProductStyleRush:
        {
//            [self.mainScrollView addSubview:self.rushBuyView];
//            self.rushBuyView.sd_layout.leftEqualToView(self.carouselView).topSpaceToView(self.carouselView, 0).rightEqualToView(self.carouselView).heightIs(70);
        }break;
        default:
            break;
    }
    [self addSubview:self.wkView];
    self.wkView.sd_layout.
    topSpaceToView(self.detailSecondLabel, 10).centerXEqualToView(self).widthIs(SCREEN_WIDTH).heightIs(SCREEN_HEIGHT);
    [self setupAutoContentSizeWithBottomView:self.wkView bottomMargin:0];
    

}

-(void)setGoodsStyle:(ProductStyle)goodsStyle
{
    _goodsStyle=goodsStyle;
}
-(void)setMainModel:(WCLGoodsDetailModel *)mainModel
{
    _mainModel=mainModel;
    _goodsTitleLabel.text=mainModel.p_title;
    _descTitleLabel.text=mainModel.p_describe;
    NSString *market_price = [NSString stringWithFormat:@"￥%@",mainModel.p_cash];
//    CGFloat width = [market_price widthWithStringAttribute:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Medium" size:18]}];
    self.goodPrice.text =market_price;
    NSString *market_prices = [NSString stringWithFormat:@"￥%@",mainModel.market_price];
    NSMutableAttributedString *att1 = [[NSMutableAttributedString alloc] initWithString:market_prices];
    [att1 addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, market_prices.length)];
    CGFloat width2 = [market_prices widthWithStringAttribute:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}]+10;
    self.originPriceLabel.attributedText=att1;
    if ([mainModel.p_balance isEqualToString:@"0"]||[mainModel.p_balance isEqualToString:@"0.00"]) {
        _couponImageView.hidden = YES;
        _couponPriceLabel.hidden = YES;
    }
    else
    {
        _couponImageView.hidden = NO;
        _couponPriceLabel.hidden = NO;
//        _couponImageView.frame=CGRectMake(CGRectGetMaxX(self.originPriceLabel.frame)+18, 0, 16, 15);
//        _couponImageView.centerY=self.goodPrice.centerY;
        CGFloat couponpricewidth = [mainModel.p_balance widthWithStringAttribute:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:11]}]+10;
//        _couponPriceLabel.frame=CGRectMake(CGRectGetMaxX(self.couponImageView.frame)+1, 0, couponpricewidth, 15);
        _couponPriceLabel.text=mainModel.p_balance;
        [_couponPriceLabel sizeToFit];
        self.couponPriceLabel.sd_layout.leftSpaceToView(self.couponImageView, 0).centerYEqualToView(self.couponImageView).heightIs(15).widthIs(self.couponPriceLabel.width+5);

    }
    NSString* stockStr=[NSString stringWithFormat:@"仅剩%@件", @(mainModel.p_stock)];
    CGFloat stockwidth = [stockStr widthWithStringAttribute:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Medium" size:12]}]+5;
    self.storeLabel.frame=CGRectMake(SCREEN_WIDTH-17-stockwidth, 0, stockwidth, 17);
    _storeLabel.centerY=self.goodPrice.centerY+2;
    self.storeLabel.text =stockStr;
   
    if (mainModel.comment.count>0) {
        CommentModel *model = [CommentModel mj_objectWithKeyValues:mainModel.comment];
        _commentCell.model=model;
        [_commentCell updateLayout];
        [_commentCell layoutIfNeeded];
        NSArray *sdBottomviews = _commentCell.sd_bottomViewsArray;
        _commentCell.contentView.height = CGRectGetMaxY([sdBottomviews.firstObject frame]) + 10;
        _commentCell.height = CGRectGetMaxY([sdBottomviews.firstObject frame]) + 10;
        _commentCell.sd_layout.leftSpaceToView(_noCommentView, 0).topSpaceToView(_noCommentView, 0).rightSpaceToView(_noCommentView, 0).heightIs(CGRectGetMaxY([sdBottomviews.firstObject frame]) + 10);
        [_noCommentView setupAutoHeightWithBottomView:_commentCell bottomMargin:0];
        self.noCommentLabel.hidden = YES;
        self.commentCell.hidden = NO;

    }
    else
    {
        self.noCommentLabel.hidden = NO;
        self.commentCell.hidden = YES;
        [_noCommentView setupAutoHeightWithBottomView:_noCommentLabel bottomMargin:20];
    }
    self.line3.sd_layout.centerXEqualToView(self).topSpaceToView(self.noCommentView, 1).widthIs(SCREEN_WIDTH).heightIs(1);
    //网页 /api/product/detailView
    NSString *url1 = [NSString stringWithFormat:@"/api/product/detailView?p_id=%@",@(mainModel.p_id)];
    NSString *url2 = [[MoreUrlInterface URL_Server_String] stringByAppendingString:url1];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url2]];
    [self.wkView loadRequest:request]; 
}
-(UILabel *)detailSecondLabel
{
    if (!_detailSecondLabel) {
        _detailSecondLabel = [UILabel new];
        _detailSecondLabel.font = kRegularFont(15);
        _detailSecondLabel.text = @"商品详情";
        _detailSecondLabel.textColor = [UIColor f3];
    }
    return _detailSecondLabel;
}
-(BaseCommentCell *)commentCell
{
    if (!_commentCell) {
        _commentCell = [[BaseCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BaseCommentCell"];
        _commentCell.hidden = YES;
        _commentCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return _commentCell;
}
-(UIView *)noCommentView
{
    if (!_noCommentView) {
        _noCommentView=[[UIView alloc]init];
    }
    return _noCommentView;
}
-(UILabel *)noCommentLabel
{
    if (!_noCommentLabel) {
        _noCommentLabel = [UILabel new];
        _noCommentLabel.text = @"该商品还没有评论~";
        _noCommentLabel.font = [UIFont systemFontOfSize:13];
        _noCommentLabel.textColor = [UIColor f6];
        _noCommentLabel.hidden = YES;
    }
    return _noCommentLabel;
}
-(UIButton *)look_all_comment
{
    if (!_look_all_comment) {
        _look_all_comment = [[UIButton alloc]init];
        [_look_all_comment setTitle:@"查看全部" forState:UIControlStateNormal];
        [_look_all_comment setTitleColor:[UIColor f6] forState:UIControlStateNormal];
        _look_all_comment.titleLabel.font = kRegularFont(13);
        [_look_all_comment setImage:[UIImage imageNamed:@"rightjiantou"] forState:UIControlStateNormal];
        [_look_all_comment setImageEdgeInsets:UIEdgeInsetsMake(0, 75, 0, 0)];
        [_look_all_comment setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
        [_look_all_comment addTarget:self action:@selector(look_all_comments) forControlEvents:UIControlEventTouchUpInside];
    }
    return _look_all_comment;
}
-(UILabel *)commentLabel
{
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc]init];
        _commentLabel.font = kMediumFont(14);
        _commentLabel.text = @"宝贝评价";
        _commentLabel.textColor = [UIColor f3];
    }
    return _commentLabel;
}
-(UIButton *)cateBtn
{
    if (!_cateBtn) {
        _cateBtn = [[UIButton alloc]init];
        _cateBtn.titleLabel.font = kMediumFont(14);
        [_cateBtn setTitle:@"规格参数" forState:UIControlStateNormal];
        [_cateBtn setTitleColor:[UIColor f3] forState:UIControlStateNormal];
        [_cateBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_cateBtn addTarget:self action:@selector(showDetailSizeView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cateBtn;
}
-(UIImageView *)right_arrow
{
    if (!_right_arrow) {
        _right_arrow = [[UIImageView alloc]init];
        _right_arrow.centerY=self.cateBtn.centerY;
        _right_arrow.image = [UIImage imageNamed:@"rightjiantou"];
    }
    return _right_arrow;
}

- (DetailSizeView *)detailSizeShowView{
    if (!_detailSizeShowView) {
        _detailSizeShowView = [[DetailSizeView alloc] init];
    }
    return _detailSizeShowView;
}

-(UILabel *)storeLabel
{
    if (!_storeLabel) {
        _storeLabel=[[UILabel alloc]init];
        _storeLabel.centerY=self.goodPrice.centerY+2;
        _storeLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];
        _storeLabel.textColor=UIColor.f9;
    }
    return _storeLabel;
}
-(UIView *)firstView
{
    if (!_firstView){
        _firstView=[[UILabel alloc]init];
        _firstView.backgroundColor=UIColor.e;
    }
    return _firstView;
}
-(UIView *)secondView
{
    if (!_secondView){
        _secondView=[[UILabel alloc]init];
        _secondView.backgroundColor=UIColor.e;
    }
    return _secondView;
}
-(UILabel *)couponPriceLabel
{
    if (!_couponPriceLabel) {
        _couponPriceLabel=[[UILabel alloc]init];
        _couponPriceLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:11];
        _couponPriceLabel.backgroundColor=[UIColor colorWithHexString:@"#E70014"];
        _couponPriceLabel.textColor=[UIColor whiteColor];
    }
    return _couponPriceLabel;
}
-(UIImageView *)couponImageView
{
    if (!_couponImageView) {
        _couponImageView =[[UIImageView alloc]init];
        _couponImageView.centerY=self.goodPrice.centerY;
        _couponImageView.contentMode=UIViewContentModeScaleAspectFill;
        _couponImageView.image=[UIImage imageNamed:@"coupon_icon"];
    }
    return _couponImageView;
}
-(UILabel *)originPriceLabel
{
    if (!_originPriceLabel) {
        _originPriceLabel = [[UILabel alloc] init];
        _originPriceLabel.centerY=self.goodPrice.centerY;
        _originPriceLabel.textColor = [UIColor py_colorWithHexString:@"#888888"];
        _originPriceLabel.font = [UIFont systemFontOfSize:12];
    }
    return _originPriceLabel;
}
-(UILabel *)goodPrice
{
    if (!_goodPrice) {
        _goodPrice = [[UILabel alloc]init];
        _goodPrice.textColor = [UIColor theme];
        _goodPrice.font = kMediumFont(20);
    }
    return _goodPrice;
}
-(UILabel *)goodsTitleLabel
{
    if (!_goodsTitleLabel) {
        _goodsTitleLabel=[[UILabel alloc]init];
        _goodsTitleLabel.font=[UIFont fontWithName:@"PingFangSC-Bold" size:14];
        _goodsTitleLabel.textColor=UIColor.f3;
        _goodsTitleLabel.numberOfLines=2;
    }
    return _goodsTitleLabel;
}
-(UILabel *)descTitleLabel
{
    if (!_descTitleLabel) {
        _descTitleLabel=[[UILabel alloc]init];
        _descTitleLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];
        _descTitleLabel.textColor=UIColor.f9;
//        [_descTitleLabel setSingleLineAutoResizeWithMaxWidth:100];

    }
    return _descTitleLabel;
}
-(UIButton *)shareBtn
{
    if (!_shareBtn) {
        _shareBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-16-19, 0, 19, 19)];
        _shareBtn.centerY=self.goodsTitleLabel.centerY;
        [_shareBtn setImage:[UIImage imageNamed:@"detail_share"] forState:UIControlStateNormal];
    }
    return _shareBtn;
}
-(CarouselView *)cycleScrollView
{
    if (!_cycleScrollView) {
        _cycleScrollView = [[CarouselView alloc]init];//WithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 375)
        _cycleScrollView.backgroundColor=[UIColor whiteColor];
        _cycleScrollView.pageStyle=CarouselViewPageStyleLabel;
    }
    return _cycleScrollView;
}
- (WKWebView *)wkView{
    if (!_wkView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
#if defined(__IPHONE_13_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0
        if (@available(iOS 13.0, *)) {
            configuration.defaultWebpagePreferences = NULL;
        }
#endif
        _wkView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        _wkView.navigationDelegate = self;
        _wkView.scrollView.scrollEnabled = NO;
        _wkView.backgroundColor = [UIColor whiteColor];
    }
    return _wkView;
}
-(void)showDetailSizeView
{
    self.detailSizeShowView.p_id = [NSString stringWithFormat:@"%@",@(_mainModel.p_id)];
    [self.detailSizeShowView show];
}
#pragma mark - 查看所有评论
- (void)look_all_comments{
    self.lookAllCommentsBlock(_mainModel.p_id);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat cellOffy = scrollView.contentOffset.y;
    self.scrollViewOffsetBlock(cellOffy);
}
#pragma mark - wkwebview delegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [webView evaluateJavaScript:@"Math.max(document.body.scrollHeight, document.body.offsetHeight, document.documentElement.clientHeight, document.documentElement.scrollHeight, document.documentElement.offsetHeight, window.screen.availHeight)"
              completionHandler:^(id _Nullable result, NSError * _Nullable error) {
                  if (!error) {
                      NSNumber *height = result;
                      dispatch_async(dispatch_get_main_queue(), ^{
                          self.wkView.sd_layout.heightIs(height.doubleValue + 70);
                          self.contentSize = CGSizeMake(SCREEN_WIDTH, self.wkView.bottom);
                      });
                  }
              }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
