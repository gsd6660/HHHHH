//
//  MailGoodsVC.m
//  LYMallApp
//
//  Created by 科技 on 2020/4/28.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MailGoodsVC.h"
#import "PYPhotosView.h"
@interface MailGoodsVC ()<PYPhotosViewDelegate,TZImagePickerControllerDelegate,UITextFieldDelegate>
{
    NSString * urlString;
    NSArray * expressArray;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *guigeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UITextField *waybillTF;
@property (weak, nonatomic) IBOutlet QMUIButton *expressBtn;
@property (weak, nonatomic) IBOutlet PYPhotosView *photoView;
@property (nonatomic ,strong)NSMutableArray * photos;
@property (nonatomic ,strong)NSMutableArray * imageUrlArray;
@property(nonatomic,strong)NSMutableDictionary * parmDic;
@property(nonatomic,strong)NSMutableArray * expressList;
@end

@implementation MailGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"填写售后物流";
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.goodsDic[@"goods_img"]]];
    self.nameLabel.text = self.goodsDic[@"goods_name"];
     if ([self.goodsDic[@"goods_attr"] length] == 0) {
           self.guigeLabel.text = @"规格：此商品没有规格";
       }else{
           self.guigeLabel.text = [NSString stringWithFormat:@"规格：%@",self.goodsDic[@"goods_attr"]];
       }
    self.numLabel.hidden = YES;
    self.expressBtn.imagePosition = QMUIButtonImagePositionRight;
    self.photoView.images = nil;
     self.photoView.delegate = self;
     self.photoView.photosMaxCol = 3;
     self.photoView.imagesMaxCountWhenWillCompose = 3;
//      if (self.photos) {
//           [self.photoView reloadDataWithImages:self.photos];
//      }
    
    self.waybillTF.delegate = self;
    [self.expressBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [BRStringPickerView  showStringPickerWithTitle:@"选择快递公司" dataSource:self.expressList defaultSelValue:nil resultBlock:^(id selectValue) {
            [self.expressBtn setTitle:selectValue forState:0];
            [expressArray enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([selectValue isEqualToString:obj[@"express_name"]]) {
                    [self.parmDic setValue:obj[@"express_id"] forKey:@"express_id"];
                }
          }];
        }];
       
    }];
    [self loadExpressList];
}

- (void)loadExpressList{
    [NetWorkConnection postURL:@"api/order/express_lists" param:nil success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            NSLog(@"%@",responseJSONString);
            
            expressArray = responseObject[@"data"];
            [expressArray enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.expressList addObject:[NSString stringWithFormat:@"%@",obj[@"express_name"]]];
            }];
        }else{
            
        }
    } fail:^(NSError *error) {
        
    }];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.keyboardType = UIKeyboardTypeDefault;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.parmDic setValue:textField.text forKey:@"express_no"];
}


- (IBAction)submitClick:(id)sender {
    
    if (urlString.length>0) {
        [self.parmDic setValue:urlString forKey:@"images"];
    }
    [self.parmDic setValue:self.order_refund_id forKey:@"order_refund_id"];
    
    [self showEmptyViewWithLoading];
    [NetWorkConnection postURL:@"api/user.refund/delivery" param:self.parmDic success:^(id responseObject, BOOL success) {
        [self hideEmptyView];
        if (responseSuccess) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            ShowErrorHUD(responseMessage);
        }
    } fail:^(NSError *error) {
        [self hideEmptyView];
        ShowErrorHUD(@"服务器错误");
    }];
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
        [self.photoView reloadDataWithImages:weakSelf.photos];
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

- (NSMutableArray *)expressList{
    if (!_expressList) {
        _expressList = [NSMutableArray array];
    }
    return _expressList;
}


@end
