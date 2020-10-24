//
//  RefundRequestVC.m
//  LYMallApp
//
//  Created by 科技 on 2020/4/13.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "RefundRequestVC.h"
#import "MyOrderOneCell.h"
#import "RefundCell.h"
#import "PopBottomView.h"
#import "SelectImageCell.h"
#import <TZImagePickerController.h>
@interface RefundRequestVC ()<UITableViewDelegate,UITableViewDataSource,PYPhotosViewDelegate,TZImagePickerControllerDelegate,UITextFieldDelegate>
{
    NSDictionary * dataDic;
    NSArray * refundArray;
    NSString * urlString;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray * goodsArray;
@property(nonatomic,strong)PYPhotosView * publishPhotosView;
@property(nonatomic,strong)NSMutableArray * imageUrlArray;
@property(nonatomic,strong)NSMutableArray * photos;
@property(nonatomic,strong)NSMutableDictionary * parmDic;

@end
static NSString *cellTwoID = @"MyOrderOneCell";
static NSString * ReFundCellID = @"RefundCell";
static NSString * SelectCellID = @"SelectImageCell";
@implementation RefundRequestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请退款";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:ReFundCellID bundle:nil] forCellReuseIdentifier:ReFundCellID];
    [self.tableView registerNib:[UINib nibWithNibName:cellTwoID bundle:nil] forCellReuseIdentifier:cellTwoID];
    [self.tableView registerNib:[UINib nibWithNibName:SelectCellID bundle:nil] forCellReuseIdentifier:SelectCellID];
    [self loadData];
    [self refundReasonData];
    if (self.status == OrderStatusNotSend) {
        [self.parmDic setValue:@"1" forKey:@"order_status"];
    }else{
        [self.parmDic setValue:@"2" forKey:@"order_status"];
    }
    [self.parmDic setValue:self.order_id forKey:@"order_id"];
}

- (void)loadData{
    [self showEmptyViewWithLoading];
    [NetWorkConnection postURL:@"api/user.order/detail" param:@{@"order_id":self.order_id} success:^(id responseObject, BOOL success) {
        [self hideEmptyView];
        if (responseSuccess) {
            dataDic = responseObject[@"data"][@"order"];
            self.goodsArray = dataDic[@"goods"];
            [self.tableView reloadData];
        }else{
            ShowErrorHUD(responseMessage);
        }
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        
        
    }];
}

- (void)refundReasonData{
    [self showEmptyViewWithLoading];
    [NetWorkConnection postURL:@"api/user.order/getRefundReason" param:nil success:^(id responseObject, BOOL success) {
        [self hideEmptyView];
        if (responseSuccess) {
            refundArray = responseObject[@"data"];
        }else{
            ShowHUD(responseMessage);
        }
    } fail:^(NSError *error) {
        
    }];
}

- (IBAction)submitClick:(id)sender {
    if (urlString.length>0) {
         [self.parmDic setValue:urlString forKey:@"images"];
     }
    if ([CheackNullOjb cc_isNullOrNilWithObject:self.parmDic[@"desc_id"]]) {
        ShowErrorHUD(@"请选择退款原因");
        return;
    }
    [NetWorkConnection postURL:@"api/user.refund/apply" param:self.parmDic success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            ShowHUD(responseMessage);
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            ShowErrorHUD(responseMessage);
        }
    } fail:^(NSError *error) {
        ShowErrorHUD(@"网络错误");
    }];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.goodsArray.count;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MyOrderOneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTwoID];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dicData = self.goodsArray[indexPath.row];
        return cell;
    }
    if (indexPath.section == 4) {
        SelectImageCell * cell = [tableView dequeueReusableCellWithIdentifier:SelectCellID];
        cell.publishPhotosView.images = nil;
        cell.publishPhotosView.delegate = self;
        cell.publishPhotosView.photosMaxCol = 3;
        cell.publishPhotosView.imagesMaxCountWhenWillCompose = 3;
        self.publishPhotosView = cell.publishPhotosView;
        if (self.photos) {
             [self.publishPhotosView reloadDataWithImages:self.photos];
        }
        return cell;
    }
    
    RefundCell * cell = [tableView dequeueReusableCellWithIdentifier:ReFundCellID];
    cell.descTF.enabled = NO;
    if (indexPath.section==1) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.descTF.text = @"请选择";
        cell.descTF.textAlignment = NSTextAlignmentRight;
        cell.titleLabel.text = @"退款原因";
    }else if(indexPath.section == 2){
        if (dataDic) {
            cell.descTF.text = [NSString stringWithFormat:@"￥%@",dataDic[@"pay_price"]];
        }
        cell.titleLabel.text = @"退款金额";
    }else{
        cell.descTF.enabled = YES;
        cell.titleLabel.text = @"退款说明";
        cell.descTF.placeholder = @"选填";
        cell.descTF.delegate = self;
    }
    return cell;

}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.parmDic setValue:textField.text forKey:@"apply_desc"];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        RefundCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        PopBottomView * view = [[PopBottomView alloc]initWithFrame:self.view.bounds withDataSource:refundArray];
        view.selectIndexClick = ^(NSIndexPath * _Nonnull indexPath) {
            NSLog(@"%@",indexPath);
            cell.descTF.text = refundArray[indexPath.row][@"text"];
            [self.parmDic setValue:refundArray[indexPath.row][@"value"] forKey:@"desc_id"];
        };
        [[UIApplication sharedApplication].keyWindow addSubview:view];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 107;
    }else if (indexPath.section == 4){
        return 140;
    } else{
        return 40;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1f;
    }else{
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

#pragma mark - PYPhotosViewDelegate
- (void)photosView:(PYPhotosView *)photosView didAddImageClickedWithImages:(NSMutableArray *)images{
    // 在这里做当点击添加图片按钮时，你想做的事。
    [self getPhotos];
}

-(void)getPhotos{
    MJWeakSelf;
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:3 - self.photos.count delegate:self];
    imagePickerVc.allowPickingVideo = NO;
    
    imagePickerVc.barItemTextColor = [UIColor blackColor];
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets,BOOL isSelectOriginalPhoto){
        NSLog(@"photos===%@",photos);
        for (UIImage *image in photos) {
            NSData *iData = UIImageJPEGRepresentation(image, 0.5);
            [weakSelf extracted:image iData:iData];
        }
        [weakSelf.photos addObjectsFromArray:photos];
        [self.publishPhotosView reloadDataWithImages:weakSelf.photos];
    }];
    [weakSelf presentViewController:imagePickerVc animated:YES completion:nil];
}


- (void)extracted:(UIImage *)headImage iData:(NSData *)iData {
    MJWeakSelf;
    [NetWorkConnection uploadPost:@"api/upload/image"  parameters:@{@"iFile":iData} name:@"iFile" UploadImage:headImage success:^(id responseObject, BOOL success) {
        NSLog(@"商品图片====%@",responseObject);
        if (responseSuccess) {
            NSString *imageUrl = responseObject[@"data"][@"file_id"];
            [weakSelf.imageUrlArray addObject:imageUrl];
            NSLog(@"图片呢=====%@",weakSelf.imageUrlArray);
            urlString = [weakSelf.imageUrlArray componentsJoinedByString:@","];
//            [self.tableView reloadData];
//            [self.parmDic setValue:urlString forKey:@"images"];
        }else{
            [QMUITips showError:responseMessage];
            
        }
    } failure:^(NSError *error) {
        
    }];
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

- (NSMutableDictionary *)parmDic{
    if (!_parmDic) {
        _parmDic = [NSMutableDictionary dictionary];
    }
    return _parmDic;
}

@end
