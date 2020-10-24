//
//  HomeThreeCell.m
//  LYMallApp
//
//  Created by Mac on 2020/3/11.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "HomeThreeCell.h"
#import "lbl_CutDownView.h"
#import "HomeFightCell.h"
#import "GroupViewController.h"
@interface HomeThreeCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,strong)lbl_CutDownView *view;
@end

@implementation HomeThreeCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        [self setUI];
       
    }
    
    return self;
}
 
#pragma mark - 视图
 
- (void)setUI
{
    
    
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.image = CCImage(@"green-juxing");
    [self.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(12.5);
        make.top.height.mas_equalTo(16);
        make.size.mas_equalTo(CGSizeMake(3, 17));
    }];
    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.backgroundColor = [UIColor whiteColor];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"限时拼团" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 17],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];

    self.titleLabel.attributedText = string;
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.mas_equalTo(16);
        make.left.equalTo(imageView.mas_right).offset(9);
        make.width.mas_equalTo(80);
    }];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    self.view = [[lbl_CutDownView alloc] initWithFrame:CGRectMake(110, 16, 110, 50)];
    self.view.backgroundColor = kUIColorFromRGB(0x0BC160);
    self.view.textColor = [UIColor whiteColor];
    self.view.colonColor = kUIColorFromRGB(0x0BC160);
//       self.[view startTime:@"2020/04/06 12:00:00" endTime:@"2020/04/16 18:00:00" cdStyle:CutDownHome];
       [self.contentView addSubview:self.view];
    
    
    self.collectionBgView = [[UIView alloc]init];
    [self.contentView addSubview:self.collectionBgView];
    [self.collectionBgView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.height.mas_equalTo(44);
           make.left.mas_equalTo(12.5);
           make.right.bottom.mas_equalTo(-9);
           make.bottom.mas_equalTo(-20);
       }];
    
    
    
    
}
- (void)setSharing_goods:(NSDictionary *)sharing_goods{
    _sharing_goods = sharing_goods;
    [self.view startTime:sharing_goods[@"start_time"] endTime:sharing_goods[@"end_time"] cdStyle:CutDownHome];
    [self.collectionView reloadData];
}
///////////////////////////////////////////

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;

}

//设置每个item的UIEdgeInsets

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
   
     return UIEdgeInsetsMake(0, 0, 0, 0);
}


// UICollectionViewCell最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0;
}
 
// UICollectionViewCell最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}




- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeFightCell *cell = (HomeFightCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"fightCellId" forIndexPath:indexPath];
//    [cell setValuecationWithDataDic:self.dataArray[indexPath.row]];
    if (self.sharing_goods) {
        [cell.goodsImageView sd_setImageWithURL:[NSURL URLWithString:self.sharing_goods[@"goods_image"]]];
        cell.goodsNameLabel.text = self.sharing_goods[@"goods_name"];
        cell.desLabel.text = self.sharing_goods[@"selling_point"];
        cell.priceLable.text = [NSString stringWithFormat:@"￥%@",self.sharing_goods[@"goods_sku"][@"seckill_price"]];
        cell.oldPriceLabel.text = [NSString stringWithFormat:@"￥%@",self.sharing_goods[@"goods_sku"][@"original_price"]];
        cell.salesLabel.text = [NSString stringWithFormat:@"已拼团%@人",self.sharing_goods[@"total_sales"] ];
    }
    return cell;

    }


//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake(ScreenWidth, 124);

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GroupViewController * vc = [GroupViewController new];
    vc.goods_id = self.sharing_goods[@"sharp_goods_id"];
    [[self viewController].navigationController pushViewController:vc animated:YES];
}


-(UICollectionView *)collectionView{
if (_collectionView == nil) {

        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        // 每一行cell之间的间距
        layout.minimumLineSpacing = 0;
         // 每一列cell之间的间距
          layout.minimumInteritemSpacing = 5;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        self.collectionView.alwaysBounceHorizontal = YES;
        self.collectionView.alwaysBounceVertical = NO;
       self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.collectionBgView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
             }];
                _collectionView.backgroundColor = [UIColor clearColor];
                [_collectionView registerNib:[UINib nibWithNibName:@"HomeFightCell" bundle:nil] forCellWithReuseIdentifier:@"fightCellId"];
                _collectionView.delegate = self;
                _collectionView.dataSource = self;
    
       }
      return _collectionView;
}





@end
