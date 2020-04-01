//
//  WMLiveListViewController.m
//  ins
//
//  Created by Sper on 16/11/14.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "WMLiveListViewController.h"
#import "LiveUserCell.h"
#import "WMLiveShowViewController.h"

static NSString * cellId = @"LiveUserCell";
@interface WMLiveListViewController ()
@property (nonatomic , strong)NSMutableArray * dataArray;
@property (nonatomic , assign)NSInteger pageIndex;
@end

@implementation WMLiveListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LiveUserCell class]) bundle:nil] forCellReuseIdentifier:cellId];
    self.pageIndex = 1;
    [self beginRequest];
}
- (void)requestRefresh{
    NSDictionary * dict = @{@"page" : @(self.pageIndex)};
    [self loadDataWithDict:dict];
}
- (void)requestGetMore{
    self.pageIndex ++;
    NSDictionary * dict = @{@"page" : @(self.pageIndex)};
    [self loadDataWithDict:dict];
}
- (void)loadDataWithDict:(NSDictionary *)dict{
    [LiveUserModel requestLiveListParam:dict Success:^(id responseObject, NSUInteger statusCode) {
        NSArray * array = [LiveUserModel pc_modelListWithArray:responseObject[@"data"][@"list"]];
        if (self.pageIndex == 1){
            [self.dataArray setArray:array];
        }else {
            [self.dataArray addObjectsFromArray:array];
        }
        [self finishRequest];
        [self.tableView reloadData];
    } failed:^(NSError *error, NSUInteger statusCode) {
        [self finishRequest];
    }];
}
- (NSMutableArray *)dataArray{
    if (_dataArray == nil){
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
#pragma  mark -- tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LiveUserCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    [cell setModel:_dataArray[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60 + kScreenWidth;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WMLiveShowViewController *liveVc = [[WMLiveShowViewController alloc] init];
    [liveVc setIntentDic:@{@"lives":self.dataArray , @"currentIndex":@(indexPath.row)}];
    //// 如果调用 [self.navigationController setNavigationBarHidden:YES];隐藏导航栏会导致collectionview的cell（0，0）点在导航栏状态栏下面的（0 ，20）位置。
    [self presentViewController:liveVc animated:YES completion:nil];
//    [_svc presentViewController:liveVc withObjects:@{@"lives":self.dataArray , @"currentIndex":@(indexPath.row)}];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
