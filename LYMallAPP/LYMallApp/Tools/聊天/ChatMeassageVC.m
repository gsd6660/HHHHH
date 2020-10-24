//
//  ChatMeassageVC.m
//  TSYCAPP
//
//  Created by Mac on 2019/9/10.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "ChatMeassageVC.h"
#import "SendModel.h"
#import "ZQChatCell.h"
#import "WebSocketManager.h"
#import "ZQChatImgCell.h"
@interface ChatMeassageVC () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,WebSocketManagerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate>
{
    NSDictionary * _memberDic;
    NSDictionary * _serviceDic;
}
@property (nonatomic, strong) UITableView *chatTable;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UITextField *inputText;
@property (nonatomic, assign) CGFloat keyboardHeight;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,strong)UIButton * addImgBtn;
@end

@implementation ChatMeassageVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //TODO: 页面appear 禁用
    //    [[IQKeyboardManager sharedManager] setEnable:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //TODO: 页面Disappear 启用
    //    [[IQKeyboardManager sharedManager] setEnable:YES];
    //    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    //    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[WebSocketManager shared]RMWebSocketClose];
    [WebSocketManager shared].delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
    self.title = @"我的客服";
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [[WebSocketManager shared] connectServer];
    [WebSocketManager shared].delegate = self;
    self.page = 1;
    [self getData];
    self.chatTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page++;
        [self getData];
    }];
}

- (void)getData{
    [NetWorkConnection postURL:@"api/customerservice/logs" param:@{@"page":@(self.page)} success:^(id responseObject, BOOL success) {
        NSLog(@"消息列表====%@",responseJSONString);
        if (responseSuccess) {
            if (self.dataArray.count>0) {
                [self.dataArray removeAllObjects];
            }
            NSArray * logArr = responseObject[@"data"][@"logs"];
            _memberDic = responseObject[@"data"][@"member"];
            _serviceDic = responseObject[@"data"][@"service"];
            NSMutableArray * logsArray = [NSMutableArray array];
            [logArr enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                SendModel * model = [SendModel mj_objectWithKeyValues:obj];
                [logsArray addObject:model];
                SendModel * model1 =[logsArray lastObject];
                if ([model.create_time isEqualToString:model1.create_time]) {
                    model.is_showTime = YES;
                }
            }];
            NSMutableIndexSet  *indexes = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(0, logsArray.count)];
            NSArray *reversedArray = [[logsArray reverseObjectEnumerator] allObjects];
            [self.dataArray insertObjects:reversedArray atIndexes:indexes];
            [self.chatTable reloadData];
            if (self.page == 1&& self.dataArray.count>0) {
                [self.chatTable scrollToRow:self.dataArray.count-1 inSection:0 atScrollPosition:UITableViewScrollPositionBottom animated:NO];
            }
            
            [self.chatTable.mj_header endRefreshing];
        }
    } fail:^(NSError *error) {
        
    }];
}

#pragma mark webSocketDelegate
- (void)webSocketManagerDidOpen:(SRWebSocket *)webSocket{
    [[WebSocketManager shared]sendDataToServer:[@{@"getway":@"member_login",@"key":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"],@"record_id":self.record_id}mj_JSONString]];
}

- (void)webSocketManagerDidReceiveMessageWithString:(NSString *)string{
    NSLog(@"接收消息----%@",string.mj_JSONString);
    NSDictionary * dic = [string jsonValueDecoded];
    if ([dic[@"flag"] isEqualToString:@"send_msg"]) {
        SendModel * model = [[SendModel alloc]init];
        model.record_id = [dic[@"record_id"]integerValue];
        model.from_side = [dic[@"from_side"]integerValue];
        model.content = dic[@"content"];
        model.type = [dic[@"type"] integerValue];
        model.create_time = [[NSDate date]stringWithFormat:@"今天 HH:mm"];
        SendModel * model1 =[self.dataArray lastObject];
        if ([model.create_time isEqualToString:model1.create_time]) {
            model.is_showTime = YES;
        }
        [self.dataArray addObject:model];
        [self.chatTable reloadData];
        
        [self.chatTable scrollToRow:self.dataArray.count-1 inSection:0 atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
    
}

- (void)setupSubViews {
    //    self.view.backgroundColor = UIColorHex(0x0f0f0f);
    self.chatTable = [[UITableView alloc] init];
    self.chatTable.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 60);
        self.chatTable.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    self.chatTable.delegate = self;
    self.chatTable.dataSource = self;
    self.chatTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.chatTable.allowsSelection = NO;
    [self.view addSubview:self.chatTable];
    self.chatTable.estimatedSectionFooterHeight = 0;
    self.chatTable.estimatedSectionHeaderHeight = 0;
    self.bottomView  = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.chatTable.frame), ScreenWidth, 60)];
    self.bottomView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.bottomView];
    self.inputText = [[UITextField alloc] init];
    self.inputText.frame = CGRectMake(20, 10, SCREEN_WIDTH-80, 40);
    self.inputText.returnKeyType = UIReturnKeySend;
    self.inputText.borderStyle = UITextBorderStyleRoundedRect;
    self.inputText.delegate = self;
    self.inputText.backgroundColor = [UIColor whiteColor];
    self.inputText.layer.cornerRadius = 5;
    [self.bottomView addSubview:self.inputText];
    self.addImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addImgBtn setBackgroundImage:CCImage(@"icon_tianjia") forState:0];
    self.addImgBtn.frame = CGRectMake(ScreenWidth - 50, 10, 30, 30);
    [self.bottomView addSubview:self.addImgBtn];
    MJWeakSelf;
    
    [self.addImgBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [weakSelf.inputText resignFirstResponder];
        [weakSelf upImage];
    }];
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SendModel * model = self.dataArray[indexPath.row];
    if (model.type == 2) {
        
        ZQChatImgCell * cell = [tableView dequeueReusableCellWithIdentifier:@"imgCell"];
        if (!cell) {
            cell = [[ZQChatImgCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"imgCell"];
        }
        cell.model1 = model;
        if (model.from_side == 2) {
            //            cell.iconIV.yy_imageURL = [NSURL URLWithString:_serviceDic[@"service_avatar"]];
            [cell.iconIV yy_setImageWithURL:[NSURL URLWithString:_serviceDic[@"service_avatar"]] placeholder:CCImage(@"jft_img_defaulthead")];
        }else{
            //            cell.iconIV.yy_imageURL = [NSURL URLWithString:_memberDic[@"member_avatar"]];
            [cell.iconIV yy_setImageWithURL:[NSURL URLWithString:_memberDic[@"member_avatar"]] placeholder:CCImage(@"jft_img_defaulthead")];
        }
        return cell;
    }else{
        ZQChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[ZQChatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.model1 = model;
        if (model.from_side == 2) {
            [cell.iconIV yy_setImageWithURL:[NSURL URLWithString:_serviceDic[@"service_avatar"]] placeholder:CCImage(@"jft_img_defaulthead")];
        }else{
            [cell.iconIV yy_setImageWithURL:[NSURL URLWithString:_memberDic[@"member_avatar"]] placeholder:CCImage(@"jft_img_defaulthead")];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //计算文字高度需和自定义cell内容尺寸同步
    SendModel *msgModel = self.dataArray[indexPath.row];
    if (msgModel.type == 2) {
       return 110;
    }else{
        CGSize labelSize = [msgModel.content boundingRectWithSize: CGSizeMake(SCREEN_WIDTH-160, MAXFLOAT)
                                                                 options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                                                              attributes: @{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                                                 context: nil].size;
               return labelSize.height+30;
    }
    
}

- (void)tableViewScrollToBottom {
    
    if (self.dataArray.count > 0) {
        [self.chatTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length>0) {
        NSLog(@"-----%@",textField.text);
        [[WebSocketManager shared]sendDataToServer:[@{@"getway":@"member_send_msg",@"key":[[NSUserDefaults standardUserDefaults]objectForKey:@"token"],@"record_id":self.record_id,@"type":@"1",@"content":textField.text,@"from_side":@"1"}mj_JSONString]];
        textField.text = @"";
    }else{
        ShowHUD(@"不能为空");
    }
    return YES;
}

- (void)upImage{
    
    
//    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择图片" style:MHSheetStyleDefault itemTitles:@[@"拍照",@"相册"]];
//    actionSheet.titleTextFont = [UIFont systemFontOfSize:15];
//    actionSheet.itemTextFont = [UIFont systemFontOfSize:18];
//    actionSheet.cancleTextFont = [UIFont systemFontOfSize:16];
//    actionSheet.titleTextColor = kUIColorFromRGB(0x696969);
//    actionSheet.itemTextColor = kUIColorFromRGB(0x696969);
//    actionSheet.cancleTextColor = [UIColor blackColor];
//    __weak typeof(self) weakSelf = self;
//    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
//        if (index == 1) {
//            //相册权限
//            //            [weakSelf openImagePickerControllerWithType:1];
//            [self TZImage];
//        }else if (index == 0) {
//            [weakSelf openImagePickerControllerWithType:0];
//        }
//    }];
    MJWeakSelf;
    [self showPicker:YES completion:^(UIImage *image) {
//        weakSelf.userImageView.image = image;
        [weakSelf updateImage:image];

       }];
}

- (void)TZImage{
    MJWeakSelf;
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    imagePickerVc.barItemTextColor = [UIColor blackColor];
    imagePickerVc.allowPickingVideo = NO;
    
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets,BOOL isSelectOriginalPhoto){
        NSLog(@"photos===%@",photos);
        for (UIImage *image in photos) {
            NSData *iData = UIImageJPEGRepresentation(image, 0.5);
            [weakSelf extracted:image iData:iData];
        }
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark =============== 选择照相或照相 ===============
// 打开ImagePickerController的方法
- (void)openImagePickerControllerWithType:(int)type
{
    
    if(type == 0)
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            type = UIImagePickerControllerSourceTypeCamera;
        }
        
        
    }else{
        type = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
    }
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    
    //    imagePickerController.allowsEditing = YES;
    
    imagePickerController.sourceType = type;
    
    [self presentViewController:imagePickerController animated:YES completion:^{}];
    
}
//选择某个图片时系统调用代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //获取照片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //获取 行 区的cell
    
    NSData *data;   //转化为二进制
    if (UIImagePNGRepresentation(image)==nil){
        data = UIImageJPEGRepresentation(image, 0.1);
    }else{
        data =UIImagePNGRepresentation(image);
    }
    [self updateImage:image];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
}
//取消选择图片时系统调用代理方法
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)extracted:(UIImage *)headImage iData:(NSData *)iData {
    [NetWorkConnection uploadPost:@"api/upload/image"  parameters:@{@"iFile":iData} name:@"iFile" UploadImage:headImage success:^(id responseObject, BOOL success) {
        NSLog(@"图片====%@",responseObject);
        if(responseDataSuccess){
            //            [self.upImageBtn setImage:headImage forState:0];
            NSString *  imgeUrl = responseObject[@"data"][@"file_path"];
            [[WebSocketManager shared]sendDataToServer:[@{@"getway":@"member_send_msg",@"key":[[NSUserDefaults standardUserDefaults]objectForKey:@"token"],@"record_id":self.record_id,@"type":@"2",@"content": imgeUrl}mj_JSONString]];
            
        }else{
            [QMUITips showError:responseMessage];
        }
    } failure:^(NSError *error) {
        
    }];
}



-(void)updateImage:(UIImage *)headImage{
    
    NSData *iData = UIImageJPEGRepresentation(headImage, 0.5);
    [self extracted:headImage iData:iData];
    
}


- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


@end

