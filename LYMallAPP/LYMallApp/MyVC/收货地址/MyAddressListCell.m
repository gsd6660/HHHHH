
//
//  MyAddressListCell.m
//  ZSWYAPP
//
//  Created by Mac on 2019/4/2.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "MyAddressListCell.h"
#import "AddressModel.h"
@implementation MyAddressListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.addressLable setQmui_lineHeight:15];
}

-(void)setModel:(AddressModel *)model{
    _model = model;
    
    NSString * addStr = [NSString stringWithFormat:@"%@%@%@%@",model.region[@"province"],model.region[@"city"],model.region[@"region"],model.detail];
    self.addressLable.text = addStr;
    if (model.name.length > 0 ) {
        self.nameLable.text = model.name;
    }
    
    if (model.phone.length > 0 ) {
        self.phoneLable.text = model.phone;
    }
    
    if ([model.is_default integerValue] == 0) {
        self.defultLabel.hidden = YES;
    }else{
        self.defultLabel.hidden = NO;

    }
    
}

- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    NSString * addStr = [NSString stringWithFormat:@"%@%@%@%@",dataDic[@"region"][@"province"],dataDic[@"region"][@"city"],dataDic[@"region"][@"region"],dataDic[@"detail"]];
    self.addressLable.text = addStr;
    self.nameLable.text = dataDic[@"name"];
    self.phoneLable.text = dataDic[@"phone"];
    self.defultLabel.hidden = YES;
}

- (IBAction)editButn:(UIButton *)sender {
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
