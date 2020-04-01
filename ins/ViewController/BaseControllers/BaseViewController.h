//
//  BaseViewController.h
//  中间者设计模式框架搭建
//
//  Created by Sper on 16/5/31.
//  Copyright © 2016年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwitchViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface BaseViewController : UIViewController{
    SwitchViewController * _svc;
}
@property(strong, nonatomic)NSDictionary* intentDic;

//是否显示返回按钮 (默认是YES)
-(BOOL)shouldShowBackItem;
-(void)backItemAction:(UIButton *)button;
-(UIButton *)showRightButton:(NSString *)title image:(UIImage *)image selImage:(UIImage *)selImage;
- (void)rightAction:(UIButton *)button;
@end
