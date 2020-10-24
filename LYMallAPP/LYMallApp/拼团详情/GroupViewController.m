//
//  GroupViewController.m
//  LYMallApp
//
//  Created by 科技 on 2020/3/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "GroupViewController.h"
#import <SDCycleScrollView.h>
#import "GoodsOneCell.h"
#import "GoodsTwoCell.h"
#import "GoodsThreeCell.h"
#import "GoodsTagsCell.h"
#import "SKUViewController.h"
#import "GoodsImageCell.h"
#import "GoodsVipCell.h"
#import "GoodsTopVipCell.h"
#import "GroupGoodsCell.h"
#import "GoodsSelectCell.h"
#import "ProductDetailsThreeCell.h"
#import "SureOrderVC.h"
#import "AppraiseListVC.h"
@interface GroupViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,WKNavigationDelegate>
{
    BOOL is_commission;
    BOOL is_userGrade;
    GoodsSelectCell * selectCell;
    NSInteger  spec_type;//单规格 10 多规格20
}
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * imageArray;
@property(nonatomic,strong)NSDictionary * dataDic;
@property(nonatomic,strong)SDCycleScrollView * cycleScrollView;
@property(nonatomic,strong)UILabel * countLable;
@property(nonatomic, assign)CGFloat webviewHight;//记录wkwebview的高度
@property(nonatomic,strong)WKWebView *webKitView;//计算高度浏览器控件
@property(nonatomic,strong)NSMutableArray * discountArray;
@property(nonatomic,strong)NSMutableArray * commentArray;//评论
@property(nonatomic,strong)NSMutableDictionary * addCartDic;

@end
static NSString * GoodsOneCellID = @"GoodsOneCell";
static NSString * GoodsTwoCellID = @"GoodsTwoCell";
static NSString * GoodsThreeCellID = @"GoodsThreeCell";
static NSString * GoodsTagsCellID = @"GoodsTagsCell";
static NSString * GoodsImageCellID = @"GoodsImageCell";
static NSString * GroupGoodsCellID = @"GroupGoodsCell";
static NSString * GoodsSelectCellID = @"GoodsSelectCell";
static NSString * cellFUwenBenID = @"ProductDetailsThreeCell";

@implementation GroupViewController
- (BOOL)layoutEmptyView{
    self.emptyView.backgroundColor = [UIColor whiteColor];
//    [self.emptyView setImage:[UIImage imageNamed:@"loading.gif"]];
//    [self.emptyView setLoadingViewHidden:YES];
//    [QMUITips showLoadingInView:self.emptyView];
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
    [self.tableView registerNib:[UINib nibWithNibName:GoodsOneCellID bundle:nil] forCellReuseIdentifier:GoodsOneCellID];
    [self.tableView registerNib:[UINib nibWithNibName:GoodsTwoCellID bundle:nil] forCellReuseIdentifier:GoodsTwoCellID];
    [self.tableView registerNib:[UINib nibWithNibName:GoodsThreeCellID bundle:nil] forCellReuseIdentifier:GoodsThreeCellID];
    [self.tableView registerNib:[UINib nibWithNibName:GoodsTagsCellID bundle:nil] forCellReuseIdentifier:GoodsTagsCellID];
    [self.tableView registerNib:[UINib nibWithNibName:GoodsImageCellID bundle:nil] forCellReuseIdentifier:GoodsImageCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GroupGoodsCell" bundle:nil] forCellReuseIdentifier:GroupGoodsCellID];
    [self.tableView registerNib:[UINib nibWithNibName:GoodsSelectCellID bundle:nil] forCellReuseIdentifier:GoodsSelectCellID];
    [self.tableView registerClass:[ProductDetailsThreeCell class] forCellReuseIdentifier:cellFUwenBenID];
    
    [self.view addSubview:self.tableView];
   SDCycleScrollView * cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, kHeightSP(187)) delegate:self placeholderImage:[UIImage imageNamed:@"banner"]];
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.autoScrollTimeInterval = 2;
    cycleScrollView.showPageControl = NO;
    cycleScrollView.layer.masksToBounds = YES;
    cycleScrollView.layer.cornerRadius = 4;
    self.cycleScrollView = cycleScrollView;
    UILabel * countLable = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth - 64, kHeightSP(187) - 19 - 20, 50, 20)];
    countLable.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    countLable.layer.cornerRadius = 10;
    countLable.layer.masksToBounds = YES;
    countLable.textAlignment = NSTextAlignmentCenter;
    countLable.textColor = [UIColor whiteColor];
    countLable.font = FONTSIZE(14);
    [cycleScrollView addSubview:countLable];
    self.countLable = countLable;
    self.tableView.tableHeaderView = cycleScrollView;
    [self initBottomView];
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
            [self.addCartDic setValue:notif.userInfo[@"quantity"] forKey:@"goods_num"];
            [self.addCartDic setValue:notif.userInfo[@"spec_sku_id"] forKey:@"spec_sku_id"];
            [self.addCartDic setValue:self.goods_id forKey:@"sharp_goods_id"];
            SureOrderVC * vc = [[SureOrderVC alloc]init];
            vc.prmDic = self.addCartDic;
            vc.type = SharpDetailPush;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            NSLog(@"立即购买");
            SureOrderVC * vc = [[SureOrderVC alloc]init];
            vc.prmDic = self.addCartDic;
            vc.type = SharpDetailPush;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    self.countLable.text = [NSString stringWithFormat:@"%ld/%ld",index + 1,self.imageArray.count];
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
#pragma mark  加载数据
-(void)getData{
    [self showEmptyViewWithLoading];
    [NetWorkConnection postURL:@"api/goods/sharp" param:@{@"sharp_goods_id":self.goods_id} success:^(id responseObject, BOOL success) {
        [self hideEmptyView];
        if (responseSuccess) {
            NSLog(@"限时拼团商品详情====%@",responseJSONString);
            [self.imageArray removeAllObjects];
            self.dataDic = responseObject[@"data"][@"detail"];
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
            [self.tableView reloadData];
        }else{
            ShowErrorHUD(responseMessage);
        }
        
    } fail:^(NSError *error) {
        [self hideEmptyView];
    }];
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - TabBarHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3) {
        if (!is_commission) {
            return 0;
        }
    }
    if (section == 4) {
        if (spec_type == 10) {
            return 0;
        }
    }
    if (section == 5) {
       if (self.commentArray.count==0) {
           return 0;
       }
   }
    return  1;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if(indexPath.section == 0){
        GroupGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:GroupGoodsCellID];
        cell.dataDic =self.dataDic;
        return cell;
    }
   
    if(indexPath.section == 1){
        GoodsOneCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsOneCellID];
        cell.dataDic =self.dataDic;
        return  cell;
    }
    if (indexPath.section == 2) {
        GoodsTagsCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsTagsCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataDic =self.dataDic;
        return  cell;
    }
    if (indexPath.section == 3) {
        GoodsTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsTwoCellID];
        cell.dataDic =self.dataDic;
        return cell;
    }
    if (indexPath.section == 4) {
        selectCell = [tableView dequeueReusableCellWithIdentifier:GoodsSelectCellID];
        selectCell.selectionStyle = UITableViewCellSelectionStyleNone;
        selectCell.dataDic =self.dataDic;
        return selectCell;
    }
    if (indexPath.section == 5) {
        GoodsThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsThreeCellID];
        if (self.commentArray) {
               cell.sumLabel.text = [NSString stringWithFormat:@"全部评价(%@)",self.dataDic[@"comment_data_count"]];
               cell.dataDic = self.commentArray[indexPath.row];
           }
           [cell.allBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
               NSLog(@"查看全部评价");
               AppraiseListVC * vc = [[AppraiseListVC alloc]init];
               vc.goods_id = self.goods_id;
               vc.goods_type = @"1";
               [self.navigationController pushViewController:vc animated:YES];
           }];
        return cell;
    }
    if (indexPath.section == 6) {
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
// 自适应尺寸大小
- (NSString *)autoWebAutoImageSize:(NSString *)html{
    
    NSString *jSString =  [NSString stringWithFormat:@"<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'><meta name='apple-mobile-web-app-capable' content='yes'><meta name='apple-mobile-web-app-status-bar-style' content='black'><meta name='format-detection' content='telephone=no'><style type='text/css'>img{width:%fpx}</style>%@", [UIScreen mainScreen].bounds.size.width-15, html];
    return jSString;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 65 ;
    }else if (indexPath.section == 1) {
        return 75 ;
    }
    else if (indexPath.section == 2) {
        return 30 ;
    }else if (indexPath.section == 3) {
        return 40 ;
    }else if (indexPath.section == 4) {
        return 40 ;
    }else if (indexPath.section == 6) {
        return _webviewHight ;
        
    }
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 4) {
        return 10;
    }if (section == 6) {
        return 30;
    } else{
        return 0.1f;
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 6) {
        UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
        bgView.backgroundColor = kUIColorFromRGB(0xF9F9F9);
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
    if (indexPath.section == 4) {
        SKUViewController *tView = [[SKUViewController alloc] init];
        //设置模式展示风格
        tView.dataDic = self.dataDic;
        tView.type = SELECTPECELL;
        tView.is_shrp = YES;
        if (self.addCartDic.allValues.count>0) {
            tView.selectDic = self.addCartDic;
        }
        [tView setModalPresentationStyle:UIModalPresentationOverCurrentContext];
        //必要配置
        self.modalPresentationStyle = UIModalPresentationCurrentContext;
        self.providesPresentationContextTransitionStyle = YES;
        self.definesPresentationContext = YES;
        [self.navigationController presentViewController:tView animated:YES completion:nil];
    }
    
}

- (void)initBottomView{
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - TabBarHeight, ScreenWidth, TabBarHeight)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    if (@available(iOS 13.0, *)) {
        lineLabel.backgroundColor = [UIColor separatorColor];
    } else {
        // Fallback on earlier versions
        lineLabel.backgroundColor = UIColorMakeWithHex(0x000000);
    }
    [bottomView addSubview:lineLabel];

    QMUIButton * buyBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
    [buyBtn setTitle:@"立即参团" forState:0];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:0];
    [buyBtn setBackgroundImage:[UIImage imageNamed:@"jft_but_purchase"] forState:0];
    buyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [bottomView addSubview:buyBtn];
    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(lineLabel.mas_top).offset(10);
        make.width.offset(150);
        make.height.offset(35);
    }];
    [buyBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        GF_Check_Login;
        [self buyBtnClick];
    }];
}

- (void)buyBtnClick{
    if (spec_type == 10) {
        [self.addCartDic setValue:self.goods_id forKey:@"sharp_goods_id"];
        [self.addCartDic setValue:@"1" forKey:@"goods_num"];
        [self.addCartDic setValue:@"0" forKey:@"spec_sku_id"];
        SureOrderVC * vc = [[SureOrderVC alloc]init];
        vc.type = SharpDetailPush;
        vc.prmDic = self.addCartDic;
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"立即购买");
    }else{
        if (self.addCartDic.allValues.count > 0) {
            SureOrderVC * vc = [[SureOrderVC alloc]init];
            vc.type = SharpDetailPush;
            vc.prmDic = self.addCartDic;
            [self.navigationController pushViewController:vc animated:YES];
            NSLog(@"立即购买");
        }else{
            SKUViewController *tView = [[SKUViewController alloc] init];
            tView.dataDic = self.dataDic;
            tView.type = SELECTPEBUYBTN;
            tView.is_shrp = YES;
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

- (NSMutableDictionary *)addCartDic{
    if (!_addCartDic) {
        _addCartDic = [NSMutableDictionary dictionary];
    }
    return _addCartDic;
}

@end
