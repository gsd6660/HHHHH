//
//  LXTaskOneCell.m
//  LYMallApp
//
//  Created by gds on 2020/10/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXTaskOneCell.h"
#import "HomeTypeCell.h"
#import "LXRuleListViewController.h"

#import "CommitAppleyDataVC.h"

#import "MyPurseVC.h"
#import "MallVC.h"
#import "InviteFriendsVC.h"
#import "LXTaskOrderListVC.h"
#import "LXKeFuViewController.h"
#import "LXHZViewController.h"

@interface LXTaskOneCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) NSArray *dataArray;

@end

@implementation LXTaskOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor =UIColor.clearColor;
        YBDViewBorderRadius(self.collectionView, 10);
        self.dataArray = @[
          @{@"icon":@"section_one_1",@"title":@"获取银豆"},
          @{@"icon":@"section_one_2",@"title":@"银豆集市"},
          @{@"icon":@"section_one_3",@"title":@"规则说明"},
          @{@"icon":@"section_one_4",@"title":@"我的钱包"},
          @{@"icon":@"section_one_5",@"title":@"任务订单"},
          @{@"icon":@"section_one_6",@"title":@"商务合作"},
          @{@"icon":@"section_one_7",@"title":@"联系客服"},
          @{@"icon":@"section_one_8",@"title":@"邀请好友"}
        ];
        [self.collectionView reloadData];
    }
    return self;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
//        NSDictionary *dic = self.categoryArry[indexPath.row];
         MallVC * vc = [[MallVC alloc]init];
//         vc.title = @"商城";
//         vc.category_id = [NSString stringWithFormat:@"%@",dic[@"category_id"]];
         [[self viewController].navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.row == 1) {
        
    }
    
    if (indexPath.row == 2) {
        [self.viewController.navigationController pushViewController:[LXRuleListViewController new] animated:YES];
    }
    if (indexPath.row == 3) {
        MyPurseVC * vc = [MyPurseVC new];
        [self.viewController.navigationController pushViewController:vc animated:YES];
        
    }
    if (indexPath.row == 4) {
        LXTaskOrderListVC * vc = [LXTaskOrderListVC new];
        [self.viewController.navigationController pushViewController:vc animated:YES];
        
    }
    if(indexPath.row == 5){
        LXHZViewController * vc = [LXHZViewController new];
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
 
    
    if (indexPath.row == 6) {
        LXKeFuViewController * vc = [LXKeFuViewController new];
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
    
    
    if (indexPath.row == 7) {
        InviteFriendsVC * vc = [InviteFriendsVC new];
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
   
    
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;

}

//设置每个item的UIEdgeInsets

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
   
     return UIEdgeInsetsMake(0, 10, 10, 10);
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
    HomeTypeCell *cell = (HomeTypeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"typeCellId" forIndexPath:indexPath];
    if (self.dataArray.count > 0) {
//        [cell setValuecationWithDataDic:self.dataArray[indexPath.row]];
        NSDictionary * dic = self.dataArray[indexPath.row];
        cell.goodsImageView.image = [UIImage imageNamed:dic[@"icon"]];
        cell.goodsNameLabel.text = dic[@"title"];
    }
    
    return cell;
}


//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake((ScreenWidth - 70) / 4, 80);

}

-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.contentView addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(180);
        }];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"HomeTypeCell" bundle:nil] forCellWithReuseIdentifier:@"typeCellId"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = NO;
    }
    return _collectionView;
}

//- (void)setFrame:(CGRect)frame{
//    frame.size.width -=20;
//    frame.origin.x = 10;
////    self.layer.cornerRadius = 25;
//    [super setFrame:frame];
//}

@end
