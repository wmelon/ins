//
//  RootViewController.m
//  中间者设计模式框架搭建
//
//  Created by Sper on 16/5/31.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "RootViewController.h"

#import "HomeViewController.h"
#import "FindViewController.h"
#import "ILikeViewController.h"
#import "MyViewController.h"

@interface RootViewController ()
@property (nonatomic , assign)BOOL isFullscreen;
@end

@implementation RootViewController

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.fd_prefersNavigationBarHidden = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateStatusBar:) name:@"NeedsStatusBarAppearanceUpdate" object:nil];
}
- (void)updateStatusBar:(NSNotification *)noti{
    _isFullscreen = [noti.object boolValue];
}
-(NSArray *)viewControllers{
    HomeViewController * homeVc = [HomeViewController new];
    homeVc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"训练" image:[UIImage imageNamed:@"train"] tag:1];
    homeVc.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    
    FindViewController *findVc = [FindViewController new];
    findVc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:[UIImage imageNamed:@"discovery"] tag:2];
    findVc.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    
    ILikeViewController *iLikeVc = [ILikeViewController new];
    iLikeVc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"关注" image:[UIImage imageNamed:@"trends"] tag:3];
    iLikeVc.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    
    MyViewController *myVc = [MyViewController new];
    myVc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"personal"] tag:4];
    myVc.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    
    return @[homeVc,findVc,iLikeVc,myVc];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)prefersStatusBarHidden{
    if (_isFullscreen) {
        return YES;
    }else{
        return NO;
    }
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
