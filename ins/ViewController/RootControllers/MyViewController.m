//
//  MyViewController.m
//  ins
//
//  Created by Sper on 16/6/26.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "MyViewController.h"

#import "MyOtherInfoViewCell.h"
#import "PersonHeadImageCell.h"
#import "PersonOrderStatusCell.h"

static NSString * kHeadImageCell = @"HeadImageCell";
static NSString * kOrderStatusCell = @"OrderStatusCell";
@interface MyViewController ()

@end

@implementation MyViewController
- (instancetype)init{
    if (self = [super init]){
        self.title = @"我的";
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_svc.rootNaviController setNavigationBarHidden:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49);
    [self.tableView registerNib:[UINib nibWithNibName:@"PersonHeadImageCell" bundle:nil] forCellReuseIdentifier:kHeadImageCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"PersonOrderStatusCell" bundle:nil] forCellReuseIdentifier:kOrderStatusCell];
}

#pragma mark -- UITableViewDelegate and UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 || section == 1){
        return 1;
    }else if (section == 2 || section == 4){
        return 3;
    }else if (section == 3){
        return 2;
    }else {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        PersonHeadImageCell * cell = [tableView dequeueReusableCellWithIdentifier:kHeadImageCell];
        return cell;
    }else if (indexPath.section == 1){
        PersonOrderStatusCell * cell = [tableView dequeueReusableCellWithIdentifier:kOrderStatusCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 2){
        MyOtherInfoViewCell *cell = [MyOtherInfoViewCell cellWithTableView:tableView];
        if(0 == indexPath.row) {
            cell.textLabel.text = @"我的订单";
            cell.icon.image = [UIImage imageNamed:@"my_order"];
            cell.hotWordStr = @"";
            cell.sepLine.hidden = NO;
        }else if (1 == indexPath.row){
            cell.textLabel.text = @"我的钱包";
            cell.icon.image = [UIImage imageNamed:@"my_walle"];
            cell.hotWordStr = @"贵宾卡充值";
            cell.hotWord.textColor = [UIColor lightGrayColor];
            cell.sepLine.hidden = NO;
        }else {
            cell.textLabel.text = @"好友分享";
            cell.icon.image = [UIImage imageNamed:@"friend_share"];
            cell.hotWordStr = @"";
            cell.sepLine.hidden = YES;
        }
        return cell;
    }if (indexPath.section == 3){
        MyOtherInfoViewCell *cell = [MyOtherInfoViewCell cellWithTableView:tableView];
        if(0 == indexPath.row) {
            cell.textLabel.text = @"店铺收藏";
            cell.icon.image = [UIImage imageNamed:@"my_shop_collect"];
            cell.sepLine.hidden = NO;
        }else if (1 == indexPath.row){
            cell.textLabel.text = @"计步器";
            cell.icon.image = [UIImage imageNamed:@"my_step_count"];
            cell.sepLine.hidden = YES;
        }
        return cell;
    }else {
        MyOtherInfoViewCell *cell = [MyOtherInfoViewCell cellWithTableView:tableView];
        if(0 == indexPath.row) {
            cell.textLabel.text = @"客服电话";
            cell.icon.image = [UIImage imageNamed:@"phone_number"];
            cell.sepLine.hidden = NO;
            cell.hotWordStr = @"15170084205";
            cell.hotWord.textColor = [UIColor lightGrayColor];
        }else if (1 == indexPath.row){
            cell.textLabel.text = @"当前版本";
            cell.icon.image = [UIImage imageNamed:@"now_version"];
            cell.hotWordStr = [NSString  stringWithFormat:@"v%@",AppVersion];
            cell.hotWord.textColor = [UIColor lightGrayColor];
            cell.sepLine.hidden = NO;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }else {
            cell.textLabel.text = @"为我们评分";
            cell.icon.image = [UIImage imageNamed:@"Score_for_us"];
            cell.sepLine.hidden = YES;
        }
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (0 == section) {
        return 0.01;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        return 110;
    }else {
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_svc pushViewController:_svc.SensationDetailViewController navigationBarHidden:YES];
}
- (BOOL)shouldShowBackItem{
    return NO;
}
- (BOOL)shouldShowGetMore{
    return NO;
}
- (BOOL)shouldShowRefresh{
    return NO;
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
