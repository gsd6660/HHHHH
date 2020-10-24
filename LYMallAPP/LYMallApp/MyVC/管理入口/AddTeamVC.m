//
//  AddTeamVC.m
//  LYMallApp
//
//  Created by Mac on 2020/4/26.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "AddTeamVC.h"

@interface AddTeamVC ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *mobileTF;
@property (weak, nonatomic) IBOutlet UIView *bgVIew;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@end

@implementation AddTeamVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.typeLabel.text = self.typeStr;
    self.title = self.typeStr;
    self.bgVIew.layer.shadowColor = [UIColor colorWithRed:109/255.0 green:106/255.0 blue:106/255.0 alpha:0.16].CGColor;
    self.bgVIew.layer.shadowOffset = CGSizeMake(0,1);
    self.bgVIew.layer.shadowOpacity = 1;
    self.bgVIew.layer.shadowRadius = 5;
    self.bgVIew.layer.cornerRadius = 5;
    
    
}
- (IBAction)sureButn:(UIButton *)sender {
    if ([self.mobileTF.text length] != 11) {
        ShowErrorHUD(@"请输入正确的手机号");
        return;
    }
    
    [NetWorkConnection postURL:@"api/signed.team/add_team" param:@{@"phone":self.mobileTF.text} success:^(id responseObject, BOOL success) {
        if (responseSuccess) {
            ShowHUD(responseMessage);
        }
        else{
            ShowErrorHUD(responseMessage);
        }
    } fail:^(NSError *error) {
        
    }];
    
    
}



@end
