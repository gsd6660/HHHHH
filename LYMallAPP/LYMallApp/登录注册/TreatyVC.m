//
//  TreatyVC.m
//  CDZAPP
//
//  Created by Mac on 2019/3/22.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "TreatyVC.h"

@interface TreatyVC ()

@property (strong, nonatomic) UITextView *textView;

@end

@implementation TreatyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView  = [[UITextView alloc]initWithFrame:CGRectMake(15, SafeAreaTopHeight, ScreenWidth - 30, ScreenHeight - SafeAreaTopHeight - 64)];
    self.textView.editable = NO;
    [self.view addSubview:self.textView];
   
    [NetWorkConnection postURL:@"api/document/user_register" param:nil success:^(id responseObject, BOOL success) {
        if (responseDataSuccess) {
            self.textView.attributedText = [self showAttributedToHtml:responseObject[@"result"][@"agree"] withWidth:ScreenWidth];
        }
    } fail:^(NSError *error) {
        
    }];
    
    
    
}


///显示富文本
-(NSAttributedString *)showAttributedToHtml:(NSString *)html withWidth:(float)width{
    //替换图片的高度为屏幕的高度
    NSString *newString = [html stringByReplacingOccurrencesOfString:@"<img" withString:[NSString stringWithFormat:@"<img width=\"%f\"",width]];
    
    NSAttributedString *attributeString=[[NSAttributedString alloc] initWithData:[newString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    
    
    return attributeString;
    
}

- (IBAction)agreeButn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
