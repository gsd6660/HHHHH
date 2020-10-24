//
//  CommitAppleyDataVC.m
//  LYMallApp
//
//  Created by Mac on 2020/4/18.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "CommitAppleyDataVC.h"
#import "CommitAppleyView.h"
#import "CommitAppleyDataCell.h"
@interface CommitAppleyDataVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)CommitAppleyView * topView;
@property(nonatomic,strong)UILabel * desLabel;
@property(nonatomic,strong)QMUIFillButton * butn;

@property(nonatomic,strong)NSString * addressStr;
@property(nonatomic,strong)NSString * apply_lv;

@end
static NSString * cellID = @"CommitAppleyDataCell";
@implementation CommitAppleyDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.apply_lv = @"0";
    self.topView = [[CommitAppleyView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth - 26, 200)];
    footView.backgroundColor = [UIColor whiteColor];
    QMUIFillButton * butn = [QMUIFillButton buttonWithType:UIButtonTypeCustom];
    butn.frame = CGRectMake(13, 64, footView.width - 26 , 40);
    [butn setTitle:@"提交" forState:UIControlStateNormal];
    [butn addTarget:self action:@selector(commitButn:) forControlEvents:UIControlEventTouchUpInside];
    self.butn = butn;
    [footView addSubview:butn];
    self.desLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, butn.bottom + 34, footView.width - 30, 44)];
    self.desLabel.numberOfLines = 0;
    self.desLabel.font = [UIFont systemFontOfSize:15];
    self.desLabel.textColor = kUIColorFromRGB(0x666666);
    self.desLabel.textAlignment = NSTextAlignmentCenter;
    self.desLabel.hidden = YES;
    self.desLabel.text = @"感谢您对我们的认可，我们会尽快处理您的申请，请保持手机畅通";
    [self.desLabel setQmui_lineHeight:22];
    [footView addSubview:self.desLabel];
    self.tableView.tableFooterView = footView;
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];

}


-(void)commitButn:(UIButton *)butn{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

    CommitAppleyDataCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSLog(@"姓名====%@",cell.nameTF.text);
    NSLog(@"手机号====%@",cell.mobileTF.text);
    NSLog(@"地址====%@",cell.addressTF.text);
    if ([cell.nameTF.text qmui_trimAllWhiteSpace].length == 0) {
        ShowErrorHUD(cell.nameTF.placeholder);
        return;
    }if ([cell.mobileTF.text qmui_trimAllWhiteSpace].length == 0) {
        ShowErrorHUD(cell.mobileTF.placeholder);
        return;
    }if ([cell.addressTF.text qmui_trimAllWhiteSpace].length == 0) {
        ShowErrorHUD(cell.addressTF.placeholder);
        return;
    }if ([self.apply_lv intValue] == 0) {
        ShowErrorHUD(@"请选择您要申请的代理级别");
        return;
    }if ([self.addressStr length] == 0) {
        ShowErrorHUD(@"请选择您要申请的代理的地区");
        return;
    }
    
    [NetWorkConnection postURL:@"api/agency.apply/apply_agency" param:@{@"apply_name":cell.nameTF.text,@"phone":cell.mobileTF.text,@"place_detail_address":cell.addressTF.text,@"apply_lv":self.apply_lv,@"apply_address":self.addressStr} success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            ShowHUD(@"提交成功");
            self.desLabel.hidden = NO;
            self.butn.fillColor = kUIColorFromRGB(0xD6D6D6);
            self.butn.userInteractionEnabled = NO;
            [self.butn setTitle:@"您的申请已提交" forState:UIControlStateNormal];

        }else{
            ShowErrorHUD(responseMessage);
        }
    } fail:^(NSError *error) {
        
    }];
}

-(void)selectLevel:(CommitAppleyDataCell*)cell{
    /// 1.单列字符串选择器（传字符串数组）
    MJWeakSelf;
    BRStringPickerView *stringPickerView = [[BRStringPickerView alloc]initWithPickerMode:BRStringPickerComponentSingle];
    stringPickerView.title = @"代理级别";
    stringPickerView.dataSourceArr = @[@"省级",@"市级",@"区/县级"];
    stringPickerView.selectIndex = 0;
    stringPickerView.resultModelBlock = ^(BRResultModel *resultModel) {
        NSLog(@"选择的值：%@", resultModel.selectValue);
    [cell.levelButn setTitle:resultModel.selectValue forState:UIControlStateNormal];
        [cell.levelButn setTitleColor:kUIColorFromRGB(0x555555) forState:UIControlStateNormal];

        if ([resultModel.selectValue isEqualToString:@"省级"]) {
            weakSelf.apply_lv = @"1";

        }else if ([resultModel.selectValue isEqualToString:@"市级"]) {
            weakSelf.apply_lv = @"2";

        }else if ([resultModel.selectValue isEqualToString:@"区/县级"]) {
            weakSelf.apply_lv = @"3";
        }
    };

    [stringPickerView show];
}
-(void)selectArea:(CommitAppleyDataCell*)cell ShowType:(BRAddressPickerMode)showType{
    MJWeakSelf;
    [BRAddressPickerView showAddressPickerWithShowType:showType defaultSelected:nil isAutoSelect:YES themeColor:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
        if (showType == BRAddressPickerModeProvince) {
            [cell.areaButn setTitle:[NSString stringWithFormat:@"%@",province.name] forState:UIControlStateNormal];
            weakSelf.addressStr = province.name;

        }else if (showType == BRAddressPickerModeCity){
            [cell.areaButn setTitle:[NSString stringWithFormat:@"%@%@",province.name,city.name] forState:UIControlStateNormal];

            weakSelf.addressStr = [NSString stringWithFormat:@"%@,%@",province.name,city.name];
        }else if (showType == BRAddressPickerModeArea){
            [cell.areaButn setTitle:[NSString stringWithFormat:@"%@%@%@",province.name,city.name,area.name] forState:UIControlStateNormal];
            weakSelf.addressStr = [NSString stringWithFormat:@"%@,%@,%@",province.name,city.name,area.name];

        }
        [cell.areaButn setTitleColor:kUIColorFromRGB(0x555555) forState:UIControlStateNormal];
      } cancelBlock:^{
          NSLog(@"点击了背景视图或取消按钮");
      }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 235;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommitAppleyDataCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.levelButn.tag = 1001;
    cell.areaButn.tag = 1002;
    [cell.levelButn addTarget:self action:@selector(cellButnAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.areaButn addTarget:self action:@selector(cellButnAction:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 137;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   
    UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 120)];
    lable.text = @"申请资料";
    lable.font = [UIFont systemFontOfSize:19 weight:20];
    lable.textAlignment = NSTextAlignmentCenter;
    return lable;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)cellButnAction:(UIButton *)butn{
    CommitAppleyDataCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

    if (butn.tag == 1001) {
        [self selectLevel:cell];
    }else{
        if ([cell.levelButn.titleLabel.text isEqualToString:@"省级"]) {
            [self selectArea:cell ShowType:BRAddressPickerModeProvince];
        }else if ([cell.levelButn.titleLabel.text isEqualToString:@"市级"]) {
            [self selectArea:cell ShowType:BRAddressPickerModeCity];

        }else if ([cell.levelButn.titleLabel.text isEqualToString:@"区/县级"]) {
            [self selectArea:cell ShowType:BRAddressPickerModeArea];

        }else{
            ShowErrorHUD(@"请先选择代理级别");
        }
    }
}




-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectInset(CGRectMake(0, ScreenWidth > 414 ? 168 :96, ScreenWidth, ScreenHeight - 24), 13, 0) style:UITableViewStylePlain];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.layer.masksToBounds = YES;
        _tableView.layer.cornerRadius = 5;
        [_tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}


@end

