//
//  CommentVC.m
//  LYMallApp
//
//  Created by 科技 on 2020/4/16.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "CommentVC.h"
#import "MyOrderOneCell.h"
#import "CommentOneCell.h"
#import <TZImagePickerController.h>
#import "CommentTwoCell.h"
@interface CommentVC ()<UITableViewDelegate,UITableViewDataSource,PYPhotosViewDelegate,TZImagePickerControllerDelegate,QMUITextViewDelegate>
{
    NSArray * _titleArray;
    NSString * urlString;
}
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)PYPhotosView * publishPhotosView;
@property(nonatomic,strong)NSMutableArray * imageUrlArray;
@property(nonatomic,strong)NSMutableArray * photos;
@property(nonatomic,strong)NSMutableDictionary * photosDic;
@property(nonatomic,strong)QMUIButton * submitBtn;
@property(nonatomic,strong)NSArray * goodsArray;

@property(nonatomic,strong)NSMutableDictionary * parmDic;
@property(nonatomic,strong)NSMutableDictionary * sectionDic;


@end

static NSString * cellID = @"MyOrderOneCell";
static NSString * commentCell = @"CommentOneCell";
@implementation CommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发表评价";
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
    _titleArray = @[@"商品符合度",@"服务态度",@"物流服务"];
    [self.view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(35);
        make.bottom.equalTo(self.view.mas_bottom).offset(- kBottomSafeHeight -10);
    }];
    MJWeakSelf;
    [self.submitBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [weakSelf submitClick];
    }];
    [self loadData];
}

- (void)submitClick{
    NSLog(@"====%@",self.sectionDic);
    NSLog(@"====%@",self.parmDic);
    NSMutableDictionary * requestDic = [NSMutableDictionary dictionary];
    NSMutableArray * arr = [NSMutableArray array];
    for (int i = 0; i<self.goodsArray.count; i++) {
        NSDictionary * dic = self.parmDic[[NSString stringWithFormat:@"%d",i]];
        [arr addObject:dic];
//        [self.parmDic removeObjectForKey:[NSString stringWithFormat:@"%d",i]];
    }
    if (arr.count != self.goodsArray.count) {
        ShowErrorHUD(@"请填写商品评价");
        return;
    }
    if (self.imageUrlArray.count == 0) {
        [self.sectionDic setValue:@"" forKey:@"uploaded"];
    }
    
    [requestDic setValue:arr.mj_JSONString forKey:@"goods_eveluate"];
    [requestDic setValue:self.parmDic[@"order_id"] forKey:@"order_id"];
    [requestDic setValue:self.parmDic[@"conformity_goods"] forKey:@"conformity_goods"];
    [requestDic setValue:self.parmDic[@"service_attitude"] forKey:@"service_attitude"];
    [requestDic setValue:self.parmDic[@"logistics_service"] forKey:@"logistics_service"];
    
    [requestDic setValue:self.gift_order_type forKey:@"gift_order_type"];

 
    [self showEmptyViewWithLoading];
    [NetWorkConnection postURL:@"api/user.comment/submit_evaluate" param:requestDic success:^(id responseObject, BOOL success) {
        [self hideEmptyView];
        if (responseSuccess) {
            ShowHUD(responseMessage);
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            ShowErrorHUD(responseMessage);
        }
    } fail:^(NSError *error) {
        [self hideEmptyView];
        ShowErrorHUD(@"网络错误");
    }];
}


//加载订单数据
- (void)loadData{
    [self showEmptyViewWithLoading];
    [NetWorkConnection postURL:@"api/user.comment/order" param:@{@"order_id":self.order_id} success:^(id responseObject, BOOL success) {
        [self hideEmptyView];
        if (responseSuccess) {
            NSLog(@"====%@",responseJSONString);
            self.goodsArray = responseObject[@"data"][@"goodsList"];
            [self.tableView reloadData];
        }else{
            ShowErrorHUD(responseMessage);
        }
    } fail:^(NSError *error) {
        [self hideEmptyView];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == self.goodsArray.count) {
        return 3;
    }
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.goodsArray.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == self.goodsArray.count) {
        return 50;
    }else{
        if (indexPath.row == 0) {
            return 100;
        }else{
            return 200;
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == self.goodsArray.count) {
        CommentTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell"];
        if (!cell) {
            cell = [[CommentTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"twoCell"];
        }
        cell.indexPath = indexPath;
        cell.tipLabel.text = _titleArray[indexPath.row];
        cell.selectStar = ^(NSInteger count, NSIndexPath * _Nonnull indexPath) {
            NSLog(@"%ld----%@",(long)count,indexPath);
            if (indexPath.row == 0) {
                [self.parmDic setValue:@(count) forKey:@"conformity_goods"];
            }else if (indexPath.row == 1){
                [self.parmDic setValue:@(count) forKey:@"service_attitude"];
            }else{
                [self.parmDic setValue:@(count) forKey:@"logistics_service"];
            }
        };
        return cell;
    }else{
        if (indexPath.row == 0) {
            MyOrderOneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSDictionary * dic = self.goodsArray[indexPath.section];
            cell.dicData = dic;
            [self.parmDic setValue:dic[@"order_id"] forKey:@"order_id"];
            [self.sectionDic setValue:dic[@"goods_id"] forKey:@"goods_id"];
            [self.sectionDic setValue:dic[@"order_goods_id"] forKey:@"order_goods_id"];
            [self.parmDic setValue:self.sectionDic forKey:[NSString stringWithFormat:@"%ld",indexPath.section]];
            return cell;
        }else{
            CommentOneCell * cell = [tableView dequeueReusableCellWithIdentifier:commentCell];
            if (!cell) {
                cell = [[CommentOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:commentCell];
            }
            cell.indexPath = indexPath;
            cell.selectStarClick = ^(NSInteger count, NSIndexPath * _Nonnull indexPath) {
                 NSLog(@"%ld----%@",(long)count,indexPath);
                [self.sectionDic setValue:@(count) forKey:@"score"];
                [self.parmDic setValue:self.sectionDic forKey:[NSString stringWithFormat:@"%ld",indexPath.section]];
            };
            cell.textView.delegate = self;
            cell.textView.tag = 10000+indexPath.section;
            cell.photosView.delegate = self;
            cell.photosView.tag = 1000+indexPath.section;
            self.publishPhotosView = cell.photosView;
            if (self.photosDic) {
                NSString * tag = [NSString stringWithFormat:@"%ld",cell.photosView.tag];
                NSMutableArray * iamges = self.photosDic[tag];
                [self.publishPhotosView reloadDataWithImages:iamges];
            }
            //        [self.publishPhotosView reloadDataWithImages:weakSelf.photos];
            return cell;
        }
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    NSInteger tag = textView.tag - 10000;
    [self.sectionDic setValue:textView.text forKey:@"content"];
    [self.parmDic setValue:self.sectionDic forKey:[NSString stringWithFormat:@"%ld",tag]];
}

#pragma mark - PYPhotosViewDelegate
- (void)photosView:(PYPhotosView *)photosView didAddImageClickedWithImages:(NSMutableArray *)images{
    // 在这里做当点击添加图片按钮时，你想做的事。
    [self getPhotos:photosView.tag];
}

-(void)getPhotos:(NSInteger)tag{
    MJWeakSelf;
    NSString * tagStr = [NSString stringWithFormat:@"%ld",tag];
    NSMutableArray * imageArray = [NSMutableArray array];
    if (self.photosDic[tagStr]!=nil) {
        imageArray =  self.photosDic[tagStr];
    }
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:3 - imageArray.count delegate:self];
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.barItemTextColor = [UIColor blackColor];
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets,BOOL isSelectOriginalPhoto){
        NSLog(@"photos===%@",photos);
        for (UIImage *image in photos) {
            NSData *iData = UIImageJPEGRepresentation(image, 0.5);
            [weakSelf extracted:image iData:iData withindex:tag];
        }
        [imageArray addObjectsFromArray:photos];
        [self.photosDic setValue:imageArray forKey:[NSString stringWithFormat:@"%ld",(long)tag]];
        [self.publishPhotosView reloadDataWithImages:(NSMutableArray*)imageArray];
        [self.tableView reloadData];
    }];
    [weakSelf presentViewController:imagePickerVc animated:YES completion:nil];
}


- (void)extracted:(UIImage *)headImage iData:(NSData *)iData withindex:(NSInteger)index{
    MJWeakSelf;
    [NetWorkConnection uploadPost:@"api/upload/image"  parameters:@{@"iFile":iData} name:@"iFile" UploadImage:headImage success:^(id responseObject, BOOL success) {
        NSLog(@"商品图片====%@",responseObject);
        if (responseSuccess) {
            NSString *imageUrl = responseObject[@"data"][@"file_id"];
            [weakSelf.imageUrlArray addObject:imageUrl];
            NSLog(@"图片呢=====%@",weakSelf.imageUrlArray);
            urlString = [weakSelf.imageUrlArray componentsJoinedByString:@","];
            [self.sectionDic setValue:urlString forKey:@"uploaded"];
            [self.parmDic setValue:self.sectionDic forKey:[NSString stringWithFormat:@"%ld",index - 1000]];
//                        [self.tableView reloadData];
        }else{
            [QMUITips showError:responseMessage];
            [self.sectionDic setValue:@"" forKey:@"uploaded"];

        }
    } failure:^(NSError *error) {
        
    }];
}

- (NSMutableDictionary *)sectionDic{
    if (!_sectionDic) {
        _sectionDic = [NSMutableDictionary dictionary];
    }
    return _sectionDic;
}

- (NSMutableDictionary *)parmDic{
    if (!_parmDic) {
        _parmDic = [NSMutableDictionary dictionary];
    }
    return _parmDic;
}

- (NSMutableArray *)imageUrlArray{
    if (!_imageUrlArray) {
        _imageUrlArray = [NSMutableArray array];
    }
    return _imageUrlArray;
}

- (NSMutableArray *)photos{
    if(!_photos){
        _photos = [NSMutableArray array];
    }
    return _photos;
}

- (NSMutableDictionary *)photosDic{
    if (!_photosDic) {
        _photosDic = [NSMutableDictionary dictionary];
    }
    return _photosDic;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectInset(CGRectMake(0, 0, ScreenWidth, ScreenHeight - kBottomSafeHeight - 65), 10, 0) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = kUIColorFromRGB(0xf5f5f5);
    }
    return _tableView;
}

- (QMUIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"发布" forState:0];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:0];
        [_submitBtn setBackgroundColor:kUIColorFromRGB(0x3ACD7B)];
        _submitBtn.layer.cornerRadius = 17.5;
    }
    return _submitBtn;
}

@end
