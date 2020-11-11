//
//  HomeFourCell.m
//  TableViewDemo
//
//  Created by C C on 2020/3/9.
//  Copyright © 2020 CC. All rights reserved.
//

#import "HomeFourCell.h"
#import "RecommentModel.h"
@implementation HomeFourCell
-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {

        
         UIImageView * bg = [[UIImageView alloc]init];
        bg.image = [UIImage imageNamed:@"商品背景框"];
    [self.contentView addSubview:bg];

   [bg mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.top.bottom.equalTo(self.contentView).offset(0);

                }];
//
        self.goodsImageView = [[UIImageView alloc]init];
        self.goodsImageView.image = [UIImage imageNamed:@"商品大小"];
//        self.goodsImageView.backgroundColor = [UIColor redColor];
        self.goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.goodsImageView.clipsToBounds = YES;
        [self.contentView addSubview:self.goodsImageView];
        
        [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView).offset(5);
            make.right.equalTo(self.contentView).offset(-5);

            make.height.equalTo(self.mas_width).multipliedBy(1);
        }];
        self.goodsImageView.layer.qmui_maskedCorners = QMUILayerMinXMinYCorner |QMUILayerMaxXMinYCorner;
           self.goodsImageView.layer.cornerRadius = 5;
        
        self.markImageButnView = [UIButton buttonWithType:UIButtonTypeCustom];
        self.markImageButnView.frame = CGRectZero;
        [self.markImageButnView setBackgroundImage:CCImage(@"标签") forState:UIControlStateNormal];
        [self.markImageButnView setTitle:@"限时特惠" forState:UIControlStateNormal];
        self.markImageButnView.titleEdgeInsets = UIEdgeInsetsMake(-4, 0, 0, 0);
        self.markImageButnView.titleLabel.font = FONTSIZE(12);

        [self.goodsImageView addSubview:self.markImageButnView];
        
        [self.markImageButnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.bottom.equalTo(self.goodsImageView.mas_bottom).offset(-15);
            make.width.mas_equalTo(71);
            make.height.mas_equalTo(25);
        }];
        
        self.titleLable = [[UILabel alloc]init];
        self.titleLable.text = @"优质红葡萄酒1000ml";
//        self.titleLable.backgroundColor = [UIColor redColor];
        self.titleLable.font = FONTSIZE(15);
        self.titleLable.numberOfLines = 2;

       [self.contentView addSubview:self.titleLable];
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsImageView.mas_bottom).offset(10);
        make.left.equalTo(self.goodsImageView).offset(10);

            make.right.equalTo(self.goodsImageView).offset(-10);
            make.height.mas_equalTo(15);
        }];

        
        self.desLable = [[UILabel alloc] init];
        self.desLable.textColor = kUIColorFromRGB(0x666666);
        self.desLable.numberOfLines = 0;
        self.desLable.text = @"口感香醇 传统酿造";
        self.desLable.font = FONTSIZE(12);

        [self.contentView addSubview:self.desLable];
        [self.desLable mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(self.titleLable.mas_bottom).offset(10);
            make.left.equalTo(self.goodsImageView).offset(10);
           make.right.equalTo(self.goodsImageView).offset(-10);
           make.height.mas_offset(12);
               }];

        
        self.priceLable = [[UILabel alloc] init];
        self.priceLable.numberOfLines = 0;
        [self.contentView addSubview:self.priceLable];
        self.priceLable.text = @"￥8.3";
        self.priceLable.textColor = kUIColorFromRGB(0xFF6773);
        self.priceLable.font = FONTSIZE(16);

        [self.priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
                  make.top.equalTo(self.desLable.mas_bottom).offset(13.5);
                   make.left.equalTo(self.goodsImageView).offset(10);
                  make.right.equalTo(self.goodsImageView).offset(-80);
                  make.height.mas_offset(18);
                      }];
        
        self.salesLable = [[UILabel alloc] init];
        self.salesLable .frame = CGRectMake(24.5,210,58,10.5);
        self.salesLable .numberOfLines = 0;
//        self.salesLable.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.salesLable ];
        [self.salesLable mas_makeConstraints:^(MASConstraintMaker *make) {
                         make.top.equalTo(self.priceLable.mas_bottom).offset(7.5);
                          make.left.equalTo(self.goodsImageView).offset(10);
                         make.right.equalTo(self.goodsImageView).offset(-50);
                         make.height.mas_offset(12);
                             }];
        
        
        
        NSMutableAttributedString *string3 = [[NSMutableAttributedString alloc] initWithString:@"月销1258件" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 11],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
        self.salesLable.attributedText = string3;
     
        UIButton * butn = [UIButton buttonWithType:UIButtonTypeCustom];
        [butn setImage:CCImage(@"cart_home") forState:UIControlStateNormal];
        [self.contentView addSubview:butn];
        [butn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-13);
            make.right.equalTo(self.contentView).offset(-18.5);
            make.size.mas_equalTo(CGSizeMake(30, 30));
            }];
        [butn addTarget:self action:@selector(cartButn:) forControlEvents:UIControlEventTouchUpInside];
        

    }
    
    return self;
    
}


-(void)setModel:(RecommentModel *)model{
    _model = model;
    [self.goodsImageView yy_setImageWithURL:[NSURL URLWithString:model.goods_image] placeholder:CCImage(@"")];
    self.titleLable.text = model.goods_name;
    self.desLable.text = [NSString stringWithFormat:@"%@",model.sliver];
    self.salesLable.text = [NSString stringWithFormat:@"月销%@件",model.goods_sales];
    self.priceLable.text = model.goods_sku[@"goods_price"];;
    self.desLable.text = model.selling_point;
}


- (void)setMallModel:(MallModel *)mallModel{
    _mallModel = mallModel;
    [self.goodsImageView yy_setImageWithURL:[NSURL URLWithString:mallModel.goods_image] placeholder:CCImage(@"")];
    self.titleLable.text = mallModel.goods_name;
    self.desLable.text =  [NSString stringWithFormat:@"%@",mallModel.sliver];
    self.salesLable.text = [NSString stringWithFormat:@"月销%@件",mallModel.goods_sales];
    self.priceLable.text = mallModel.goods_sku[@"goods_price"];;
    self.desLable.text = mallModel.selling_point;
}


-(void)cartButn:(UIButton *)butn{
    NSLog(@"点击===%@",self.model.goods_name);

    [NetWorkConnection postURL:@"api/cart/add" param:@{@"goods_id":[self.model.goods_id stringValue],@"goods_num":@"1",@"spec_sku_id":[NSString stringWithFormat:@"%@",self.model.goods_sku[@"spec_sku_id"]]} success:^(id responseObject, BOOL success) {
        ShowHUD(responseMessage);
        [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshCartData" object:nil];
        if (self.block) {
            self.block();
        }
    } fail:^(NSError *error) {
        
    }];
    
}


@end
