//
//  LyInfoVC.m
//  LYMallApp
//
//  Created by Mac on 2020/4/8.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "LyInfoVC.h"
#import "LyinfoCell.h"
@interface LyInfoVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
static NSString *cellID = @"LyinfoCell";
@implementation LyInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"隆源农业";
    [self.tableView registerNib:[UINib nibWithNibName:@"LyinfoCell" bundle:nil] forCellReuseIdentifier:cellID];
    self.tableView.estimatedRowHeight = 50;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [UIView new];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        LyinfoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        return cell;
    }
    
    static NSString * cellINFO = @"celllll";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellINFO] ;
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellINFO];
        cell.textLabel.textColor = kUIColorFromRGB(0x4D4D4D);
        cell.textLabel.font = FONTSIZE(15);
        cell.detailTextLabel.textColor = kUIColorFromRGB(0x4D4D4D);
        cell.detailTextLabel.font = FONTSIZE(15);
    }
    
    if (indexPath.row == 1) {
        cell.textLabel.text = @"客服电话";
        cell.detailTextLabel.text = @"18738596637";
        cell.detailTextLabel.textColor = kUIColorFromRGB(0x2E7AFB);

    }else if (indexPath.row == 2) {
        cell.textLabel.text = @"工作时间";
        cell.detailTextLabel.text = @"9：00-18：00";
    }else if (indexPath.row == 3) {
        cell.textLabel.text = @"公司网址";
        cell.detailTextLabel.text = @"http://www.xxlyny.com";
        cell.detailTextLabel.textColor = kUIColorFromRGB(0x666666);

    }else if (indexPath.row == 4) {
        cell.textLabel.text = @"公司地址";
        cell.detailTextLabel.text = @"卫辉市南站中医院东侧";
        cell.detailTextLabel.textColor = kUIColorFromRGB(0x666666);

    }
    
    
    return cell;
    
    
}
@end
