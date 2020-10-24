//
//  RegisterMemberFootView.m
//  LYMallApp
//
//  Created by Mac on 2020/5/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "RegisterMemberFootView.h"

@implementation RegisterMemberFootView


- (void)drawRect:(CGRect)rect {
       [self getImageUrl];
}

- (IBAction)codeButn:(UIButton *)sender {
    
  
    [self getImageUrl];
    
    
}

- (IBAction)registerButn:(UIButton *)sender {
    if (self.block) {
        self.block();
    }
    
    
    
}


-(void)getImageUrl{

    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
           NSString *url = [NSString stringWithFormat:@"%@api/user/getCode?Authorization=%@",BaseUrl,token];
           [self.codeButn setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]] forState:UIControlStateNormal];
}



@end
