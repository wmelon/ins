//
//  WeChatPublicNoViewController.m
//  ins
//
//  Created by Sper on 16/7/1.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "WeChatPublicNoViewController.h"
#import "WMPageViewController.h"
#import "WeChatPublicNoListViewController.h"

#define kTopSelHeight 44
@interface WeChatPublicNoViewController ()
@property (nonatomic , strong)WMPageViewController *pageViewController;
@end

@implementation WeChatPublicNoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createPageViewController];
}
#pragma mark -- getter and setter
- (void)createPageViewController{
    _pageViewController = [[WMPageViewController alloc] init];
    _pageViewController.view.frame = CGRectMake(0, kTopSelHeight, kScreenWidth, kScreenHeight - kTopSelHeight);
    _pageViewController.pageScrollEnabled = YES;
    NSMutableArray * array = [NSMutableArray array];
    for (int i = 0 ; i < self.segementTitles.count ; i++){
        WeChatPublicNoListViewController * vc = [WeChatPublicNoListViewController new];
        [array addObject:vc];
    }
    _pageViewController.viewControllers = array;
    [_pageViewController showSegmentedControlWithTitleArray:[self segementTitles] withFrame:CGRectMake(0, 0, kScreenWidth, kTopSelHeight) withViewController:self];
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
}
- (NSArray *)segementTitles{
    return @[@"全部",@"娱乐",@"美食",@"时尚"];
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
