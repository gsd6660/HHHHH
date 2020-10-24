//
//  BankCardListCell.m
//  FuTaiAPP
//
//  Created by Mac on 2019/1/22.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "BankCardListCell.h"
#import "BankCardLisModel.h"
@implementation BankCardListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(BankCardLisModel *)model{
    _model = model;
    self.bankNamelbale.text = model.card_type;
    self.cardNumlable.text = model.id_card;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
