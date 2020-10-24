//
//  GoodsTwoCell.m
//  LYMallApp
//
//  Created by gds on 2020/3/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "GoodsTwoCell.h"
#import "InviteFriendsVC.h"
@implementation GoodsTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.shareBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]; //登录时候返回token
        NSLog(@"token====%@",token);
        
        if (token.length ==0) {
            token = @"";
        }
        InviteFriendsVC * vc = [[InviteFriendsVC alloc]init];
        //        vc.urlString = [NSString stringWithFormat:@"http://longyuan.demo.altjia.com/wap/invite/index?Authorization=%@",token];
        [[self viewController].navigationController pushViewController:vc animated:YES];
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    [self.commissionBtn setTitle:[NSString stringWithFormat:@"佣金返￥%@",  dataDic[@"commission_level1"]] forState:0];
}

@end
