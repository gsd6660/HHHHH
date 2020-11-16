//
//  GoodsDetailsVC.m
//  LYMallApp
//
//  Created by gds on 2020/3/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "GoodsDetailsVC.h"
#import <SDCycleScrollView.h>
#import "GoodsOneCell.h"
#import "GoodsTwoCell.h"
#import "GoodsThreeCell.h"
#import "GoodsTagsCell.h"
#import "SKUViewController.h"
#import "GoodsImageCell.h"
#import "GoodsVipCell.h"
#import "GoodsTopPriceCell.h"
#import "GoodsTopVipCell.h"
#import "GoodsSelectCell.h"
#import "GroupGoodsCell.h"
#import "ProductDetailsThreeCell.h"
#import "SureOrderVC.h"
#import "ChatMeassageVC.h"
#import "AppraiseListVC.h"
#import "GiftPackageCell.h"
#import "NumberCalculate.h"
#import "XinOrderPayVC.h"
#import "InviteFriendsVC.h"
@interface GoodsDetailsVC ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,WKNavigationDelegate,NumberCalculateDelegate>
{
    BOOL isFold;
    BOOL is_commission;
    BOOL is_userGrade;
    GoodsSelectCell * selectCell;
    NSInteger  spec_type;//单规格 10 多规格20
}
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UILabel * countLable;
@property(nonatomic,strong)SDCycleScrollView * cycleScrollView;
@property(nonatomic,strong)NSMutableArray * imageArray;
@property(nonatomic,strong)NSDictionary * dataDic;
@property(nonatomic, assign)CGFloat webviewHight;//记录wkwebview的高度
@property(nonatomic,strong)WKWebView *webKitView;//计算高度浏览器控件
@property(nonatomic,strong)NSMutableArray * discountArray;
@property(nonatomic,strong)NSMutableArray * commentArray;//评论

@property(nonatomic,strong)NSMutableDictionary * addCartDic;
@property(nonatomic,strong)NSMutableArray * gift_goods_listArray;//礼包商品
@property (strong, nonatomic) NumberCalculate *numLabel;
@property (strong, nonatomic) NSString *num;

@end

static NSString * GoodsOneCellID = @"GoodsOneCell";
static NSString * GoodsTwoCellID = @"GoodsTwoCell";
static NSString * GoodsThreeCellID = @"GoodsThreeCell";
static NSString * GoodsTagsCellID = @"GoodsTagsCell";
static NSString * GoodsImageCellID = @"GoodsImageCell";
static NSString * GoodsVipCellID = @"GoodsVipCell";
static NSString * GoodsTopPriceCellID = @"GoodsTopPriceCell";
static NSString * GoodsTopVipCellID = @"GoodsTopVipCell";
static NSString * GoodsSelectCellID = @"GoodsSelectCell";
static NSString * cellFUwenBenID = @"ProductDetailsThreeCell";
static NSString * GoodsVipTwoCellID = @"GiftPackageCell";

@implementation GoodsDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
    
    [self.tableView registerNib:[UINib nibWithNibName:GoodsOneCellID bundle:nil] forCellReuseIdentifier:GoodsOneCellID];
    [self.tableView registerNib:[UINib nibWithNibName:GoodsTwoCellID bundle:nil] forCellReuseIdentifier:GoodsTwoCellID];
    [self.tableView registerNib:[UINib nibWithNibName:GoodsThreeCellID bundle:nil] forCellReuseIdentifier:GoodsThreeCellID];
    [self.tableView registerNib:[UINib nibWithNibName:GoodsTagsCellID bundle:nil] forCellReuseIdentifier:GoodsTagsCellID];
    [self.tableView registerNib:[UINib nibWithNibName:GoodsImageCellID bundle:nil] forCellReuseIdentifier:GoodsImageCellID];
    [self.tableView registerNib:[UINib nibWithNibName:GoodsVipCellID bundle:nil] forCellReuseIdentifier:GoodsVipCellID];
    [self.tableView registerNib:[UINib nibWithNibName:GoodsVipTwoCellID bundle:nil] forCellReuseIdentifier:GoodsVipTwoCellID];

    [self.tableView registerNib:[UINib nibWithNibName:GoodsTopPriceCellID bundle:nil] forCellReuseIdentifier:GoodsTopPriceCellID];
    [self.tableView registerNib:[UINib nibWithNibName:GoodsTopVipCellID bundle:nil] forCellReuseIdentifier:GoodsTopVipCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:GoodsSelectCellID bundle:nil] forCellReuseIdentifier:GoodsSelectCellID];
    
    [self.tableView registerClass:[ProductDetailsThreeCell class] forCellReuseIdentifier:cellFUwenBenID];
    
    
    [self.view addSubview:self.tableView];
    SDCycleScrollView * cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth) delegate:self placeholderImage:[UIImage imageNamed:@"banner"]];
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.autoScrollTimeInterval = 2;
    cycleScrollView.showPageControl = NO;
    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    self.cycleScrollView = cycleScrollView;
    UILabel * countLable = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth - 64, ScreenWidth - 19 - 20, 50, 20)];
    countLable.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    countLable.layer.cornerRadius = 10;
    countLable.layer.masksToBounds = YES;
    countLable.textAlignment = NSTextAlignmentCenter;
    countLable.textColor = [UIColor whiteColor];
    countLable.font = FONTSIZE(14);
    [cycleScrollView addSubview:countLable];
    self.countLable = countLable;
    self.tableView.tableHeaderView = cycleScrollView;
    [self initBottomView:self.typeStr];
    [self getData];
    [self setUpWkView];
    
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushTypeClick:) name:@"pushType" object:nil];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"pushType" object:nil];
}

- (void)pushTypeClick:(NSNotification *)notif{
    
    NSLog(@"====%@",notif.userInfo[@"type"]);
    NSInteger type = [notif.userInfo[@"type"]integerValue];
    selectCell.selectLabel.text = notif.userInfo[@"goods_attr"];
    switch (type) {
        case 0:{
            NSLog(@"选择规格");
            GF_Check_Login
            [self.addCartDic setValue:notif.userInfo[@"quantity"] forKey:@"goods_num"];
            [self.addCartDic setValue:notif.userInfo[@"spec_sku_id"] forKey:@"spec_sku_id"];
            [self.addCartDic setValue:self.goods_id forKey:@"goods_id"];
            SureOrderVC * vc = [[SureOrderVC alloc]init];
            vc.prmDic = self.addCartDic;
            vc.type = DetailPush;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{
            [self.addCartDic setValue:notif.userInfo[@"quantity"] forKey:@"goods_num"];
            [self.addCartDic setValue:notif.userInfo[@"spec_sku_id"] forKey:@"spec_sku_id"];
            [self.addCartDic setValue:self.goods_id forKey:@"goods_id"];
            [self addCartClick:self.addCartDic];
        }
            break;
        case 2:{
            NSLog(@"立即购买");
            GF_Check_Login
            [self.addCartDic setValue:notif.userInfo[@"quantity"] forKey:@"goods_num"];
            [self.addCartDic setValue:notif.userInfo[@"spec_sku_id"] forKey:@"spec_sku_id"];
            [self.addCartDic setValue:self.goods_id forKey:@"goods_id"];
            SureOrderVC * vc = [[SureOrderVC alloc]init];
            vc.prmDic = self.addCartDic;
            vc.type = DetailPush;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

//加入购物车
- (void)addCartClick:(NSDictionary *)dic{
    [self showEmptyViewWithLoading];
    [NetWorkConnection postURL:@"api/cart/add" param:dic success:^(id responseObject, BOOL success) {
        [self hideEmptyView];
        if (responseSuccess) {
            NSLog(@"%@",responseObject);
            [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshCartData" object:nil];
            
            ShowHUD(responseMessage);
        }else{
            ShowErrorHUD(responseMessage);
        }
    } fail:^(NSError *error) {
        [self hideEmptyView];
        ShowErrorHUD(@"网络错误");
    }];
}


-(void)setUpWkView{
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta); var imgs = document.getElementsByTagName('img');for (var i in imgs){imgs[i].style.maxWidth='100%';imgs[i].style.height='auto';}";
    
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;
    
    
    WKWebView *webKitView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 1) configuration:wkWebConfig];
    webKitView.navigationDelegate=self;
    webKitView.scrollView.scrollEnabled=NO;
    [webKitView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    
    self.webKitView=webKitView;
    webKitView.hidden=YES;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"]) {
        __weak typeof(self) weakSelf = self;
        //执行js方法"document.body.offsetHeight" ，获取wkwebview内容高度
        [self.webKitView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            CGFloat contentHeight = [result floatValue];
            [weakSelf.tableView beginUpdates];
            self->_webviewHight = contentHeight;
        }];
        [self.tableView endUpdates];
    }
}

#pragma mark -浏览器代理
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    
    [webView evaluateJavaScript:@"document.body.scrollHeight"
              completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        if (!error) {
            NSString *heightStr = [NSString stringWithFormat:@"%@",result];
            CGFloat height=[heightStr floatValue];
            NSLog(@"height=%f",height);
            //缓存高度刷新
            NSIndexSet * index = [NSIndexSet indexSetWithIndex:7];
            [UIView performWithoutAnimation:^{
                [self.tableView reloadSections:index withRowAnimation:UITableViewRowAnimationNone];
            }];
            
        }
        
    }];
}


-(void)getData{
    [self showEmptyViewWithLoading];
    [NetWorkConnection postURL:@"api/goods/detail" param:@{@"goods_id":self.goods_id,@"gift_goods_type":self.typeStr} success:^(id responseObject, BOOL success) {
        NSLog(@"商品详情====%@",responseJSONString);
        if ([responseObject[@"data"] count] == 0) {
            ShowErrorHUD(responseMessage);
            [self.navigationController popViewControllerAnimated:YES];
            return ;
        }
        [self.imageArray removeAllObjects];
        self.dataDic = responseObject[@"data"][@"detail"];
        NSArray *gift_goods_list = responseObject[@"data"][@"detail"][@"gift_goods_list"];
        [self.gift_goods_listArray removeAllObjects];
        for (NSDictionary *dic in gift_goods_list) {
            [self.gift_goods_listArray addObject:dic];
        }
        NSArray * images = responseObject[@"data"][@"detail"][@"image"];
        for (NSDictionary *dic in images) {
            [self.imageArray addObject:dic[@"file_path"]];
        }
        self.cycleScrollView.imageURLStringsGroup = self.imageArray;
        self.countLable.text = [NSString stringWithFormat:@"1/%ld",self.imageArray.count];
        self.discountArray = self.dataDic[@"grade_discount"];
        is_commission = [self.dataDic[@"is_enable_commission"]boolValue];
        is_userGrade = [self.dataDic[@"is_user_grade"]boolValue];
        self.commentArray = self.dataDic[@"comment_data"];
        spec_type = [self.dataDic[@"spec_type"]integerValue];
        [self hideEmptyView];
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        [self hideEmptyView];
    }];
}


//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0) {
//        return <#expression#>
//    }
//    return 60;
//}


/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    self.countLable.text = [NSString stringWithFormat:@"%ld/%ld",index + 1,self.imageArray.count];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - TabBarHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.estimatedRowHeight = 15;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 8;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 4) {
        if (is_commission) {
            if (self.discountArray.count>0) {
                if (isFold) {
                    return self.discountArray.count+1;
                }
            }
            return 2;
        }else{
            if (self.discountArray.count>0) {
                if (isFold) {
                    return self.discountArray.count;
                }
                return 1;
            }
        }
    }
    if (section == 1){
        if (!is_userGrade) {
            return 0;
        }
    }
    if (section == 6) {
        if (self.commentArray.count==0) {
            return 0;
        }
    }
    if (section == 5) {
        if (spec_type == 10) {
            return 0;
        }
    }
    
    return  1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        return 56 ;
    }else if (indexPath.section == 1) {
        return 35 ;
    }
    else if (indexPath.section == 2) {
        if ([self.typeStr intValue] == 2) {
            return 45;
        }
        return 75 ;
    }else if (indexPath.section == 3) {
        if ([self.typeStr intValue] == 2) {
            return 0;
        }
        return 30 ;
    }else if (indexPath.section == 4) {
        if ([self.typeStr intValue] == 2) {
            //470
            return 254;
        }
        return 40 ;
    }else if (indexPath.section == 5) {
        return 40 ;
    }
    
    else if (indexPath.section == 7) {
        return _webviewHight ;
        
    }
    return 120;
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if(indexPath.section == 0){
        GoodsTopPriceCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsTopPriceCellID];
        cell.dataDic =self.dataDic;
        return  cell;
    }
    if(indexPath.section == 1){
        GoodsTopVipCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsTopVipCellID];
        cell.dataDic =self.dataDic;
        return  cell;
    }
    if(indexPath.section == 2){
        GoodsOneCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsOneCellID];
        cell.dataDic =self.dataDic;
        return  cell;
    }
    if (indexPath.section == 3) {
        GoodsTagsCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsTagsCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataDic =self.dataDic;
        return  cell;
    }
    if (indexPath.section == 4) {
        
        if (is_commission) {
            if (isFold) {
                if (indexPath.row == self.discountArray.count) {
                    GoodsTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsTwoCellID];
                    cell.dataDic =self.dataDic;
                    return cell;
                }else{
                    GoodsVipCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsVipCellID];
                    if (self.discountArray.count>0) {
                        [cell setDataDic:self.discountArray[indexPath.row] withIndexPath:indexPath];
                    }
                    return  cell;
                }
            }else{
                if (indexPath.row == 1) {
                    GoodsTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsTwoCellID];
                    cell.dataDic =self.dataDic;
                    return cell;
                }else{
                    GoodsVipCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsVipCellID];
                    if (self.discountArray.count>0) {
                        [cell setDataDic:self.discountArray[indexPath.row] withIndexPath:indexPath];
                    }
                    return  cell;
                }
            }
        }else{
            
            if ([self.typeStr intValue] == 2) {
                GiftPackageCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsVipTwoCellID];
                if (self.gift_goods_listArray.count>0) {
                cell.dataArray = self.gift_goods_listArray;
                }
                return  cell;
            }
            
            
            GoodsVipCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsVipCellID];
            if (self.discountArray.count>0) {
                [cell setDataDic:self.discountArray[indexPath.row] withIndexPath:indexPath];
            }
            return  cell;
        }
        //        if (indexPath.row < self.discountArray.count) {
        //            GoodsVipCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsVipCellID];
        //            if (self.discountArray) {
        //                [cell setDataDic:self.discountArray[indexPath.row] withIndexPath:indexPath];
        //            }
        //            return  cell;
        //        }else{
        //            GoodsTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsTwoCellID];
        //            cell.dataDic =self.dataDic;
        //            return cell;
        //        }
    }
    if (indexPath.section == 5) {
        selectCell = [tableView dequeueReusableCellWithIdentifier:GoodsSelectCellID];
        selectCell.dataDic =self.dataDic;
        
        //        cell.selectLabel.text = @"小麦，5kg";
        selectCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return selectCell;
    }
    if (indexPath.section == 6) {
        GoodsThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsThreeCellID];
        if (self.commentArray) {
            cell.sumLabel.text = [NSString stringWithFormat:@"全部评价(%@)",self.dataDic[@"comment_data_count"]];
            cell.dataDic = self.commentArray[indexPath.row];
        }
        [cell.allBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            NSLog(@"查看全部评价");
            AppraiseListVC * vc = [[AppraiseListVC alloc]init];
            vc.goods_id = self.goods_id;
            vc.goods_type = self.typeStr;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        return cell;
    }
    if (indexPath.section == 7) {
        ProductDetailsThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(ProductDetailsThreeCell.class)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!cell) {
            cell = [[ProductDetailsThreeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(ProductDetailsThreeCell.class)];
        }
        cell.htmlStr = self.dataDic[@"content"];
        __weak typeof(self) weakSelf = self;
        cell.block  = ^(CGFloat webHeight) {
            __strong typeof(self) strongSelf = weakSelf;
            if (strongSelf.webviewHight < webHeight) {//当缓存的高度小于返回的高度时，更新缓存高度，刷新tableview
                strongSelf.webviewHight = webHeight;
                [weakSelf.tableView beginUpdates];
                [weakSelf.tableView endUpdates];
            }
        };
        if ([self.dataDic[@"content"]length] > 0) {
            [cell.webView loadHTMLString:[self autoWebAutoImageSize:self.dataDic[@"content"]] baseURL:nil];
            
        }
        
        
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 6) {
        return 10;
    }if (section == 7) {
        return 30;
    } else{
        return 0.1f;
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 7) {
        UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, ScreenWidth, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"------- 宝贝详情 -------";
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:13];
        [bgView addSubview:label];
        return bgView;
    }
    
    return [UIView new];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 5) {
        SKUViewController *tView = [[SKUViewController alloc] init];
        tView.dataDic = self.dataDic;
        tView.type = SELECTPECELL;
        if (self.addCartDic.allValues.count>0) {
            //            tView.spec_sku_id = self.addCartDic[@"spec_sku_id"];
            //            tView.quantity = self.addCartDic[@"quantity"];
            tView.selectDic = self.addCartDic;
        }
        //设置模式展示风格
        [tView setModalPresentationStyle:UIModalPresentationOverCurrentContext];
        //必要配置
        self.modalPresentationStyle = UIModalPresentationCurrentContext;
        self.providesPresentationContextTransitionStyle = YES;
        self.definesPresentationContext = YES;
        [self.navigationController presentViewController:tView animated:YES completion:^{
            NSLog(@"1111");
        }];
    }
    if (indexPath.section ==4) {
        if (indexPath.row==0) {
            isFold = !isFold;
            [self.tableView reloadData];
        }
    }
}


// 自适应尺寸大小
- (NSString *)autoWebAutoImageSize:(NSString *)html{
    
    NSString *jSString =  [NSString stringWithFormat:@"<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'><meta name='apple-mobile-web-app-capable' content='yes'><meta name='apple-mobile-web-app-status-bar-style' content='black'><meta name='format-detection' content='telephone=no'><style type='text/css'>img{width:%fpx}</style>%@", [UIScreen mainScreen].bounds.size.width-15, html];
    return jSString;
}


- (void)initBottomView:(NSString *)type{
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - TabBarHeight, ScreenWidth, TabBarHeight)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    if ([type intValue] == 2) {
        UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(14, 16.5, 50, 16)];
        lable.text = @"数量：";
        lable.font = [UIFont systemFontOfSize:14 weight:20];
        lable.textColor = kUIColorFromRGB(0x666666);
        [bottomView addSubview:lable];
        
        self.numLabel = [[NumberCalculate alloc]initWithFrame:CGRectMake(60, 15.5, 72, 18)];
        self.numLabel.baseNum = @"1";
        self.numLabel.delegate = self;
        self.num = @"1";
        [bottomView addSubview:self.numLabel];

        QMUIFillButton * buyBtn = [QMUIFillButton buttonWithType:UIButtonTypeCustom];
        buyBtn.frame = CGRectMake(ScreenWidth - 26 - 90, 7, 90, 35);
        buyBtn.titleLabel.font = FONTSIZE(15);
           [buyBtn setTitle:@"立即购买" forState:0];
           [buyBtn setTitleColor:[UIColor whiteColor] forState:0];
           [bottomView addSubview:buyBtn];
        MJWeakSelf;
        [buyBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
           XinOrderPayVC * vc = [[XinOrderPayVC alloc]init];
           vc.gift_goods_id = weakSelf.goods_id;
            vc.num = self.num;
           [weakSelf.navigationController pushViewController:vc animated:YES];
           }];
        
    }else{

    
    UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    if (@available(iOS 13.0, *)) {
        lineLabel.backgroundColor = [UIColor separatorColor];
    } else {
        // Fallback on earlier versions
        lineLabel.backgroundColor = UIColorMakeWithHex(0x000000);
    }
    [bottomView addSubview:lineLabel];
    
    
    QMUIButton * messageBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    [messageBtn setTitle:@"分享" forState:0];
    [messageBtn setTitleColor: [UIColor grayColor] forState:0];
    [messageBtn setImage:[UIImage imageNamed:@"jft_but_customerservice"] forState:0];
    [bottomView addSubview:messageBtn];
    messageBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    messageBtn.imagePosition = QMUIButtonImagePositionTop;
    messageBtn.spacingBetweenImageAndTitle = 5;
    MJWeakSelf;
    [messageBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        
        GF_Check_Login;
        
        InviteFriendsVC * vc = [InviteFriendsVC new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
        
//        [NetWorkConnection postURL:@"api/customerservice/logs" param:nil success:^(id responseObject, BOOL success) {
//            if (responseMessage) {
//
//                ChatMeassageVC * vc = [ChatMeassageVC new];
//                vc.title = @"客服咨询";
//                vc.record_id = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"record_id"]];
//                [weakSelf.navigationController pushViewController:vc animated:YES];
//            }
//        } fail:^(NSError *error) {
//
//        }];
        
        
    }];
    
    [messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(10);
        make.top.offset(10);
        make.width.offset(40);
        make.height.offset(40);
    }];
    
    QMUIButton * joinBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    [joinBtn setTitle:@"加入购物车" forState:0];
    [joinBtn setTitleColor:[UIColor whiteColor] forState:0];
    [joinBtn setBackgroundImage:[UIImage imageNamed:@"jft_but_addtocart"] forState:0];
    [bottomView addSubview:joinBtn];
    joinBtn.spacingBetweenImageAndTitle = 5;
    joinBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [joinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.equalTo(messageBtn.mas_right).offset(5);
        make.right.equalTo(bottomView.mas_centerX).offset(10);
        make.top.equalTo(messageBtn.mas_top);
        make.width.offset(ScreenWidth/3+10);
        make.height.offset(35);
    }];
    [joinBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [self joinBtnClick];
    }];
    
    QMUIButton * buyBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    [buyBtn setTitle:@"立即购买" forState:0];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:0];
    [buyBtn setBackgroundImage:[UIImage imageNamed:@"jft_but_purchase"] forState:0];
    buyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [bottomView addSubview:buyBtn];
    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(joinBtn.mas_right).offset(20);
        make.top.equalTo(messageBtn.mas_top);
        make.width.offset(ScreenWidth/3);
        make.height.offset(35);
    }];
    [buyBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [self buyBtnClick];
    }];
            
  }

}


-(void)resultNumber:(NSString *)number{
    self.num = number;
}

#pragma mark 加入购物车
- (void)joinBtnClick{
    GF_Check_Login
    if (spec_type == 10) {
        [self.addCartDic setValue:self.goods_id forKey:@"goods_id"];
        [self.addCartDic setValue:@"1" forKey:@"goods_num"];
        [self.addCartDic setValue:@"0" forKey:@"spec_sku_id"];
        [self addCartClick:self.addCartDic];
    }else{
        if ([self.addCartDic allValues].count>0) {
            NSLog(@"加入购物车");
            [self addCartClick:self.addCartDic];
        }else{
            SKUViewController *tView = [[SKUViewController alloc] init];
            tView.dataDic = self.dataDic;
            tView.type = SELECTPEADDBTN;
            //设置模式展示风格
            [tView setModalPresentationStyle:UIModalPresentationOverCurrentContext];
            //必要配置
            self.modalPresentationStyle = UIModalPresentationCurrentContext;
            self.providesPresentationContextTransitionStyle = YES;
            self.definesPresentationContext = YES;
            [self presentViewController:tView animated:NO completion:nil];
        }
    }
    
    
    
}
#pragma mark 立即购买
- (void)buyBtnClick{
    GF_Check_Login
    if (spec_type == 10) {
        [self.addCartDic setValue:self.goods_id forKey:@"goods_id"];
        [self.addCartDic setValue:@"1" forKey:@"goods_num"];
        [self.addCartDic setValue:@"0" forKey:@"spec_sku_id"];
        SureOrderVC * vc = [[SureOrderVC alloc]init];
        vc.type = DetailPush;
        vc.prmDic = self.addCartDic;
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"立即购买");
    }else{
        if (self.addCartDic.allValues.count > 0) {
            SureOrderVC * vc = [[SureOrderVC alloc]init];
            vc.type = DetailPush;
            vc.prmDic = self.addCartDic;
            [self.navigationController pushViewController:vc animated:YES];
            NSLog(@"立即购买");
        }else{
            SKUViewController *tView = [[SKUViewController alloc] init];
            tView.dataDic = self.dataDic;
            tView.type = SELECTPEBUYBTN;
            //设置模式展示风格
            [tView setModalPresentationStyle:UIModalPresentationOverCurrentContext];
            //必要配置
            self.modalPresentationStyle = UIModalPresentationCurrentContext;
            self.providesPresentationContextTransitionStyle = YES;
            self.definesPresentationContext = YES;
            [self presentViewController:tView animated:YES completion:^{
            }];
        }
    }
}
- (BOOL)layoutEmptyView{
    self.emptyView.backgroundColor = [UIColor whiteColor];
    return YES;
}

-(NSMutableArray *)imageArray{
    if (_imageArray == nil) {
        _imageArray = [[NSMutableArray alloc]init];
    }
    return _imageArray;
}
- (NSMutableArray *)discountArray{
    if (!_discountArray) {
        _discountArray = [NSMutableArray array];
    }
    return _discountArray;
}

- (NSMutableArray *)commentArray{
    if (!_commentArray) {
        _commentArray = [NSMutableArray array];
    }
    return _commentArray;
}

- (NSMutableArray *)gift_goods_listArray{
    if (!_gift_goods_listArray) {
        _gift_goods_listArray = [NSMutableArray array];
    }
    return _gift_goods_listArray;
}
- (NSMutableDictionary *)addCartDic{
    if (!_addCartDic) {
        _addCartDic = [NSMutableDictionary dictionary];
    }
    return _addCartDic;
}

@end
