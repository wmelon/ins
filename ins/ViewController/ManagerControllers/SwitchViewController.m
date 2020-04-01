//
//  SwitchViewController.m
//  中间者设计模式框架搭建
//
//  Created by Sper on 16/5/31.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "SwitchViewController.h"
#import "RootViewController.h"
#import "AppNavigationBar.h"
#import "UIImageView+GifShow.h"

#import "WeChatPublicNoDetailViewController.h"
#import "MapRouteNavigationViewController.h"
#import "SensationDetailViewController.h"
#import "WMLiveShowViewController.h"
#import "WMLiveListViewController.h"

@interface SwitchViewController()
@property(weak, nonatomic)UINavigationController* topNavigationController;
@property(strong, nonatomic)MBProgressHUD* hud;
@end

@implementation SwitchViewController

+ (instancetype)sharedSVC{
    static dispatch_once_t onceToken;
    static SwitchViewController * svc;
    dispatch_once(&onceToken, ^{
        svc = [[SwitchViewController alloc] init];
    });
    return svc;
}
- (UINavigationController *)rootNaviController{
    if (_rootNaviController == nil){
        RootViewController * rootVc = [[RootViewController alloc] init];
        _rootNaviController = [self aNavigationControllerWithRootViewController:rootVc];
    }
    return _rootNaviController;
}
-(UINavigationController *)aNavigationControllerWithRootViewController:(BaseViewController*)vc {
    UINavigationController* navi = [[UINavigationController alloc] initWithNavigationBarClass:[AppNavigationBar class] toolbarClass:nil];
    [navi pushViewController:vc animated:NO];
    return navi;
}
- (UINavigationController *)topNavigationController{
    _topNavigationController = self.rootNaviController;
    if (_topNavigationController == nil){
        return nil;
    }
    return _topNavigationController;
}


#pragma mark -- 提示框显示
-(void)hideHud{
    [self.hud hide:YES];
}
-(void)showMessage:(NSString *)message{
    [self showMessage:message duration:1.5];
}
-(void)showMessage:(NSString *)message duration:(NSTimeInterval)time{
    [_hud removeFromSuperview];
    UIWindow* keyWindow = [UIApplication sharedApplication].keyWindow;
    _hud = [[MBProgressHUD alloc] initWithWindow:keyWindow];
    _hud.animationType = MBProgressHUDAnimationZoom;
    [keyWindow addSubview:_hud];
    self.hud.mode = MBProgressHUDModeText;
    self.hud.mode = MBProgressHUDModeText;
    self.hud.detailsLabelText = message;
    [self.hud show:YES];
    [self.hud hide:YES afterDelay:time];
}
-(void)showLoadingWithMessage:(NSString*)message{
    [_hud removeFromSuperview];
    UIWindow* keyWindow = [UIApplication sharedApplication].keyWindow;
    _hud = [[MBProgressHUD alloc] initWithWindow:keyWindow];
    _hud.animationType = MBProgressHUDAnimationZoom;
    [keyWindow addSubview:_hud];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.detailsLabelText = message;
    [self.hud show:YES];
}
-(void)showGifLoding:(NSArray *)images message:(NSString *)message{
    if (!images.count) {
        images = @[[UIImage imageNamed:@"hold1_60x72"], [UIImage imageNamed:@"hold2_60x72"], [UIImage imageNamed:@"hold3_60x72"]];
    }
    UIImageView *gifView = [[UIImageView alloc] init];
    UIWindow* keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:gifView];
    [gifView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.equalTo(@60);
        make.height.equalTo(@70);
    }];
    self.gifView = gifView;
    [gifView playGifAnim:images];
}
// 取消GIF加载动画
- (void)hideGufLoding
{
    [self.gifView stopGifAnim];
    self.gifView = nil;
}

#pragma mark -- 页面跳转

-(void)pushViewController:(BaseViewController*)vc{
    [self.topNavigationController pushViewController:vc animated:YES];
}
-(void)pushViewController:(BaseViewController*)vc navigationBarHidden:(BOOL)barHidden{
    vc.fd_prefersNavigationBarHidden = barHidden;
    [self pushViewController:vc];
}
-(void)pushViewController:(BaseViewController*)vc withObjects:(NSDictionary*)intentDic{
    vc.intentDic = intentDic;
    [self pushViewController:vc];
}
-(void)pushViewController:(BaseViewController*)vc withObjects:(NSDictionary*)intentDic navigationBarHidden:(BOOL)barHidden{
    vc.intentDic = intentDic;
    vc.fd_prefersNavigationBarHidden = barHidden;
    [self pushViewController:vc];
}
-(BaseViewController*)popViewController{
    BaseViewController* vc = (BaseViewController*)[self.topNavigationController popViewControllerAnimated:YES];
    return vc;
}
-(void)presentViewController:(BaseViewController*)vc{
    UINavigationController* navi = [self aNavigationControllerWithRootViewController:vc];
    [self.topNavigationController presentViewController:navi animated:YES completion:NULL];
    self.topNavigationController = navi;
}
-(void)presentViewController:(BaseViewController*)vc withObjects:(NSDictionary*)intentDic{
    vc.intentDic = intentDic;
    [self presentViewController:vc];
}



#pragma mark -- 业务控制器跳转层
/**公众号详情界面*/
-(BaseViewController *)WeChatPublicNoDetailViewController{
    WeChatPublicNoDetailViewController * vc = [WeChatPublicNoDetailViewController new];
    return vc;
}
// 高德地图导航界面
-(BaseViewController *)MapRouteNavigationViewController{
    MapRouteNavigationViewController *vc = [MapRouteNavigationViewController new];
    return vc;
}
// 网红详情界面
-(BaseViewController *)SensationDetailViewController{
    SensationDetailViewController *vc = [SensationDetailViewController new];
    return vc;
}
/// 直播控制器
-(BaseViewController *)WMLiveShowViewController{
    WMLiveShowViewController * vc = [WMLiveShowViewController new];
    return vc;
}
/// 直播列表数据
-(BaseViewController *)WMLiveListViewController{
    WMLiveListViewController *vc = [WMLiveListViewController new];
    return vc;
}
@end
