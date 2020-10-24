//
//  HomeOneCell.m
//  TableViewDemo
//
//  Created by C C on 2020/3/9.
//  Copyright © 2020 CC. All rights reserved.
//

#import "HomeOneCell.h"
#import "HomeTypeCell.h"
#import "MallVC.h"
@interface HomeOneCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,XRCarouselViewDelegate>
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)NSArray * dataArray;
@property (nonatomic, strong) XRCarouselView *carouselView;
@property (nonatomic, strong)NSMutableArray * bannerArr;
@property (nonatomic, strong) NSMutableArray *categoryArry;//分类

@end


@implementation HomeOneCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
   if (self) {
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    
      
    self.bannerView = [[UIView alloc]init];
    self.bannerView.backgroundColor = kUIColorFromRGB(0xf5f5f5);
    [self.contentView addSubview:self.bannerView];
    
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
       make.height.equalTo(self.mas_width).multipliedBy(162.5/375.f);
    }];
 

    _carouselView = [[XRCarouselView alloc] init];
    [self.bannerView addSubview:_carouselView];

    [self.carouselView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    _carouselView.delegate = self;
    
    //设置占位图片,须在设置图片数组之前设置,不设置则为默认占位图
    _carouselView.placeholderImage = [UIImage imageNamed:@"placeholderImage.jpg"];
    //设置图片数组及图片描述文字
//    _carouselView.imageArray = self.bannerArr.count > 0 ? self.imageArray:arr;
//    _carouselView.describeArray = describeArray;
    //设置每张图片的停留时间，默认值为5s，最少为1s
    _carouselView.time = 3;
    //设置分页控件的图片,不设置则为系统默认
//    [_carouselView setPageImage:[UIImage imageNamed:@"other"] andCurrentPageImage:[UIImage imageNamed:@"current"]];
    
    //设置分页控件的位置，默认为PositionBottomCenter
    _carouselView.pagePosition = PositionBottomCenter;
    // 设置滑动时gif停止播放
    _carouselView.gifPlayMode = GifPlayModePauseWhenScroll;

    
    self.buttonView = [[UIView alloc] init];
    self.buttonView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.buttonView];

    [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(self.bannerView.mas_bottom);
       make.left.and.right.equalTo(self.bannerView);
       make.height.equalTo(self.mas_width).multipliedBy(205/375.f);

    }];
    
    
    
//    self.imageView = [[UIImageView alloc]init];
//    self.imageView.image = [UIImage imageNamed:@""];
//    [self.contentView addSubview:self.imageView];
//    
//    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//           make.top.equalTo(self.buttonView.mas_bottom);
//          make.left.equalTo(self.buttonView).offset(10);
//        make.right.equalTo(self.buttonView).offset(-10);
//        make.height.equalTo(self.mas_width).multipliedBy(0.22);;
//       }];


    self.dataArray = @[
      @{@"icon":@"all",@"title":@"全部"},
      @{@"icon":@"xiaomi",@"title":@"小米"},
      @{@"icon":@"mianfen",@"title":@"面粉"},
      @{@"icon":@"miantiao",@"title":@"果蔬苗条"},
      @{@"icon":@"fengmi",@"title":@"蜂蜜"},
      @{@"icon":@"putaojiu",@"title":@"葡萄酒"},
      @{@"icon":@"xiaomi",@"title":@"黄梨"},
      @{@"icon":@"chubu",@"title":@"粗布"}
    ];
    [self.collectionView reloadData];
    
 }
    return self;

}


-(void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    [self.bannerArr removeAllObjects];
    [self.categoryArry removeAllObjects];

    NSArray * banners = dataDic[@"banner"];
    for (NSDictionary *dic in banners) {
        [self.bannerArr addObject:dic[@"image"][@"file_path"]];
    }
     _carouselView.imageArray = self.bannerArr;
    
    NSArray * categorys = dataDic[@"category"];
    for (NSDictionary *dic in categorys) {
        [self.categoryArry addObject:dic];
    }
    [self.collectionView reloadData];
    
    NSDictionary * adv2 = dataDic[@"adv2"][@"image"];
    NSString * urlStr = adv2[@"file_path"];
    [self.imageView yy_setImageWithURL:[NSURL URLWithString:urlStr] placeholder:CCImage(@"meishi2")];
    
    
    
}



#pragma mark XRCarouselViewDelegate
- (void)carouselView:(XRCarouselView *)carouselView clickImageAtIndex:(NSInteger)index {
    NSLog(@"点击了第%ld张图片", index);
}


///////////////////////////////////////////

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.categoryArry.count > 0 ? self.categoryArry.count : self.dataArray.count;

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
    if (self.categoryArry.count > 0) {
        [cell setValuecationWithDataDic:self.categoryArry[indexPath.row]];

    }
    
    return cell;

    }


//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake((ScreenWidth - 50) / 4, (self.buttonView.qmui_height - 30) / 2);

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = self.categoryArry[indexPath.row];
    MallVC * vc = [[MallVC alloc]init];
    vc.title = @"商城";
    vc.category_id = [NSString stringWithFormat:@"%@",dic[@"category_id"]];
    [[self viewController].navigationController pushViewController:vc animated:YES];
}


-(UICollectionView *)collectionView{
if (_collectionView == nil) {

        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
           self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
              [self.contentView addSubview:self.collectionView];
              [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
             
            make.edges.equalTo(self.buttonView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));


             }];
                _collectionView.backgroundColor = [UIColor clearColor];
                [_collectionView registerNib:[UINib nibWithNibName:@"HomeTypeCell" bundle:nil] forCellWithReuseIdentifier:@"typeCellId"];
                _collectionView.delegate = self;
                _collectionView.dataSource = self;
                _collectionView.scrollEnabled = NO;
       }
      return _collectionView;
}


-(NSMutableArray *)bannerArr{
    if (_bannerArr == nil) {
        _bannerArr = [[NSMutableArray alloc]init];
    }
    return _bannerArr;
}
-(NSMutableArray *)categoryArry{
    if (_categoryArry == nil) {
        _categoryArry = [[NSMutableArray alloc]init];
    }
    return _categoryArry;
}

@end

