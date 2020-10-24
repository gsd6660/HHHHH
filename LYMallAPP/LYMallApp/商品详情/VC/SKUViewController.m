//
//  SKUViewController.m
//  LYMallApp
//
//  Created by gds on 2020/3/26.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "SKUViewController.h"

#import "TCPropertyCell.h"
#import "TCPropertyHeader.h"
#import "TCPropertyFooter.h"
#import "TCCountFooterView.h"
#import "ORSKUDataFilter.h"

#import "SureOrderVC.h"

static NSString *const TCPropertyCellID = @"TCPropertyCell";
static NSString *const TCPropertyHeaderID = @"TCPropertyHeader";
static NSString *const TCPropertyFooterID = @"TCPropertyFooter";
static NSString *const TCCountFooterViewID = @"TCCountFooterView";

@interface SKUViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,ORSKUDataFilterDataSource>

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *skuData;;
@property (nonatomic, strong) NSMutableArray <NSIndexPath *>*selectedIndexPaths;;
@property (nonatomic, strong) ORSKUDataFilter *filter;

@property (strong, nonatomic)  UIImageView *goodImageView;
@property (strong, nonatomic) UILabel * priceLabel;
/*销量*/
@property (strong,nonatomic)UILabel * salesLabel;
@property (strong,nonatomic)UIButton * closeBtn;
@property (nonatomic,strong)UIView  * skuView;

@property (nonatomic,strong)UICollectionView * collectionView;

/** 确定 */
@property (strong, nonatomic)  UIButton *sureBtn;
/** 立即购买 */
@property (strong, nonatomic)  UIButton *buyGoodsBtn;


@end

@implementation SKUViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    self.dataSource = self.dataDic[@"goods_multi_spec"][@"spec_attr"];
    self.skuData = self.dataDic[@"sku"];
    _selectedIndexPaths = [NSMutableArray array];
    _filter = [[ORSKUDataFilter alloc] initWithDataSource:self];
    [self initView];
    [self.goodImageView sd_setImageWithURL:[NSURL URLWithString:self.dataDic[@"goods_image"]]];
    self.quantity = @"1";
    [self.collectionView reloadData];
    
    if (self.selectDic) {
        _filter.currentResult = self.selectDic;
        _buyGoodsBtn.enabled = YES;
        [self defaultSelectItem];
    }
    
}
//选中之后再进入该页面 默认的选中状态
- (void)defaultSelectItem{
    self.spec_sku_id = self.selectDic[@"spec_sku_id"];
    NSArray * array = [self.spec_sku_id componentsSeparatedByString:@"_"];
    NSLog(@"%@",array);
    
     NSMutableArray * indexArr = [NSMutableArray array];
    for (int i = 0; i<array.count; i++) {
        NSString * item_id = array[i];
        NSArray * arr = _dataSource[i][@"spec_items"];
        for (int j = 0; j< arr.count; j++) {
            NSDictionary * dic = arr[j];
            if ([item_id isEqualToString:[NSString stringWithFormat:@"%@",dic[@"item_id"]]]) {
                NSLog(@"%@",item_id);
                NSLog(@"section:%d---row:%d",i,j);
                NSIndexPath * indexPath = [NSIndexPath indexPathForRow:j inSection:i];
                [indexArr addObject:indexPath];
                _filter.selectedIndexPaths = indexArr;
                
            }
        }
    }
    
    NSArray * skuArr = self.dataDic[@"sku"];
    [skuArr enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self.spec_sku_id isEqualToString:obj[@"spec_sku_id"]]) {
            self.priceLabel.text = [NSString stringWithFormat:@"￥%@",self.is_shrp?obj[@"seckill_price"]: obj[@"goods_price"]];
             self.salesLabel.text = [NSString stringWithFormat:@"已售%@件",self.dataDic[@"goods_sku"][@"goods_sales"]];
        }
    }];
}


- (void)initView{
    self.skuView = [[UIView alloc]init];
    self.skuView.layer.cornerRadius = 5;
    self.skuView.layer.qmui_maskedCorners = QMUILayerMinXMinYCorner|QMUILayerMaxXMinYCorner;
    self.skuView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.skuView];
    [self.skuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(ScreenHeight/2);
        make.width.offset(ScreenWidth);
        make.height.offset(ScreenHeight/2);
    }];
    
    self.goodImageView = [[UIImageView alloc]init];
    self.goodImageView.backgroundColor = [UIColor redColor];
    self.goodImageView.layer.cornerRadius = 5;
    self.goodImageView.layer.masksToBounds = YES;
    [self.skuView addSubview:self.goodImageView];
    [self.goodImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.skuView).offset(10);
        make.width.height.offset(89);
    }];
    
    self.priceLabel = [UILabel new];
//    self.priceLabel.text = @"￥19.9";
    self.priceLabel.textColor = [UIColor redColor];
    self.priceLabel.font = [UIFont systemFontOfSize:13];
    [self.skuView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodImageView.mas_right).offset(10);
        make.top.equalTo(self.skuView).offset(20);
        make.right.equalTo(self.skuView.mas_right).offset(-10);
        make.height.offset(20);
    }];
    
    self.salesLabel = [UILabel new];
//    self.salesLabel.text = @"已售333件";
    self.salesLabel.textColor = [UIColor redColor];
    self.salesLabel.font = [UIFont systemFontOfSize:13];
    [self.skuView addSubview:self.salesLabel];
    [self.salesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLabel.mas_bottom).offset(10);
        make.left.equalTo(self.goodImageView.mas_right).offset(10);
        make.right.equalTo(self.skuView.mas_right);
        make.height.offset(20);
    }];
    
    
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeBtn setBackgroundImage:[UIImage imageNamed:@"jft_icon_close"] forState:0];
    [self.skuView addSubview:self.closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.skuView.mas_top).offset(10);
        make.right.equalTo(self.skuView.mas_right).offset(-20);
        make.width.height.offset(20);
    }];
    [self.closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[TCPropertyCell class] forCellWithReuseIdentifier:TCPropertyCellID];
    [_collectionView registerClass:[TCPropertyHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:TCPropertyHeaderID];
    [_collectionView registerClass:[TCPropertyFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:TCPropertyFooterID];
    [_collectionView registerClass:[TCCountFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:TCCountFooterViewID];
    [_collectionView reloadData];
    [_collectionView setContentInset:UIEdgeInsetsMake(0, 0, 44, 0)];
    [self.skuView addSubview:self.collectionView];
    [_collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:0  inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
 
    _buyGoodsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buyGoodsBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_buyGoodsBtn setBackgroundImage:[UIImage imageNamed:@"jft_but_purchase"] forState:0];
     [_buyGoodsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _buyGoodsBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_buyGoodsBtn addTarget:self action:@selector(buyNowBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _buyGoodsBtn.enabled = NO;
    [self.skuView addSubview:_buyGoodsBtn];
    UILabel * lineLabel = [UILabel new];
    lineLabel.backgroundColor = [kUIColorFromRGB(0xF5F5F5) colorWithAlphaComponent:1];
    [self.skuView addSubview:lineLabel];
    
    
//    [self.addCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//     make.bottom.equalTo(self.skuView.mas_bottom).offset(-kBottomSafeHeight - 5);
//     make.right.equalTo(self.skuView.mas_centerX).offset(-10);
//     make.width.offset(140);
//     make.height.offset(35);
//    }];
 
     [self.buyGoodsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.bottom.equalTo(self.skuView.mas_bottom).offset(-kBottomSafeHeight - 5);
         make.centerX.equalTo(self.skuView.mas_centerX);
         make.width.offset(140);
         make.height.offset(35);
     }];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.buyGoodsBtn.mas_top).offset(-5);
        make.width.mas_equalTo(ScreenWidth);
        make.height.offset(1);
        make.left.offset(0);
    }];
     
     [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.goodImageView.mas_bottom).offset(10);
         make.left.right.equalTo(self.skuView).offset(10);
         make.bottom.equalTo(lineLabel.mas_top);
     }];
    
}

- (void)closeBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
 
/*确定*/
- (void)buyNowBtnClick{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    NSDictionary * fileDic = _filter.currentResult;
    if (fileDic==nil) {
        ShowErrorHUD(@"请选择规格");
        return;
    }
    [dic setValue:fileDic[@"goods_attr"] forKey:@"goods_attr"];
    [dic setValue:fileDic[@"spec_sku_id"] forKey:@"spec_sku_id"];
    [dic setValue:fileDic[@"goods_id"] forKey:@"goods_id"];
    [dic setValue:self.quantity forKey:@"quantity"];
    if (self.type == SELECTPECELL) {
        [dic setValue:@(SELECTPECELL) forKey:@"type"];
    }
    if (self.type == SELECTPEADDBTN) {
        NSLog(@"添加购物车");
         [dic setValue:@(SELECTPEADDBTN) forKey:@"type"];
    }
    if (self.type == SELECTPEBUYBTN) {
        NSLog(@"购买");
         [dic setValue:@(SELECTPEBUYBTN) forKey:@"type"];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushType" object:nil userInfo:dic];
    [self dismissViewControllerAnimated:NO completion:^{
           }];
}

#pragma mark -- UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_dataSource[section][@"spec_items"] count];
     
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TCPropertyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TCPropertyCellID forIndexPath:indexPath];

    NSArray * data = _dataSource[indexPath.section][@"spec_items"];
    cell.propertyL.text = data[indexPath.row][@"spec_value"];

    if (![_filter.availableIndexPathsSet containsObject:indexPath]) {
        cell.contentView.backgroundColor = kUIColorFromRGB(0xF3FDF7);
        cell.propertyL.textColor = kUIColorFromRGB(0x666666);
        cell.contentView.layer.borderWidth = 0.5;
        cell.contentView.layer.borderColor = kUIColorFromRGB(0x3ACD7B).CGColor;
    }else {
        cell.contentView.backgroundColor =kUIColorFromRGB(0xEEEEEE);
        cell.propertyL.textColor = kUIColorFromRGB(0x666666);
        cell.contentView.layer.borderWidth = 0.0;
    }

    if ([_filter.selectedIndexPaths containsObject:indexPath]) {
        cell.contentView.backgroundColor = kUIColorFromRGB(0xF3FDF7);
        cell.propertyL.textColor = kUIColorFromRGB(0x666666);
        cell.contentView.layer.borderWidth = 0.5;
        cell.contentView.layer.borderColor = kUIColorFromRGB(0x3ACD7B).CGColor;
    }
    
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) _weakSelf = self;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        TCPropertyHeader *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:TCPropertyHeaderID forIndexPath:indexPath];
        view.headernameL.text = _dataSource[indexPath.section][@"group_name"];
        return view;
    } else {
        if (indexPath.section == _dataSource.count - 1) {
            TCCountFooterView *countView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:TCCountFooterViewID forIndexPath:indexPath];
            countView.maxValue = 10;
            if (self.selectDic) {
                countView.numberButton.currentNumber = [self.selectDic[@"goods_num"] floatValue];
            }
            countView.changeNumCellBlock = ^(CGFloat number) {//选择商品数量
                _weakSelf.quantity = [NSString stringWithFormat:@"%.0f", number];
            };
            return countView;
        }
        TCPropertyFooter *line = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:TCPropertyFooterID forIndexPath:indexPath];
        return line;
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [_filter didSelectedPropertyWithIndexPath:indexPath];
    
    [collectionView reloadData];
    [self action_complete];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSArray *data = _dataSource[indexPath.section][@"value"];
//    NSString *text = data[indexPath.row];
//    CGFloat width = [NSString calculateRowWidth:text withHeight:20 font:12];
    
//    return CGSizeMake(width + 10 * 4, 25);
    return CGSizeMake(80, 25);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 10, 0, 10);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(ScreenWidth, 44);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == self.dataSource.count - 1) {
        return CGSizeMake(ScreenWidth, 60);
    }
    return CGSizeMake(ScreenWidth - 10 * 2, 11);
}


#pragma mark -- ORSKUDataFilterDataSource
- (NSInteger)numberOfSectionsForPropertiesInFilter:(ORSKUDataFilter *)filter {
    return _dataSource.count;
}

- (NSArray *)filter:(ORSKUDataFilter *)filter propertiesInSection:(NSInteger)section {
//    return _dataSource[section][@"spec_items"];
    NSMutableArray * strArr = [NSMutableArray array];
    NSArray * arr = _dataSource[section][@"spec_items"];
    [arr enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [strArr addObject:[NSString stringWithFormat:@"%@",obj[@"item_id"]]];
    }];
    return strArr;
}

- (NSInteger)numberOfConditionsInFilter:(ORSKUDataFilter *)filter {
    return _skuData.count;
}

- (NSArray *)filter:(ORSKUDataFilter *)filter conditionForRow:(NSInteger)row {
    NSString *condition = _skuData[row][@"spec_sku_id"];
    return [condition componentsSeparatedByString:@"_"];
}

- (id)filter:(ORSKUDataFilter *)filter resultOfConditionForRow:(NSInteger)row {
    NSDictionary *dic = _skuData[row];
    return @{@"price":self.is_shrp? dic[@"seckill_price"]:dic[@"goods_price"],
             @"store": dic[@"stock_num"],
             @"line_price": dic[@"line_price"],
             @"spec_sku_id":dic[@"spec_sku_id"],
             @"goods_sku_id":dic[@"goods_sku_id"],
             @"goods_attr":dic[@"goods_attr"]
    };
}

- (void)action_complete {

    NSDictionary *dic = _filter.currentResult;
    if (dic == nil) {
        NSLog(@"请选择完整 属性");
//        ShowErrorHUD(@"请选择规格");
        self.salesLabel.text = @"请选择规格";
        self.priceLabel.text = @"";
        _buyGoodsBtn.enabled = NO;
        return;
    }
    _buyGoodsBtn.enabled = YES;
    self.salesLabel.text = [NSString stringWithFormat:@"已售%@件",self.dataDic[@"goods_sku"][@"goods_sales"]];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",dic[@"price"]];

}

- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
}

- (NSArray *)skuData{
    if (!_skuData) {
        _skuData = [NSArray array];
    }
    return _skuData;
}



@end
