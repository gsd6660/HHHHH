//
//  ActivateMemberVC.m
//  LYMallApp
//
//  Created by Mac on 2020/5/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ActivateMemberVC.h"

@interface ActivateMemberVC ()
@property (weak, nonatomic) IBOutlet UITextField *numTF;
@property (weak, nonatomic) IBOutlet UITextField *jifenTF;
@property (weak, nonatomic) IBOutlet UITextField *acountTF;

@end

@implementation ActivateMemberVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"激活会员";
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)searchButn:(UIButton *)sender {
    
}

@end
