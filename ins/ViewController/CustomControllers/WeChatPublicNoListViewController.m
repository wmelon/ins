//
//  WeChatPublicNoListViewController.m
//  ins
//
//  Created by Sper on 16/7/1.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "WeChatPublicNoListViewController.h"
#import "WeChatPublicNoCell.h"

@interface WeChatPublicNoListViewController ()

@end

@implementation WeChatPublicNoListViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (!self.rows.count){
        [self beginRequest];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49);
}
- (void)requestRefresh{
    NSDictionary * dict = @{@"kol_features":@[],@"verify":@[],@"kol_keywords":@[],@"kol_brands":@[],@"kol_product_models":@[],@"kol_locations":@[],@"kol_type":@[@"biz"],@"kol_category":@[]};
    
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:@"" forKey:@"term"];
    [param setObject:@(10) forKey:@"size"];
    [param setObject:@"influence" forKey:@"order_by"];
    [param setObject:dict forKey:@"filters"];
    [param setObject:@"" forKey:@"kol_id"];
    [param setObject:@(0) forKey:@"from"];
    [WeChatPublicNoModel requestWeChatPublicNoWithParam:param success:^(id responseObject, NSUInteger statusCode) {
        for (NSDictionary * video in [responseObject objectForKey:@"wechat"]) {
            WeChatPublicNoModel * model = [[WeChatPublicNoModel alloc] init];
            [model setValuesForKeysWithDictionary:video];
            [self.rows addObject:model];
        }
        [self.tableView reloadData];
        [self finishRequest];
    } failed:^(NSError *error, NSUInteger statusCode) {
        [self finishRequest];
    }];
}
#pragma mark -- UITableViewDelegate and UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rows.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeChatPublicNoCell * cell = [WeChatPublicNoCell cellWithTableView:tableView];
    if (self.rows.count){
        [cell setModel:self.rows[indexPath.row]];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 92;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_svc pushViewController:_svc.SensationDetailViewController navigationBarHidden:YES];
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
