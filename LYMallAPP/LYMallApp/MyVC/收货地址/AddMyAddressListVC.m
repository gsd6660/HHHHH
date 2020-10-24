//
//  AddMyAddressListVC.m
//  ZSWYAPP
//
//  Created by Mac on 2019/4/2.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "AddMyAddressListVC.h"
#import <BRPickerView.h>
@interface AddMyAddressListVC ()<QMUITextViewDelegate>
{
    NSString *_detailStr;
    NSString * _regionString;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UIButton *selectAddressButn;

@property (strong, nonatomic) QMUITextView *textView;
@property (weak, nonatomic) IBOutlet UIView *bgaddressView;


@property (weak, nonatomic) IBOutlet UISwitch *swithButn;


@property(nonatomic,strong)NSString *region;

@property(nonatomic,strong)NSString *province_name;
@property(nonatomic,strong)NSString *city_name;
@property(nonatomic,strong)NSString *area_name;

@property(nonatomic,strong)NSString *is_default;


@end

@implementation AddMyAddressListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.is_default = @"0";
    
    
    self.textView = [[QMUITextView alloc]initWithFrame:self.bgaddressView.bounds];
    self.textView.placeholder = @"请输入详细地址";
    
    [self.bgaddressView addSubview:self.textView];
    
    
    
    if (self.is_edit.length > 0) {
        self.title = @"编辑收货地址";
        [self getAddressData];
    }else{
        self.title = @"新增收货地址";
    }
    
    [self.swithButn addTarget:self
                      action:@selector
     (switchIsChanged:)
            forControlEvents:UIControlEventValueChanged];
    self.textView.delegate = self;
//    self.textView.placeholderColor = kUIColorFromRGB(0x9CA3AF);
//    self.phoneTF.placeholderColor = kUIColorFromRGB(0x9CA3AF);
//    self.nameTF.placeholderColor = kUIColorFromRGB(0x9CA3AF);
    
    [self.phoneTF addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    [self.nameTF addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    [self getAddList];
}


- (void)getAddList{
    [NetWorkConnection postURL:@"api/Area/area_json" param:nil success:^(id responseObject, BOOL success) {
        NSLog(@"地区=====%@",responseJSONString);
        
    } fail:^(NSError *error) {
        
    }];
}

- (void)textFieldChange:(UITextField*)textField{
    if (self.phoneTF.text.length>11) {
        self.phoneTF.text = [textField.text substringToIndex:11];
    }
    if (self.nameTF.text.length>20) {
        self.nameTF.text = [textField.text substringToIndex:20];
    }
}

- (BOOL)textViewShouldBeginEditing:(QMUITextView *)textView{
    textView.text = @"";
    return YES;
}

-(void)getAddressData{
    [NetWorkConnection postURL:@"api/address/detail" param:@{@"address_id":self.address_id} success:^(id responseObject, BOOL success) {
        if (responseDataSuccess) {
            NSLog(@"收货地址详情===%@",responseJSONString);
            NSDictionary *dic = responseObject[@"data"][@"detail"];
            self.nameTF.text = dic[@"name"];
            self.phoneTF.text = dic[@"phone"];
            _detailStr = dic[@"detail"];
            self.province_name = dic[@"region"][@"province"];
            self.area_name = dic[@"region"][@"region"];
            self.city_name = dic[@"region"][@"city"];
            NSString * addString = [responseObject[@"data"][@"region"] componentsJoinedByString:@" "];
            _regionString = [responseObject[@"data"][@"region"] componentsJoinedByString:@","];
             [self.selectAddressButn setTitle:addString forState:0];
            self.textView.text = _detailStr;
            if ([dic[@"is_default"] integerValue] == 1) {
                self.swithButn.on = YES;
            }else{
                self.swithButn.on = NO;
            }
        }
    } fail:^(NSError *error) {
        
    }];
}



- (IBAction)saveButn:(UIButton *)sender {
    
    if (self.nameTF.text.length == 0) {
        [QMUITips showInfo:self.nameTF.placeholder];
        return;
    }
    if (self.phoneTF.text.length == 0) {
        [QMUITips showInfo:self.phoneTF.placeholder];
        return;
    }
    if (_detailStr.length == 0) {
        [QMUITips showInfo:@"请选择所在地区"];
        return;
    }
    if (self.textView.text.length == 0) {
        [QMUITips showInfo:@"请输入详细地址"];
        return;
    }
    
    if (self.is_edit.length >0) {
        [NetWorkConnection postURL:@"api/address/edit" param:@{@"address_id":self.address_id,@"name":self.nameTF.text,@"phone":self.phoneTF.text,@"detail":self.textView.text,@"is_default":self.is_default,@"region":_regionString} success:^(id responseObject, BOOL success) {
            if (responseDataSuccess) {
                [QMUITips showSucceed:@"编辑成功"];
                self.block();
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [QMUITips showError:responseMessage];
            }
        } fail:^(NSError *error) {
            
        }];
    }else{
    
    [NetWorkConnection postURL:@"api/address/add" param:@{@"name":self.nameTF.text,@"phone":self.phoneTF.text,@"region":self.region,@"detail":self.textView.text,@"is_default":self.is_default} success:^(id responseObject, BOOL success) {
        if (responseDataSuccess) {
            [QMUITips showSucceed:@"添加成功"];
            if (self.block) {
                self.block();
                [self.navigationController popViewControllerAnimated:YES];

            }
        }else{
            [QMUITips showError:responseMessage];

        }
    } fail:^(NSError *error) {
        
    }];
    }
}

- (IBAction)selectAddressButn:(UIButton *)sender {
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    MJWeakSelf;
    [BRAddressPickerView showAddressPickerWithShowType:BRAddressPickerModeArea defaultSelected:nil isAutoSelect:YES themeColor:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
        [weakSelf.selectAddressButn setTitle:[NSString stringWithFormat:@"%@ %@ %@", province.name, city.name, area.name] forState:UIControlStateNormal];
        weakSelf.province_name = province.name;
        weakSelf.city_name = city.name;
        weakSelf.area_name = area.name;
        _detailStr = [NSString stringWithFormat:@"%@%@%@",province.name,city.name,area.name];
        weakSelf.region = [NSString stringWithFormat:@"%@,%@,%@",province.name,city.name,area.name];
    } cancelBlock:^{
        NSLog(@"点击了背景视图或取消按钮");
    }];
}
- (void) switchIsChanged:(UISwitch *)paramSender{
    NSLog(@"Sender is = %@", paramSender);
    
    if ([paramSender isOn]){
        NSLog(@"The switch is turned on.");
        self.is_default = @"1";

    } else {
        self.is_default = @"0";

        NSLog(@"The switch is turned off.");
    }
}
@end
