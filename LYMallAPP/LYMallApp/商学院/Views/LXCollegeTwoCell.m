//
//  LXCollegeTwoCell.m
//  LYMallApp
//
//  Created by gds on 2020/10/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LXCollegeTwoCell.h"
#import "LXCollegeTwoSubCell.h"
#import "LXCollegeTwoListVC.h"
@interface LXCollegeTwoCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation LXCollegeTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.moreBtn.imagePosition = QMUIButtonImagePositionRight;
    self.moreBtn.spacingBetweenImageAndTitle = 5;
    self.collection.delegate = self;
    self.collection.dataSource =self;
    YBDViewBorderRadius(self, 10);
    YBDViewBorderRadius(self.collection, 10);
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    [self.collection registerNib:[UINib nibWithNibName:@"LXCollegeTwoSubCell" bundle:nil] forCellWithReuseIdentifier:@"LXCollegeTwoSubCell"];
    
    [self.moreBtn addTarget:self action:@selector(pushVC) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)pushVC{
    [self.viewController.navigationController pushViewController:[LXCollegeTwoListVC new] animated:YES];
}

- (void)setFrame:(CGRect)frame{
    frame.size.width -=20;
    frame.origin.x = 10;
//    self.layer.cornerRadius = 25;
    [super setFrame:frame];
}


- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self.collection reloadData];
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LXCollegeTwoSubCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LXCollegeTwoSubCell" forIndexPath:indexPath];
    if (self.dataArray.count > 0) {
        NSDictionary * dic = self.dataArray[indexPath.row];
        NSDictionary * imges = dic[@"image"];
        
        cell.titleLabel.text = dic[@"article_title"];
        [cell.imgV sd_setImageWithURL:[NSURL URLWithString:imges[@"file_path"]]];
    }
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(102, 100);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
