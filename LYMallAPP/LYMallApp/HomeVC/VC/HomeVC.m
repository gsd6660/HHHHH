
//
//  HomeVC.m
//  LYMallApp
//
//  Created by Mac on 2020/3/10.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "HomeVC.h"
#import "RecommentModel.h"
#import "HomeOneCell.h"
#import "HomeTowCell.h"
#import "HomeThreeCell.h"
#import "HomeFourCell.h"
#import "CollectionHeaderView.h"
#import "CollectionFooterView.h"
#import "GoodsDetailsVC.h"
#import "GroupViewController.h"
#import "ChatMeassageVC.h"
#import "MessageListVC.h"
#import "HomePartitionCell.h"
#import "UpdateAppPopView.h"//更新视图
@interface HomeVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * recommentArray;
@property(nonatomic,strong)NSDictionary * dataDic;//数据源
@property (nonatomic,assign)NSInteger force_update;
@property (nonatomic, strong)UpdateAppPopView*popView;

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.navigationController.title = @"隆源商城";
    self.view.backgroundColor = kUIColorFromRGB(0xFFFFFF);
    [self.view addSubview:self.collectionView];
    self.navigationItem.rightBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"message"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(messageButnAction)];
    
    [self getHomeData];
    [self getRecommendData];
    MJWeakSelf;
    self.collectionView.mj_header =  [YMRefreshHeader headerWithRefreshingBlock:^{
            [weakSelf getHomeData];
        [weakSelf getRecommendData];
    }];
 
}






-(void)getHomeData{
    [NetWorkConnection postURL:@"api/index/index" param:nil success:^(id responseObject, BOOL success) {
        NSLog(@"首页数据==%@",responseJSONString);
        if (responseSuccess) {
            self.dataDic = responseObject[@"data"];
            [self.collectionView reloadData];
            [self.collectionView.mj_header endRefreshing];

        }
    } fail:^(NSError *error) {
        [self.collectionView.mj_header endRefreshing];

    }];
}
//推荐商品数据

-(void)getRecommendData{
    [NetWorkConnection postURL:@"api/index/recommend" param:nil success:^(id responseObject, BOOL success) {
        NSLog(@"推荐商品数据==%@",responseJSONString);
        if (responseSuccess) {
            NSArray * data = responseObject[@"data"][@"list"][@"data"];
            for (NSDictionary *dic in data) {
                RecommentModel * model = [RecommentModel mj_objectWithKeyValues:dic];
                [self.recommentArray addObject:model];
            }
            [self.collectionView reloadData];
            [self.collectionView.mj_header endRefreshing];

        }
    } fail:^(NSError *error) {
        [self.collectionView.mj_header endRefreshing];

    }];
}



-(void)messageButnAction{
    NSLog(@"点击消息");
    MessageListVC * vc = [[MessageListVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    if (section == 0 || section == 1) {
//        return 1;
//    }
    
    if (section == 2) {
         return self.recommentArray.count;
    }
    
//    if (section == 3) {
//        if (self.dataDic[@"sharing_goods"]!=[NSNull null]) {
//            return 1;
//        }else{
//            return 0;
//        }
//    }
    return 1;

}

//设置每个item的UIEdgeInsets

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
     return UIEdgeInsetsMake(0, 10, 0, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        HomeOneCell *cell = (HomeOneCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
        cell.dataDic = self.dataDic;
        return cell;
    }
    if (indexPath.section == 1) {
        HomePartitionCell *cell = (HomePartitionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"PartitionCell" forIndexPath:indexPath];
//        cell.dataDic = self.dataDic;
        return cell;
    }else {
        
        HomeFourCell *cell = (HomeFourCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellFourId" forIndexPath:indexPath];
        RecommentModel * model = self.recommentArray[indexPath.row];
        cell.model = model;
        
        return cell;
        
//
    }
    
//    if (indexPath.section == 3) {
//         HomeThreeCell *cell = (HomeThreeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellthreeId" forIndexPath:indexPath];
//        if (self.dataDic[@"sharing_goods"]!=[NSNull null]) {
//            cell.sharing_goods = self.dataDic[@"sharing_goods"];
//        }
//        return cell;
//       }
//
//    HomeTowCell *cell = (HomeTowCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellTwoId" forIndexPath:indexPath];
//    cell.dataDic = self.dataDic;
//    return cell;
}

// 添加一个补充视图(页眉或页脚)
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
   if ([kind isEqual:UICollectionElementKindSectionHeader])
   {
     CollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifierCollectionHeader forIndexPath:indexPath];
   
    return headerView;
   } else if ([kind isEqual:UICollectionElementKindSectionFooter])
       {
           CollectionFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifierCollectionFooter forIndexPath:indexPath];
           return footerView;
       }
    return nil;
}


//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(ScreenWidth, kWithSP(364));
    }else if (indexPath.section == 1){
        return CGSizeMake(ScreenWidth, 160);
    }else if (indexPath.section == 2){
        if (ScreenWidth == 320) {
        return CGSizeMake(((ScreenWidth - 21) / 2), 264);
           }else if (ScreenWidth == 375) {
        return CGSizeMake(((ScreenWidth - 21) / 2), 290);
           }
        return CGSizeMake(((ScreenWidth - 21) / 2), 310);
       
    }
//    else if (indexPath.section == 3){
//        return CGSizeMake(ScreenWidth, 190);
//    }
    
    return CGSizeMake(ScreenWidth, 161);


}


// 设定页眉的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return CGSizeMake(ScreenWidth, 45);
    }
    return CGSizeMake(ScreenWidth, 0);
}

// 设定页脚的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//    if (section == 4) {
//        return CGSizeMake(ScreenWidth, 0);
//
//    }
    return CGSizeMake(ScreenWidth, 0);
}



// UICollectionView被选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0){
       
    }
    if (indexPath.section == 2) {
        RecommentModel * model = self.recommentArray[indexPath.row];
        GoodsDetailsVC * vc = [GoodsDetailsVC new];
        vc.typeStr = @"1";

        vc.goods_id = [NSString stringWithFormat:@"%@",model.goods_id];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}




-(void)getJPUSHService{
    
    NSString *  registrationID =  [JPUSHService registrationID];
    if (registrationID.length > 0) {
        [NetWorkConnection postURL:@"api/user/set_jpushid" param:@{@"registration_id":registrationID} success:^(id responseObject, BOOL success) {
            NSLog(@"推送ID上传成功");
        } fail:^(NSError *error) {
            
        }];
    }
    
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self getJPUSHService];

    [self updateApp];
}

#pragma mark 版本更新
-(void)updateApp{
    
    [NetWorkConnection postURL:@"api/index/version" param:nil success:^(id responseObject, BOOL success) {
        NSLog(@"版本更新===%@",responseObject);
        if ([responseObject[@"code"] integerValue] == 1) {
            self.force_update = [responseObject[@"data"][@"force_update"]integerValue ];
            NSString *appStoreVersion = [responseObject[@"data"][@"ios_version"] stringByReplacingOccurrencesOfString:@"." withString:@""];
            float newVersionFloat = [appStoreVersion floatValue];//新发布的版本号
            NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
            currentVersion = [currentVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
            float currentVersionFloat = [currentVersion floatValue];//使用中的版本号
            
            //当前版本小于App Store上的版本&用户未点击不再提示
            if (currentVersionFloat < newVersionFloat)
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    NSURL *url =  [NSURL URLWithString:responseObject[@"data"][@"ios_url"]];
                    //                    [self creatPopView:url dec:responseObject[@"data"][@"app_desc"]];
                    
                    [self updateAppView:url content:responseObject[@"data"][@"app_desc"]];
                    
                    
                });
            }
        }
    } fail:^(NSError *error) {
        
    }];
    
    
    
}
#pragma mark 版本更新
-(void)updateAppView:(NSURL *)url content:(NSString *)content{
    
    
    QMUIModalPresentationViewController *modalViewController = [[QMUIModalPresentationViewController alloc] init];
    
    modalViewController.contentView = self.popView;
    modalViewController.onlyRespondsToKeyboardEventFromDescendantViews = YES;
    //强制绑定 不能退出
    if (self.force_update == 0) {
        modalViewController.dimmingView.userInteractionEnabled = YES;
        self.popView.colseBlock = ^{
            [modalViewController hideWithAnimated:YES completion:nil];
        };
    }else{
        modalViewController.dimmingView.userInteractionEnabled = NO;
    }
    
    modalViewController.animationStyle = 1;
    [modalViewController showWithAnimated:YES completion:nil];
    
    
    self.popView.updateBlock = ^{
        [modalViewController hideWithAnimated:YES completion:nil];
        [[UIApplication sharedApplication] openURL:url];
    };
    self.popView.contentLable.text = content;
    
}


-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
    
       UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];

    [self.view addSubview:_collectionView];
        _collectionView.backgroundColor = [UIColor clearColor];

    [_collectionView registerClass:[HomeOneCell class] forCellWithReuseIdentifier:@"cellId"];
    
    [_collectionView registerClass:[HomeThreeCell class] forCellWithReuseIdentifier:@"cellthreeId"];
        [_collectionView registerClass:[HomeFourCell class] forCellWithReuseIdentifier:@"cellFourId"];
    [_collectionView registerNib:[UINib nibWithNibName:@"HomeTowCell" bundle:nil] forCellWithReuseIdentifier:@"cellTwoId"];
        [_collectionView registerNib:[UINib nibWithNibName:@"HomePartitionCell" bundle:nil] forCellWithReuseIdentifier:@"PartitionCell"];

    //4.设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifierCollectionHeader];

    [self.collectionView registerClass:[CollectionFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifierCollectionFooter];


    
}
return _collectionView;
}
-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
-(NSMutableArray *)recommentArray{
    if (_recommentArray == nil) {
        _recommentArray = [[NSMutableArray alloc]init];
    }
    return _recommentArray;
}
-(UpdateAppPopView *)popView{
    if (_popView == nil) {
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"UpdateAppPopView" owner:nil options:nil];
        _popView = views[0];
        //        _popView.closeBlock = ^(NSInteger index) {
        //            if (index == 1)
        //            {
        //                NSLog(@"跳转");
        //            }
        //            [selfWeak.actionSheet close];
        //        };
    }
    return _popView;
}



@end
