//
//  SensationDetailViewController.m
//  ins
//
//  Created by Sper on 16/8/9.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "SensationDetailViewController.h"
#import "SensationModel.h"
#import "SensationDetailHeadIconView.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "WMAppController.h"

@interface UIImage ()
+ (id)_iconForResourceProxy:(id)arg1 variant:(int)arg2 variantsScale:(float)arg3;
+ (id)_applicationIconImageForBundleIdentifier:(id)arg1 format:(int)arg2 scale:(double)arg3;
@end


@interface SensationDetailViewController (){
    UIButton * leftButton;
    UIButton * rightButton;
    UIButton * middleButton;

}
// 网红用户id
@property (nonatomic , strong)NSString * userId;
@property (nonatomic, strong) UINavigationBar *navBar;
@property (nonatomic , strong)SensationDetailHeadIconView * topHeaderView; // 顶部tableviewHeader
@property (nonatomic , strong)NSMutableArray * dataArray; // 数据源
@property (nonatomic , strong)NSObject * workspace;


@end

@implementation SensationDetailViewController

- (void)setIntentDic:(NSDictionary *)intentDic{
    _userId = intentDic[@"userId"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.tableView.tableHeaderView = self.topHeaderView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    
    
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    self.navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    self.navBar.barTintColor = [UIColor mainColor];
    [[[self.navBar subviews] objectAtIndex:0] setAlpha:0];
    
    self.navBar.items = @[navItem];
    self.navBar.translucent = NO;
    [self.view addSubview:self.navBar];
    
//    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
//    [btn addTarget:self action:@selector(backItemAction:) forControlEvents:UIControlEventTouchUpInside];
//    [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    btn.adjustsImageWhenHighlighted = NO;
//    navItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
    
//    UIBarButtonItem * rightBarButton;
//    UIBarButtonItem * leftBarButton;
    
    leftButton = [[UIButton alloc] initWithFrame:CGRectMake(16, 20 + (44 - 22) / 2, 60, 22)];
    [leftButton setTitle:@"<上海" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [leftButton setBackgroundColor:([UIColor colorWithRed:((float)((0x000000&0xFF0000)>>16))/255.0 green:((float)((0x000000&0xFF00)>>8))/255.0 blue:((float)(0x000000&0xFF))/255.0 alpha:0.4])];
    leftButton.layer.cornerRadius = 10;
    
    [self.navBar addSubview:leftButton];
    
    
//    leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
//    [navItem setLeftBarButtonItem:leftBarButton];
    
    
    rightButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 16 - 26, 20 + (44 - 26) / 2, 26, 26)];
    [rightButton setTitle:@"🔍" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton setBackgroundColor:([UIColor colorWithRed:((float)((0x000000&0xFF0000)>>16))/255.0 green:((float)((0x000000&0xFF00)>>8))/255.0 blue:((float)(0x000000&0xFF))/255.0 alpha:0.4])];
    rightButton.layer.cornerRadius = 13;
    
    [self.navBar addSubview:rightButton];
//    rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
//    [navItem setRightBarButtonItem:rightBarButton];
    
    
    middleButton = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth - 130) / 2, 20 + (44 - 22) / 2, 130, 22)];
    middleButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [middleButton setTitle:@"门店地图>" forState:UIControlStateNormal];
    [middleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [middleButton setBackgroundColor:([UIColor colorWithRed:((float)((0x000000&0xFF0000)>>16))/255.0 green:((float)((0x000000&0xFF00)>>8))/255.0 blue:((float)(0x000000&0xFF))/255.0 alpha:0.4])];
    middleButton.layer.cornerRadius = 10;
    
    [self.navBar addSubview:middleButton];
//    navItem.titleView = middleButton;
    
    

//    [self requestSensationDetail];
    
    [self.dataArray setArray:[WMAppController sharedInstance].installedApplications];
    
}
- (void)clcik:(id)object{
    NSLog(@"有一个傻逼点击了");
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset_Y = scrollView.contentOffset.y;
    CGFloat alpha = (offset_Y)/230.0f;
    [[[self.navBar subviews] objectAtIndex:0] setAlpha:alpha];
    
    if (offset_Y >= 50){
        if (rightButton.width == 26){
            //        rightButton.hidden = YES;
//            middleButton.hidden = YES;
//            leftButton.hidden = YES;
            
            [UIView animateWithDuration:0.1 animations:^{
                middleButton.alpha = 0.0;
                leftButton.alpha = 0.0;
                
                
                
//                middleButton.frame = CGRectMake((kScreenWidth - width) / 2, 20 + (44 - 22) / 2, width, 22);
            }];
            [UIView animateWithDuration:0.5 animations:^{
                CGFloat width = (self.view.frame.size.width - 32);
                rightButton.frame = CGRectMake(16, 20 + (44 - 26) / 2, width, 26);
            }];
        }
    }else {
        if (rightButton.width  != 26){
            //        rightButton.hidden = NO;
            
//            middleButton.hidden = NO;
//            leftButton.hidden = NO;
            [UIView animateWithDuration:1.0 animations:^{
                middleButton.alpha = 1.0;
                leftButton.alpha = 1.0;
            }];
            
            [UIView animateWithDuration:0.5 animations:^{
                middleButton.alpha = 1.0;
                leftButton.alpha = 1.0;
                rightButton.frame = CGRectMake(kScreenWidth - 16 - 26, 20 + (44 - 26) / 2, 26, 26);
                //                middleButton.frame = CGRectMake((kScreenWidth - 130) / 2, 20 + (44 - 22) / 2, 130, 22);
                
            }];
        }
    }
}

- (void)requestSensationDetail{
    NSDictionary * dict = @{@"_ab":@"1250",
                            @"_app":@"uni",
                            @"_at":@"ab37241b2a77531a",
                            @"_atype":@"iphone",
                            @"_av":@"220",
                            @"_channel":@"NIUAppStore",
                            @"_did":@"23025992-0737-49D8-AB71-98F4FFCCE3BD",
                            @"_fs":@"NIUAppStore220",
                            @"_isRoot":@"0",
                            @"_lang":@"zh_CN",
                            @"_network":@"2",
                            @"_saveMode":@"0",
                            @"_sdklevel":@"9.3.2",
                            @"_swidth":@"750",
                            @"_t":@"1470735971",
                            @"_version":@"2.2.0.1250",
                            @"minfo":@"iPhone7,2",
                            @"userId":@"11few7s"
                            };
    [SensationModel requestSensationDetailWithParam:dict success:^(id responseObject, NSUInteger statusCode) {
        // 数据解析
    } failed:^(NSError *error, NSUInteger statusCode) {
        
    }];
}

#pragma mark -- UITableViewDelegate and UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"CellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    WMApp * app = self.dataArray[indexPath.row];
    cell.imageView.image = app.icon;
    cell.textLabel.text = app.name;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WMApp * app = self.dataArray[indexPath.row];
    [[WMAppController sharedInstance] openApplicationWithBundleID:app.bundleIdentifier];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (void)dealloc{
    [self.tableView removeScalableCover];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldShowGetMore{
    return NO;
}
- (BOOL)shouldShowRefresh{
    return NO;
}
- (NSMutableArray *)dataArray{
    if (_dataArray == nil){
        _dataArray =[NSMutableArray array];
    }
    return _dataArray;
}
- (UIView *)topHeaderView{
    if (!_topHeaderView){
        _topHeaderView = [[SensationDetailHeadIconView alloc] initWithScaleTableView:self.tableView frame:CGRectMake(0, 0, kScreenWidth, UIHeightFromfloat(200))];
    }
    return _topHeaderView;
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


