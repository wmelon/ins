//
//  WMPageViewController.h
//  UIPageControllerDemo
//
//  Created by 陈仕家 on 16/1/13.
//  Copyright © 2016年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WMPageViewController;

@protocol WMPageViewControllerScrollDelegate <NSObject>
/**
 *  滚动切换视图返回当前页
 *
 *  @param pageViewController 当前控制器
 *  @param currentIndex       当前显示页面
 */
@optional
- (void)pageViewController:(WMPageViewController *)pageViewController currentIndex:(NSInteger)currentIndex;
/**
 *  滚动切换视图返回当前滚动偏移量
 *
 *  @param pageViewController 当前控制器
 *  @param currentOffset      当前偏移量
 */
@optional
- (void)pageViewController:(WMPageViewController *)pageViewController currentOffset:(CGFloat)currentOffset;

@end

@interface WMPageViewController : UIViewController
@property (nonatomic , strong)NSArray * viewControllers; //需要显示的vc数组
@property (nonatomic , assign)BOOL pageScrollEnabled; //是否允许pageVc滚动 默认是NO
@property (nonatomic , weak)id<WMPageViewControllerScrollDelegate> delegate; //返回当前显示页面和偏移量的代理
/**
 *  需要时可以设置想要显示的viewController
 *
 *  @param index    显示viewController的index
 *  @param isBack   滚动的方向是否向后
 *  @param animated 是否需要滚动动画
 */
-(void)setCurrentViewControllerAtIndex:(NSInteger)index animated:(BOOL)animated;
/**
 *  显示头部导航栏
 *
 *  @param titles  导航栏显示的标题数组
 *  @param frame   导航栏的frame
 *  @param control 显示在哪个控制器上面
 */
- (void)showSegmentedControlWithTitleArray:(NSArray *)titles withFrame:(CGRect)frame withViewController:(UIViewController *)control;
@end
