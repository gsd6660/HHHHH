//
//  MyFourCell.m
//  LYMallApp
//
//  Created by Mac on 2020/3/27.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MyFourCell.h"
#import "MyCollectionCell.h"
#import "LyInfoVC.h"
#import "SetVC.h"
#import "APPIntroduceVC.h"
#import "MyTeamVC.h"
#import "MySubscriptiveVC.h"
#import "UsingHelpVC.h"
#import "InviteFriendsVC.h"
#import "ManagerVC.h"
#import "CouponVC.h"
#import "MySubscriptivePopView.h"
#import "RegisterMemberVC.h"
#import "ActivateMemberTwoVC.h"
@interface MyFourCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)NSMutableArray * dataArray;

@end
@implementation MyFourCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.dataArray = [[NSMutableArray alloc]init];
    
    [self.dataArray addObject:@{@"icon":@"jft_but_order",@"title":@"我的订购"}];
    [self.dataArray addObject: @{@"icon":@"jft_but_team",@"title":@"我的团队"}];
    [self.dataArray addObject: @{@"icon":@"jft_but_share",@"title":@"我的分享"}];
    [self.dataArray addObject: @{@"icon":@"jft_icon_coupon",@"title":@"我的优惠券"}];
    [self.dataArray addObject: @{@"icon":@"jft_but_usehelp",@"title":@"使用帮助"}];
    [self.dataArray addObject: @{@"icon":@"jft_but_longyuan",@"title":@"隆源农业"}];
    [self.dataArray addObject: @{@"icon":@"jft_but_securitysetting",@"title":@"安全设置"}];
    
    if (self.is_show_sigend == YES) {
        [self.dataArray addObject: @{@"icon":@"jft_but_managemententrance",@"title":@"管理入口"}];

    }
    [self.dataArray addObject: @{@"icon":@"jft_but_registeredmember",@"title":@"注册会员"}];
    [self.dataArray addObject: @{@"icon":@"jft_but_activation",@"title":@"激活会员"}];

    
        [self.collectionView reloadData];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"MyCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"typeCellId"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = NO;
    
    self.bgView.layer.shadowColor = [UIColor colorWithRed:109/255.0 green:106/255.0 blue:106/255.0 alpha:0.11].CGColor;
           self.bgView.layer.shadowOffset = CGSizeMake(0,1);
           self.bgView.layer.shadowOpacity = 1;
           self.bgView.layer.shadowRadius = 5;
           self.bgView.layer.cornerRadius = 5;
    
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
         return UIEdgeInsetsMake(0, 0, 0, 0);
    }


    // UICollectionViewCell最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
    {
        return 5;
    }
     
    // UICollectionViewCell最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
    {
        return 5;
    }




- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionCell *cell = (MyCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"typeCellId" forIndexPath:indexPath];
    [cell setValuecationWithDataDic:self.dataArray[indexPath.row]];
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((ScreenWidth - 100) / 4, 80);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        if (self.is_periods == NO) {
//            ShowErrorHUD(@"你还没订阅商品，请前往商品列表购买");
            [self CreatMySubscriptivePopView];
            return;
        }
        MySubscriptiveVC * vc = [[MySubscriptiveVC alloc]init];
        [[self viewController].navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 1) {
        MyTeamVC * vc = [[MyTeamVC alloc]init];
        [[self viewController].navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 2) {
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]; //登录时候返回token
            NSLog(@"token====%@",token);
        
        if (token.length ==0) {
            token = @"";
        }
        InviteFriendsVC * vc = [[InviteFriendsVC alloc]init];
//        vc.urlString = [NSString stringWithFormat:@"http://longyuan.demo.altjia.com/wap/invite/index?Authorization=%@",token];
        [[self viewController].navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.row == 3) {
        CouponVC * VC=  [[CouponVC alloc]init];
        [self.viewController.navigationController pushViewController:VC animated:YES];
    }
    if (indexPath.row == 4) {
        UsingHelpVC * vc = [[UsingHelpVC alloc]init];
        [[self viewController].navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 5) {
//           APPIntroduceVC * vc = [[APPIntroduceVC alloc]init];
//           [[self viewController].navigationController pushViewController:vc animated:YES];
        LyInfoVC * vc = [[LyInfoVC alloc]init];
        [[self viewController].navigationController pushViewController:vc animated:YES];
       }
    if (indexPath.row == 6) {
        SetVC * vc = [[SetVC alloc]init];
        [[self viewController].navigationController pushViewController:vc animated:YES];
    }
    
    if (self.is_show_sigend == YES) {
        if (indexPath.row == 7) {
            ManagerVC * vc = [[ManagerVC alloc]init];
            [[self viewController].navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 8) {
            RegisterMemberVC * vc = [[RegisterMemberVC alloc]init];
            [[self viewController].navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 9) {
            ActivateMemberTwoVC * vc = [[ActivateMemberTwoVC alloc]init];
            [[self viewController].navigationController pushViewController:vc animated:YES];
        }
        
    }else{
       
        if (indexPath.row == 7) {
            RegisterMemberVC * vc = [[RegisterMemberVC alloc]init];
            [[self viewController].navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 8) {
            ActivateMemberTwoVC * vc = [[ActivateMemberTwoVC alloc]init];
            [[self viewController].navigationController pushViewController:vc animated:YES];
        }
    }
    
    
    
    
}


-(void)CreatMySubscriptivePopView{
    MySubscriptivePopView *popView = [[[NSBundle mainBundle] loadNibNamed:@"MySubscriptivePopView" owner:self options:nil] lastObject];
    QMUIModalPresentationViewController *modalViewController = [[QMUIModalPresentationViewController alloc] init];
    
    modalViewController.contentView = popView;
    modalViewController.onlyRespondsToKeyboardEventFromDescendantViews = YES;

    modalViewController.dimmingView.userInteractionEnabled = YES;
    
    modalViewController.animationStyle = 1;
    [modalViewController showWithAnimated:YES completion:nil];
    [popView.seeButn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [modalViewController hideWithAnimated:YES completion:nil];
    }];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
