//
//  BaseTableViewController.m
//  ins
//
//  Created by Sper on 16/6/26.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:[self tableViewStyle]];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    if([_tableView respondsToSelector:@selector(setSeparatorInset:)]){
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    [self addNewDataRefresh];
    [self addMoreDataRefresh];
    [self.view addSubview:_tableView];
    
    _rows = [NSMutableArray array];
}
// 添加下拉刷新
- (void)addNewDataRefresh {
    __weak typeof(self) weakself = self;
    if ([self shouldShowRefresh]) {
        // 下拉刷新
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakself requestRefresh];
        }];
        
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        _tableView.mj_header.automaticallyChangeAlpha = YES;
    }
}
// 添加上拉加载更多
- (void)addMoreDataRefresh {
    __weak typeof(self) weakself = self;
    if ([self shouldShowGetMore]) {
        // 上拉刷新
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakself requestGetMore];
        }];
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        _tableView.mj_footer.automaticallyChangeAlpha = YES;
   }
}
/**开始刷新*/
-(void)beginRequest{
    [_tableView.mj_header beginRefreshing];
}
/**停止刷新*/
-(void)finishRequest{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
-(void)requestRefresh{
    NSLog(@"%s 需要重写",__FUNCTION__);
    [self finishRequest];
}
-(void)requestGetMore{
    NSLog(@"%s 需要重写",__FUNCTION__);
    [self finishRequest];
}
#pragma mark-  tableView delegate dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rows.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor clearColor];
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor clearColor];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - overridable
-(BOOL)shouldShowGetMore{
    return YES;
}

-(BOOL)shouldShowRefresh{
    return YES;
}
- (UITableViewStyle)tableViewStyle{
    return UITableViewStylePlain;
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
