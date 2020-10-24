


//
//  AppraiseListCell.m
//  LYMallApp
//
//  Created by Mac on 2020/3/16.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "AppraiseListCell.h"
#import "AppraiseListCollectionCell.h"
#import "HZPhotoBrowser.h"
@interface AppraiseListCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    HZPhotoBrowser *browser;
}
@end

@implementation AppraiseListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _collectionView.delegate = self;
           _collectionView.dataSource = self;
           [_collectionView registerNib:[UINib nibWithNibName:@"AppraiseListCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"typeCellId"];
    [self.contentLabel setQmui_lineHeight:22];
    self.starView.tapEnabled = NO;
    self.starView.spacing = 0;
    
    
    
}

-(instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
       

    }
    return self;
}


- (void)setImagesArray:(NSArray *)imagesArray{
    _imagesArray = imagesArray;
}
///////////////////////////////////////////

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imagesArray.count;

}

//设置每个item的UIEdgeInsets

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
   
     return UIEdgeInsetsMake(0, 0, 0, 0);
}


// UICollectionViewCell最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}
 
// UICollectionViewCell最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}




- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AppraiseListCollectionCell *cell = (AppraiseListCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"typeCellId" forIndexPath:indexPath];
    if (self.imagesArray.count>0) {
        NSMutableArray * imgas = [NSMutableArray array];
        for (NSDictionary * dic in self.imagesArray) {
            [imgas addObject:dic[@"file_path"]];
        }
        [cell.goodsImageView sd_setImageWithURL:imgas[indexPath.row]];
    }
    
    return cell;

    }


//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake((ScreenWidth - 4 - 24) / 3, self.collectionView.qmui_height);

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    browser = [[HZPhotoBrowser alloc] init];
    browser.isFullWidthForLandScape = YES;
    browser.isNeedLandscape = YES;
    browser.currentImageIndex = (int)indexPath.row;
//    browser.imageArray = @[
//    @"http://ww2.sinaimg.cn/bmiddle/9ecab84ejw1emgd5nd6eaj20c80c8q4a.jpg",
//    @"http://ww2.sinaimg.cn/bmiddle/642beb18gw1ep3629gfm0g206o050b2a.gif",
//    @"http://ww4.sinaimg.cn/bmiddle/9e9cb0c9jw1ep7nlyu8waj20c80kptae.jpg",
//    @"http://ww3.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr1xydcj20gy0o9q6s.jpg",
//    @"http://ww2.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr2n1jjj20gy0o9tcc.jpg",
//    @"http://ww4.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr4nndfj20gy0o9q6i.jpg",
//    @"http://ww3.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr57tn9j20gy0obn0f.jpg",
//    @"http://ww2.sinaimg.cn/bmiddle/677febf5gw1erma104rhyj20k03dz16y.jpg",
//    @"http://ww4.sinaimg.cn/bmiddle/677febf5gw1erma1g5xd0j20k0esa7wj.jpg"
//    ];
    NSMutableArray * imgas = [NSMutableArray array];
    for (NSDictionary * dic in self.imagesArray) {
        [imgas addObject:dic[@"file_path"]];
    }
    browser.imageArray = imgas;
    [browser show];
    
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
