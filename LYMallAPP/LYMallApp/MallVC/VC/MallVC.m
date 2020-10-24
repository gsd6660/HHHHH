//
//  MallVC.m
//  LYMallApp
//
//  Created by Mac on 2020/3/10.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MallVC.h"
#import "MallCell.h"
#import "HomeFightCell.h"
#import "MallModel.h"
#import "GoodsDetailsVC.h"
#import "MenuSelectView.h"
#import "ClassifyTableViewCell.h"
#import "XinOrderPayVC.h"
#import "SureOrderVC.h"
@interface MallVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)UIView * topView;
@property(nonatomic,strong)UITableView * leftTableView;
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)MenuSelectView * menuView;

@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray * tableDataArray;
@property(nonatomic,strong)NSIndexPath * tableIndexPath;
@property(nonatomic,strong)NSString * searchStr;
@property(nonatomic,strong)NSMutableDictionary * addCartDic;

@end

static NSString * tableViewCellIdentifier = @"ClassifyTableViewCell";

@implementation MallVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.title;
    self.navigationController.title = @"分类";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.collectionView];
    
    UIView * searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    searchView.layer.masksToBounds = YES;
    searchView.layer.cornerRadius = 5;
    searchView.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = searchView;
    
    UITextField * searchTF = [[UITextField alloc]initWithFrame:searchView.frame];
    searchTF.font = FONTSIZE(13);
    searchTF.placeholder = @"请输入搜索关键词";
    searchTF.delegate = self;
    searchTF.returnKeyType = UIReturnKeySearch;
    [searchView addSubview:searchTF];
    UIButton * butn = [UIButton buttonWithType:UIButtonTypeCustom];
    butn.frame = CGRectMake(0, 0, 40, 30);
    [butn setImage:CCImage(@"jft_icon_search") forState:UIControlStateNormal];
    searchTF.leftViewMode = UITextFieldViewModeAlways;
    
    UIView * butnView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    [butnView addSubview:butn];
    searchTF.leftView = butnView;
    
    

    [self.tableView registerNib:[UINib nibWithNibName:tableViewCellIdentifier bundle:nil] forCellReuseIdentifier:tableViewCellIdentifier];

    self.page =1;
//    [self setUI];
    [self getData:self.category_id.length > 0 ? self.category_id : nil ];
    
    MJWeakSelf;
    self.collectionView.mj_header =  [YMRefreshHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf getData:weakSelf.category_id.length > 0 ? weakSelf.category_id : nil];
     [weakSelf getTypeData];
    }];
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf getData:weakSelf.category_id.length > 0 ? weakSelf.category_id : nil];
    }];
    
        [self getTypeData];

    self.leftTableView.mj_header =  [YMRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf getTypeData];
    }];
    
    
    
    }



-(void)getTypeData{
    [NetWorkConnection postURL:@"api/category/index" param:nil success:^(id responseObject, BOOL success) {
        NSLog(@"商品分类====%@",responseJSONString);
        if (responseSuccess) {
            [self.tableDataArray removeAllObjects];
            NSArray * list = responseObject[@"data"][@"list"];
            for (NSDictionary *dic in list) {
                [self.tableDataArray addObject:dic];
            }
            [self.leftTableView.mj_header endRefreshing];
            [self.tableView reloadData];
        }
    } fail:^(NSError *error) {
        
    }];
}




-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = kUIColorFromRGB(0xffffff);

}
//
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = kUIColorFromRGB(0x3ACD7B);

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSLog(@"输入的是======%@",textField.text);
    self.searchStr = textField.text;
  
    [self getData:@"0"];

    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    return YES;
    
}


-(void)getData:(NSString *)category_id {
    
    [self showEmptyViewWithLoading];
    
    [NetWorkConnection postURL:@"api/goods/lists" param:@{@"category_id":category_id.length > 0? category_id:@"",@"search":self.searchStr.length > 0? self.searchStr:@"",@"page":@(self.page)
    } success:^(id responseObject, BOOL success) {
        NSLog(@"商品列表======%@",responseJSONString);
        if (responseSuccess) {
            if (self.page == 1) {
                [self.dataArray removeAllObjects];

            }
            NSArray * array = responseObject[@"data"][@"list"][@"data"];
            
            for (NSDictionary *dic in array) {
                MallModel * model = [MallModel mj_objectWithKeyValues:dic];
                [self.dataArray addObject:model];
            }
            
              if (self.dataArray.count == 0) {
//                  [self hideEmptyView];
                  [self showEmptyViewWithImage:CCImage(@"wushuju") text:@"暂无数据" detailText:@"" buttonTitle:@"点击重试" buttonAction:@selector(lookMore)];

                  
              }else{
                  [self hideEmptyView];
              }
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshing];
            if (array.count == 0) {
             [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }
            
        }else{
            ShowErrorHUD(responseMessage);
        }
        [self.collectionView reloadData];
       

    } fail:^(NSError *error) {
        [self hideEmptyView];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    }];
}

-(void)lookMore{
    [self getData:self.category_id];

}
- (BOOL)layoutEmptyView{
    
    self.emptyView.frame = CGRectMake(150, 100, ScreenWidth - 100, 400);
    self.emptyView.center = self.collectionView.center;
    return YES;
}



#pragma mark UITableViewDelegateANDDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ClassifyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier];
    
    cell.titleLabel.text = self.tableDataArray[indexPath.row][@"name"];
    if (self.tableIndexPath == indexPath) {
        cell.titleLabel.textColor = UIColorHex(0xFC6465);
        cell.lineLabel.hidden = NO;
        cell.backgroundColor = [UIColor whiteColor];
        cell.titleLabel.font = [UIFont boldSystemFontOfSize:15];
       
    }else{
        cell.titleLabel.textColor = UIColorHex(0x444A53);
        cell.lineLabel.hidden = YES;
        cell.backgroundColor =  UIColorHex(0xF8F9F9);
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ClassifyTableViewCell *celled = [tableView cellForRowAtIndexPath: self.tableIndexPath];
    celled.titleLabel.textColor = UIColorHex(0x444A53);
    celled.titleLabel.font = [UIFont systemFontOfSize:13];

    //记录当前选中的位置
    self.tableIndexPath = indexPath;
    //当前选择的打勾
    ClassifyTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.titleLabel.textColor = UIColorHex(0xFC6465);
    cell.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    NSString * category_id = [NSString stringWithFormat:@"%@",self.tableDataArray[indexPath.row][@"category_id"]];
    self.category_id = category_id;
    [self getData:category_id];
    

    
    [self.tableView reloadData];
  
   
}
-(void)showEmptyView{
    self.emptyView.center = self.collectionView.center;
    [self.view addSubview:self.emptyView];
}


///////////////////////////////////////////

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;

}

//设置每个item的UIEdgeInsets

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
   
     return UIEdgeInsetsMake(10, 10, 10, 10);
}


// UICollectionViewCell最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0;
}
 
// UICollectionViewCell最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MallCell *cell = (MallCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"MallCell" forIndexPath:indexPath];
    MallModel * model = self.dataArray[indexPath.row];
    cell.model = model;
    cell.typeblock = ^{
        if ([model.gift_goods_type intValue] == 1) {
            [self.addCartDic setValue:model.goods_id forKey:@"goods_id"];
       [self.addCartDic setValue:@"1" forKey:@"goods_num"];
       [self.addCartDic setValue:@"0" forKey:@"spec_sku_id"];
       SureOrderVC * vc = [[SureOrderVC alloc]init];
       vc.type = DetailPush;
       vc.prmDic = self.addCartDic;
       [self.navigationController pushViewController:vc animated:YES];
            
        }else if ([model.gift_goods_type intValue] == 2){
        XinOrderPayVC * vc = [[XinOrderPayVC alloc]init];
        vc.gift_goods_id = [model.goods_id stringValue];
        vc.num = @"1";
        [self.navigationController pushViewController:vc animated:YES];
        }
 
    };
    return cell;

}


//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((ScreenWidth - 87 - 30) / 2, 238);

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodsDetailsVC * vc = [[GoodsDetailsVC alloc]init];
    MallModel * model = self.dataArray[indexPath.row];
    vc.goods_id = [model.goods_id stringValue];
    vc.typeStr = [model.gift_goods_type stringValue];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableView *)tableView{
    if (_leftTableView == nil) {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 87, ScreenHeight)];
        _leftTableView.delegate =self;
        _leftTableView.dataSource = self;
        _leftTableView.backgroundColor = UIColorHex(0xEEEEEE);
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftTableView.contentInset = UIEdgeInsetsMake(0, 0, SafeAreaTopHeight, 0);
        _leftTableView.showsVerticalScrollIndicator  = NO;
        _leftTableView.showsHorizontalScrollIndicator = NO;

    }
    return _leftTableView;
}



-(UICollectionView *)collectionView{
if (_collectionView == nil) {

        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        // 每一行cell之间的间距
        layout.minimumLineSpacing = 0;
         // 每一列cell之间的间距
          layout.minimumInteritemSpacing = 5;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(87, 0, ScreenWidth - 87, ScreenHeight) collectionViewLayout:layout];

        self.collectionView.backgroundColor = [UIColor whiteColor];
//        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(0);
//            make.left.mas_equalTo(87);
//            make.right.equalTo(0);
//            make.bottom.equalTo(self.view.mas_bottom).offset(0);
//             }];
                _collectionView.backgroundColor = [UIColor clearColor];
                [_collectionView registerNib:[UINib nibWithNibName:@"MallCell" bundle:nil] forCellWithReuseIdentifier:@"MallCell"];
                _collectionView.delegate = self;
                _collectionView.dataSource = self;
    
       }
      return _collectionView;
}


-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (NSMutableArray *)tableDataArray{
    if (_tableDataArray == nil) {
        _tableDataArray = [NSMutableArray array];
    }
    return _tableDataArray;
}

- (NSMutableDictionary *)addCartDic{
    if (!_addCartDic) {
        _addCartDic = [NSMutableDictionary dictionary];
    }
    return _addCartDic;
}
@end
