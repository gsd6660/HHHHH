//
//  CartVC.m
//  LYMallApp
//
//  Created by Mac on 2020/3/10.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "CartVC.h"
#import "CartModel.h"
#import "JSCartCell.h"
#import "CartNoGoodsCell.h"
#import "HBK_ShopppingCartBottomView.h"
#import "HomeFourCell.h"
#import "CollectionHeaderView.h"
#import "RecommentModel.h"
#import "GoodsDetailsVC.h"
#import "SureOrderVC.h"
@interface CartVC ()
<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    BOOL _isIdit;
    UIBarButtonItem *_editItem;
    UIBarButtonItem *_makeDataItem;
}
@property(nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray *selectArray;//选中的数组
@property (nonatomic, strong) NSMutableArray *storeArray;
@property (nonatomic, strong) HBK_ShopppingCartBottomView *bottomView;
@property(nonatomic,strong)NSMutableArray * recommentArray;
@property (nonatomic, strong)NSString * change_type;
@end

@implementation CartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kUIColorFromRGB(0xf9f9f9);
    self.automaticallyAdjustsScrollViewInsets = YES;

    self.title = @"购物车";
    self.change_type = @"1";
   [self setSubViews];
    [self getCartListsData:@""];
   [self getCartRecommendListsData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserInfo:) name:@"updateUserInfo" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCartData:) name:@"refreshCartData" object:nil];

    
 
}

//updateUserInfo
-(void)updateUserInfo:(NSNotification *)noti{
   [self getCartListsData:@""];
   [self getCartRecommendListsData];

}
//updateUserInfo
-(void)refreshCartData:(NSNotification *)noti{
    [self.selectArray removeAllObjects];
    [self judgeIsAllSelect];
       [self countPrice];
   [self getCartListsData:@""];
   [self getCartRecommendListsData];
   

}

#pragma mark 购物车列表
-(void)getCartListsData:(NSString *)change_cart_id{
    [self showEmptyViewWithLoading];
    [NetWorkConnection postURL:@"api/cart/lists" param:@{@"change_type":self.change_type,@"change_cart_id":change_cart_id} success:^(id responseObject, BOOL success) {
        NSLog(@"购物车列表数据===%@",responseJSONString);
        if (responseSuccess) {
            NSArray *dataArray = responseObject[@"data"][@"goods_list"];
            [self.storeArray removeAllObjects];
              if (dataArray.count > 0) {
                  for (NSDictionary *dic in dataArray) {
                      GoodsModel *model = [GoodsModel mj_objectWithKeyValues:dic];
                      [self.storeArray addObject:model];
                  }
                  dispatch_async(dispatch_get_main_queue(), ^{
                      if (change_cart_id.length == 0) {
                          [self.collectionView reloadData];
                      }
                  });
                  
              } else {
                  //加载数据为空时的展示
                  [self showEmptyViewWithImage:CCImage(@"wuwangluo") text:@"请求数据失败" detailText:@"没有数据或者加载失败" buttonTitle:@"点击重试" buttonAction:@selector(getCartListsData:)];
              }
            [self.collectionView reloadData];

        }
        [self hideEmptyView];

    } fail:^(NSError *error) {
        [self hideEmptyView];

    }];
}

#pragma mark 购物车推荐商品数据

-(void)getCartRecommendListsData{
    [NetWorkConnection postURL:@"api/index/recommend" param:nil success:^(id responseObject, BOOL success) {
        NSLog(@"购物车推荐商品数据===%@",responseJSONString);
        if (responseSuccess) {
            NSArray *dataArray = responseObject[@"data"][@"list"][@"data"];
            if (dataArray.count > 0) {
                [self.recommentArray removeAllObjects];
                for (NSDictionary *dic in dataArray) {
                    RecommentModel *model = [RecommentModel mj_objectWithKeyValues:dic];
                    [self.recommentArray addObject:model];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.collectionView reloadData];
                });
                
            } else {
                //加载数据为空时的展示
                
            }
        }
    } fail:^(NSError *error) {
    }];
}


#pragma  mark --------------------- UI ------------------
- (void)setSubViews {
   
   _isIdit = NO;
    self.bottomView = [[[NSBundle mainBundle] loadNibNamed:@"HBK_ShopppingCartBottomView" owner:nil options:nil] objectAtIndex:0];
    self.bottomView.frame = CGRectMake(0, ScreenHeight - kTabBarHeight - 50, ScreenWidth, 50);
    //全选
    [self clickAllSelectBottomView:self.bottomView];
    
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.collectionView];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem qmui_itemWithTitle:@"管理" target:self action:@selector(deleteButn:)];

}

#pragma mark 结算按钮
-(void)deleteButn:(UIBarButtonItem *)item{
    _isIdit = !_isIdit;
     NSString *itemTitle = _isIdit == YES?@"完成":@"编辑";
    NSString *butnTitle = _isIdit == YES?@"删除":@"结算";
     item.title = itemTitle;
    [self.bottomView.payButn setTitle:butnTitle forState:UIControlStateNormal];

    
}


#pragma mark - UITableView Delegate/DataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
        return 2;

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        
//      StoreModel *storeModel = self.storeArray[section];
        return self.storeArray.count;
    }
        return self.recommentArray.count;
}



//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (self.storeArray.count == 0) {
            return CGSizeMake(ScreenWidth , ScreenWidth);
        }
      return CGSizeMake(ScreenWidth - 20, 100);
    }
    if (ScreenWidth == 320) {
        return CGSizeMake(((ScreenWidth - 21) / 2), 264);
        }else if (ScreenWidth == 375) {
        return CGSizeMake(((ScreenWidth - 21) / 2), 290);
              }
        return CGSizeMake(((ScreenWidth - 21) / 2), 310);
}



// 添加一个补充视图(页眉或页脚)
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
 
     CollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifierCollectionHeader forIndexPath:indexPath];
    headerView.backgroundColor = kUIColorFromRGB(0xF9F9F9);
    return headerView;
   
}

//设置每个item的UIEdgeInsets

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return UIEdgeInsetsMake(10, 0, 10, 0);

    }
    return UIEdgeInsetsMake(0, 10, 0, 10);

}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{

   return 1;

}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;

}
 

// 设定页眉的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return CGSizeMake(ScreenWidth, 45);
    }
    return CGSizeMake(ScreenWidth, 0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {

        if (self.storeArray.count == 0) {
            CartNoGoodsCell *cell = (CartNoGoodsCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CartNoGoodsCell" forIndexPath:indexPath];
            return cell;
        }
        
        JSCartCell *cell = (JSCartCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"JSCartCell" forIndexPath:indexPath];
           GoodsModel *goodsModel = self.storeArray[indexPath.row];
           cell.goodsModel = goodsModel;
           //把事件的处理分离出去
           [self shoppingCartCellClickAction:cell storeModel:nil goodsModel:goodsModel indexPath:indexPath];
        
        return cell;
    }
    MJWeakSelf;
     HomeFourCell *cell = (HomeFourCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellFourId" forIndexPath:indexPath];
    RecommentModel *reModel = self.recommentArray[indexPath.row];
    cell.model = reModel;
    cell.block = ^{
        [weakSelf getCartListsData:@""];
    };
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        GoodsModel *goodsModel = self.storeArray[indexPath.row];
        GoodsDetailsVC * vc = [[GoodsDetailsVC alloc]init];
        vc.typeStr = @"1";

        vc.goods_id = [goodsModel.goods_id stringValue];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 1) {
        RecommentModel *model = self.recommentArray[indexPath.row];
        GoodsDetailsVC * vc = [[GoodsDetailsVC alloc]init];
        vc.typeStr = @"1";

        vc.goods_id = [model.goods_id stringValue];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark --------Action 逻辑处理----------


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.selectArray removeAllObjects];
}


/**
 判断分区有没有被全选
 */
- (void)judgeIsSelectSection:(NSInteger)row {
    GoodsModel *goodsModel = self.storeArray[row];
    BOOL isSelectSection = YES;
    //遍历分区商品, 如果有商品的没有被选择, 跳出循环, 说明没有全选
    for (GoodsModel *goodsModel in self.storeArray) {
        if (goodsModel.isSelect == NO) {
            isSelectSection = NO;
            break;
        }
    }
    goodsModel.isSelect = isSelectSection;
}

#pragma mark 是否全选
- (void)judgeIsAllSelect {
    NSInteger count = 0;
    //先遍历购物车商品, 得到购物车有多少商品
    for (GoodsModel *goodsModel in self.storeArray) {
        count += self.storeArray.count;
    }
    //如果购物车总商品数量 等于 选中的商品数量, 即表示全选了
    if ((self.storeArray.count == self.selectArray.count )  && count > 0) {
        self.bottomView.isClick = YES;
    } else {
        self.bottomView.isClick = NO;
    }
}

#pragma mark  计算价格
- (void)countPrice {
    double totlePrice = 0.0;
    for (GoodsModel *goodsModel in self.selectArray) {
        double price = [goodsModel.goods_price doubleValue];
        totlePrice += price * [goodsModel.total_num integerValue];
    }
    self.bottomView.allPriceLabel.text = [NSString stringWithFormat:@"合计 ￥%.2f", totlePrice];
}




#pragma mark 全选点击---逻辑处理

- (void)clickAllSelectBottomView:(HBK_ShopppingCartBottomView *)bottomView {
    kWeakSelf(self);
    bottomView.AllClickBlock = ^(BOOL isClick) {
        kStrongSelf(self);
        for (GoodsModel *goodsModel in self.selectArray) {
            goodsModel.isSelect = NO;
        }
        [self.selectArray removeAllObjects];
        if (isClick) {//选中
            NSLog(@"全选");
                for (GoodsModel *goodsModel1 in self.storeArray) {
                    goodsModel1.isSelect = YES;
                    [self.selectArray addObject:goodsModel1];
                }
        } else {//取消选中
            NSLog(@"取消全选");
            for (GoodsModel *storeModel in self.storeArray) {
                storeModel.isSelect = NO;
            }
        }
        [self.collectionView reloadData];
        [self countPrice];
    };
    
  
    bottomView.AccountBlock = ^(UIButton *butn) {
        
        if ([butn.titleLabel.text isEqualToString:@"删除"]) {
            [self deleteGoodsWithIndexPath];
        }
        else{
            NSMutableArray * cartIDs = [[NSMutableArray alloc]init];
            for (GoodsModel * model in self.selectArray) {
                       NSLog(@"去结算===%@",model.goods_name);
                [cartIDs addObject:model.cart_id];
//                [self getCartListsData:model.cart_id];
            }
            if (self.selectArray.count > 0) {
                SureOrderVC * vc = [[SureOrderVC alloc]init];
                vc.cart_ids = [cartIDs componentsJoinedByString:@","];
                vc.type = CartPush;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                ShowErrorHUD(@"请选择要购买的商品");
            }
            
        }
        
        
    };
    
}

- (void)shoppingCartCellClickAction:(JSCartCell *)cell
                         storeModel:(StoreModel *)storeModel
                         goodsModel:(GoodsModel *)goodsModel
                          indexPath:(NSIndexPath *)indexPath {
    //选中某一行
    cell.ClickRowBlock = ^(BOOL isClick) {
        goodsModel.isSelect = isClick;
        if (isClick) {//选中
            NSLog(@"选中");
            if (self.selectArray.count >0) {
                for (GoodsModel *model in self.selectArray) {
                    if ([model.goods_id isEqualToNumber:goodsModel.goods_id]) {
                        [self.selectArray removeObjectAtIndex:indexPath.row];
                    }
                }
            }
            [self.selectArray addObject:goodsModel];
        } else {//取消选中
            NSLog(@"取消选中");
            [self.selectArray removeObject:goodsModel];
        }
        
        [self judgeIsSelectSection:indexPath.row];
        [self judgeIsAllSelect];
        [self countPrice];
    };
    //加
    cell.AddBlock = ^(UILabel *countLabel) {
        NSLog(@"%@", countLabel.text);
        self.change_type = @"1";

        goodsModel.total_num = countLabel.text;
        [self.storeArray replaceObjectAtIndex:indexPath.row withObject:goodsModel];
        [self getCartListsData:goodsModel.cart_id];
        if ([self.selectArray containsObject:goodsModel]) {
            [self.selectArray removeObject:goodsModel];
            [self.selectArray addObject:goodsModel];
            [self countPrice];
        }

    };
    //减
    cell.CutBlock = ^(UILabel *countLabel) {
        NSLog(@"%@", countLabel.text);
        self.change_type = @"2";
        goodsModel.total_num = countLabel.text;
        [self.storeArray replaceObjectAtIndex:indexPath.row withObject:goodsModel];
         [self getCartListsData:goodsModel.cart_id];
        if ([self.selectArray containsObject:goodsModel]) {
            [self.selectArray removeObject:goodsModel];
            [self.selectArray addObject:goodsModel];
            [self countPrice];
        }
//

    };
}



#pragma mark 删除某个商品
- (void)deleteGoodsWithIndexPath {
    
   
      [self deleteGoodsData];//删除网络数据

//
//    [self.collectionView reloadData];
//       /*3 carbar 恢复默认*/
//
//       /*重新计算价格*/
       [self countPrice];

    NSInteger count = 0;
    for (GoodsModel *goodsModel in self.storeArray) {
        count += self.storeArray.count;
    }
    if (self.selectArray.count == self.storeArray.count) {
        _bottomView.allButn.selected = YES;
    } else {
        _bottomView.allButn.selected = NO;
    }

    if (count == 0) {
        //此处加载购物车为空的视图
        [_bottomView.allButn setImage:CCImage(@"jft_but_Unselected") forState:UIControlStateSelected];
//        [QMUITips showInfo:@"购物车空空如也~"];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}


-(void)deleteGoodsData{
    NSMutableArray * arrIDs = [[NSMutableArray alloc]init];
    for (GoodsModel * model in self.selectArray) {
        [arrIDs addObject:model.cart_id];
    }
    
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
        for (NSInteger i = 0; i < self.selectArray.count; i ++) {
            GoodsModel *goodsModel = self.selectArray[i];
            if (goodsModel.isSelect == YES) {
                [indexSet addIndex:i];
            }
        }
    
        [self.storeArray removeObjectsAtIndexes:indexSet];
        [self.selectArray removeAllObjects];
    
    
    
    MJWeakSelf;
    [NetWorkConnection postURL:@"api/cart/clearAll" param:@{@"cartIds":[arrIDs componentsJoinedByString:@","]} success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            ShowHUD(responseMessage);
            [weakSelf getCartListsData:@""];
            [weakSelf.collectionView reloadData];
        }else{
            ShowErrorHUD(responseMessage);
        }
    } fail:^(NSError *error) {
        
    }];
}

-(UICollectionView *)collectionView{
if (_collectionView == nil) {
    self.automaticallyAdjustsScrollViewInsets = NO;
       UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        //2.初始化collectionView
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - kTabBarHeight - 50) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"JSCartCell" bundle:nil] forCellWithReuseIdentifier:@"JSCartCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"CartNoGoodsCell" bundle:nil] forCellWithReuseIdentifier:@"CartNoGoodsCell"];

    
    
        [_collectionView registerClass:[HomeFourCell class] forCellWithReuseIdentifier:@"cellFourId"];
       [self.collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifierCollectionHeader];

          _collectionView.delegate = self;
          _collectionView.dataSource = self;

      }
    return _collectionView;
}


- (NSMutableArray *)selectArray {
    if (!_selectArray) {
        self.selectArray = [NSMutableArray new];
    }
    return _selectArray;
}
- (NSMutableArray *)storeArray {
    if (!_storeArray) {
        self.storeArray = [NSMutableArray new];
    }
    return _storeArray;
}
-(NSMutableArray *)recommentArray{
    if (_recommentArray == nil) {
        _recommentArray = [[NSMutableArray alloc]init];
    }
    return _recommentArray;
}




@end
