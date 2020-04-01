//
//  BaseTabBarViewController.m
//  中间者设计模式框架搭建
//
//  Created by Sper on 16/5/31.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "AppTabBar.h"

#define KNotificationStringTabBarController @"TabBarControllerSelectedIndex"
@interface BaseTabBarViewController ()<UITabBarControllerDelegate>
@property (nonatomic , strong)UITabBarController * tabBarController;
@property (nonatomic , strong)AppTabBar * myTabBar; //自定制tabbar
@end

@implementation BaseTabBarViewController
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (instancetype)init{
    if (self = [super init]){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarControllerSelectedIndex:) name:KNotificationStringTabBarController object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tabBarController = [[UITabBarController alloc] init];

    [_tabBarController willMoveToParentViewController:self];
    [self addChildViewController:_tabBarController];
    [_tabBarController didMoveToParentViewController:self];
    [self.tabBarController setValue:self.myTabBar forKeyPath:@"tabBar"];
    _tabBarController.delegate = self;
    [_tabBarController setViewControllers:[self viewControllers] animated:NO];
    [_tabBarController setSelectedIndex:[self defaultSelectedIndex]];
    _tabBarController.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    [self.view addSubview:_tabBarController.view];
    
    [self tabBarController:_tabBarController didSelectViewController:_tabBarController.selectedViewController];
}
-(void)tabBarControllerSelectedIndex:(NSNotification *)notification{
    NSInteger index = [notification.object[@"index"] integerValue];
    self.selectedIndex = index;
}
-(NSArray*)viewControllers {
    NSLog(@"%@ currently no viewController, please overwrite %s",NSStringFromClass(self.class),__FUNCTION__);
    return nil;
}
- (NSInteger)defaultSelectedIndex{
    return 0;
}
-(void)setSelectedIndex:(NSInteger)index {
    [_tabBarController setSelectedIndex:index];
    [self updateNavigationBar];
}
-(NSInteger)selectedIndex {
    return [_tabBarController selectedIndex];
}
#pragma mark - tabbarController delegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0) {
    return [self shouldSelectIndex:[tabBarController.viewControllers indexOfObject:viewController] viewController:viewController];
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    [self updateNavigationBar];
}
-(BOOL)shouldSelectIndex:(NSInteger)index viewController:(UIViewController *)viewController{
    return YES;
}
- (void)updateNavigationBar{
    UIViewController* selectedVC = [_tabBarController selectedViewController];
    self.navigationItem.leftBarButtonItems = selectedVC.navigationItem.leftBarButtonItems;
    self.navigationItem.rightBarButtonItems = selectedVC.navigationItem.rightBarButtonItems;
    self.navigationItem.backBarButtonItem = selectedVC.navigationItem.backBarButtonItem;
    self.navigationItem.titleView = selectedVC.navigationItem.titleView;
    self.navigationItem.title = selectedVC.navigationItem.title;
    self.title = selectedVC.title;
}
- (AppTabBar *)myTabBar{
    if (_myTabBar == nil){
        _myTabBar = [AppTabBar new];
        _myTabBar.tabBarItems = [[_tabBarController viewControllers] count];
    }
    return _myTabBar;
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
