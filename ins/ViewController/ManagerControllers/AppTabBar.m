//
//  AppTabBar.m
//  中间者设计模式框架搭建
//
//  Created by Sper on 16/5/31.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "AppTabBar.h"
#import "SwitchViewController.h"
@class TabBarCenterButton;
@interface AppTabBar(){
    SwitchViewController * _svc;
}
@property (nonatomic , strong)TabBarCenterButton * centerButton;
@end

@implementation AppTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.tintColor = [UIColor mainColor];
        self.barTintColor = [UIColor whiteColor];
        
        _svc = [SwitchViewController sharedSVC];
        
//        CGFloat width = [UIScreen mainScreen].bounds.size.width;
//        _centerButton = [[TabBarCenterButton alloc] init];
//        CGFloat buttonW = width/(self.tabBarItems + 1);
//        CGFloat buttonH = _centerButton.imageView.image.size.height + 21;
//        CGFloat buttonX = (width - buttonW)/2;
//        CGFloat buttonY = 0;
//        _centerButton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
//        [self addSubview:_centerButton];
//        [_centerButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
//- (void)publishClick{
//    [_svc pushViewController:_svc.test1ViewController];
//}
////重新布局tabbar下面的按钮位置
//- (void)layoutSubviews{
//    [super layoutSubviews];
//    // 原来的4个
//    CGFloat width = self.frame.size.width / (self.tabBarItems + 1);
//    int index = 0;
//    for (UIControl *control in self.subviews) {
//        if (![control isKindOfClass:[UIControl class]] || [control isKindOfClass:[UIButton class]]) continue;
//        CGFloat x = index > 1 ? width * (index + 1) : width * index;
//        control.frame = CGRectMake(x, control.frame.origin.y, width, control.frame.size.height);
//        index++;
//    }
//}
@end

@implementation TabBarCenterButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageNamed:@"hood"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"hood-selected"] forState:UIControlStateHighlighted];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat x = (self.frame.size.width - self.imageView.image.size.width)/2;
    self.imageView.frame = CGRectMake(x, 0, self.imageView.image.size.width, self.imageView.image.size.height);
}
@end
