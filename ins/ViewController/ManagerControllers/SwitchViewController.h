//
//  SwitchViewController.h
//  中间者设计模式框架搭建
//
//  Created by Sper on 16/5/31.
//  Copyright © 2016年 WM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BaseViewController;

@interface SwitchViewController : NSObject
@property (nonatomic , strong)UINavigationController *rootNaviController;
@property(nonatomic , strong)UIImageView * gifView;
#pragma mark -- 单例创建对象
+ (instancetype)sharedSVC;

#pragma mark -- 提示框显示
/// 弹出纯文本提示
-(void)showMessage:(NSString *)message;
/// 弹出加载loaging
-(void)showLoadingWithMessage:(NSString*)message;
/// 弹出gif动画的提示
-(void)showGifLoding:(NSArray *)images message:(NSString *)message;
/// 隐藏提示
-(void)hideHud;
/// 取消GIF加载动画
- (void)hideGufLoding;

#pragma mark -- 页面跳转

-(void)pushViewController:(BaseViewController*)vc;
-(void)pushViewController:(BaseViewController*)vc navigationBarHidden:(BOOL)barHidden;
-(void)pushViewController:(BaseViewController*)vc withObjects:(NSDictionary*)intentDic;
-(void)pushViewController:(BaseViewController*)vc withObjects:(NSDictionary*)intentDic navigationBarHidden:(BOOL)barHidden;
-(void)presentViewController:(BaseViewController*)vc;
-(void)presentViewController:(BaseViewController*)vc withObjects:(NSDictionary*)intentDic;
-(BaseViewController*)popViewController;

#pragma mark -- 业务控制器跳转层
/**公众号详情界面*/
-(BaseViewController *)WeChatPublicNoDetailViewController;
/**地图定位导航界面*/
-(BaseViewController *)MapRouteNavigationViewController;
// 网红详情界面
-(BaseViewController *)SensationDetailViewController;
/// 直播控制器
-(BaseViewController *)WMLiveShowViewController;
/// 直播列表数据
-(BaseViewController *)WMLiveListViewController;
@end
