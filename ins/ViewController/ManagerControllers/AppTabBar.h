//
//  AppTabBar.h
//  中间者设计模式框架搭建
//
//  Created by Sper on 16/5/31.
//  Copyright © 2016年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppTabBar : UITabBar
/**显示按钮个数*/
@property (nonatomic , assign)NSInteger tabBarItems;
@end


@interface TabBarCenterButton : UIButton

@end