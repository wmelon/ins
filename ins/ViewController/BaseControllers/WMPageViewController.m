//
//  WMPageViewController.m
//  UIPageControllerDemo
//
//  Created by 陈仕家 on 16/1/13.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "WMPageViewController.h"
#import "XlSegementControl.h"

@interface WMPageViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate ,UIScrollViewDelegate,XlSegementControlDetegate>{
    UIScrollView __weak* _scrollView;  //UIPageViewController内部的scrollView
    NSInteger _currentIndex;    //当前显示的页面
}
@property (nonatomic , strong)UIPageViewController * pageController; 
@property (nonatomic , strong)XlSegementControl * segmentedControl;
@end

@implementation WMPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)showSegmentedControlWithTitleArray:(NSArray *)titles withFrame:(CGRect)frame withViewController:(UIViewController *)control{
    if (!_segmentedControl) {
        _segmentedControl = [self aSegmentedControlWithTitle:titles];
        _segmentedControl.frame = frame;
        [control.view addSubview:_segmentedControl];
    }
}

-(XlSegementControl*)aSegmentedControlWithTitle:(NSArray *)titles {
    
    XlSegementControl * segmentedControl = [[XlSegementControl alloc] initWithSegmentViews:titles];
    segmentedControl.tag = 9999;
    segmentedControl.delegate = self;
    segmentedControl.backgroundView.backgroundColor = [UIColor whiteColor];
    segmentedControl.backgroundView.alpha = 1;
    segmentedControl.separatorImage = [UIImage buildImageWithColor:[UIColor clearColor]];
    segmentedControl.font = [UIFont systemFontOfSize:14];
    segmentedControl.textColor =  UIColorFromRGB(0x333333);
    segmentedControl.selectTextColor = [UIColor mainColor];
    segmentedControl.lineColor = [UIColor mainColor];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 43.5, kScreenWidth, 0.5)];
    line.backgroundColor = [UIColor lineColor];
    [segmentedControl addSubview:line];
    
    return segmentedControl;
}

#pragma mark - segmentedControl delegate

-(void)segmentedControl:(XlSegementControl*)segmentedControl didSelectIndex:(NSInteger)index{
    if ([self.delegate respondsToSelector:@selector(pageViewController:currentIndex:)]){
        [self.delegate pageViewController:self currentIndex:index];
    }
    /**切换视图控制器*/
    [_pageController setViewControllers:@[_viewControllers[index]] direction:UIPageViewControllerNavigationDirectionForward
                               animated:NO
                             completion:nil];
}

-(void)setCurrentViewControllerAtIndex:(NSInteger)index animated:(BOOL)animated{
    [_pageController setViewControllers:@[_viewControllers[index]] direction:UIPageViewControllerNavigationDirectionForward
                               animated:NO
                             completion:nil];
    [_segmentedControl setSelectedSegmentIndex:index];
}
/**
 *  初始化pageController
 */
- (void)createPageController{
    // 设置UIPageViewController的配置项
    NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] forKey: UIPageViewControllerOptionSpineLocationKey];
    
    // 实例化UIPageViewController对象，根据给定的属性
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options: options];
    
    // 设置UIPageViewController对象的代理
    _pageController.dataSource = self;
    _pageController.delegate = self;
    [[_pageController view] setFrame:[[self view] bounds]];
    
    // UIPageViewController对象要显示的页数据封装成为一个NSArray。
    // 因为我们定义UIPageViewController对象显示样式为显示一页（options参数指定）。
    // 如果要显示2页，NSArray中，应该有2个相应页数据。
    [_pageController setViewControllers:@[[_viewControllers firstObject]]
                              direction:UIPageViewControllerNavigationDirectionForward
                               animated:NO
                             completion:nil];
    
    // 在页面上，显示UIPageViewController对象的View
    [self addChildViewController:_pageController];
    [[self view] addSubview:[_pageController view]];
    [_pageController didMoveToParentViewController:self];
    
    _scrollView = [self aScrollViewOfView:_pageController.view];
    _scrollView.delegate = self;
    _scrollView.scrollEnabled = _pageScrollEnabled;
}
/**
 *  获得某view的subviews中第一个scrollView
 */
-(UIScrollView*)aScrollViewOfView:(UIView*)view {
    for (UIView* v in [view subviews]) {
        if ([v isKindOfClass:[UIScrollView class]]) {
            return (UIScrollView*)v;
        } else {
            [self aScrollViewOfView:v];
        }
    }
    return nil;
}
- (void)setPageScrollEnabled:(BOOL)pageScrollEnabled{
    _pageScrollEnabled = pageScrollEnabled;
}

/**
 *  初始化所有viewController
 */
- (void)setViewControllers:(NSArray *)viewControllers{
    _viewControllers = viewControllers;
    [self createPageController]; // 初始化pageViewController控制器
}

/**
 *  得到相应的VC对象
 *
 *  @param index 数组下标
 *
 *  @return 视图控制器
 */
- (UIViewController *)viewControllerAtIndex:(NSUInteger)index {
    if (([_viewControllers count] == 0) || (index >= [_viewControllers count])) {
        return nil;
    }
    // 获取控制器类
    UIViewController *dataViewController = _viewControllers[index];
    return dataViewController;
}

#pragma mark -- UIPageViewControllerDataSource 代理方法

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSUInteger index = [_viewControllers indexOfObject:viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    // 返回的ViewController，将被添加到相应的UIPageViewController对象上。
    return [self viewControllerAtIndex:index];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSUInteger index = [_viewControllers indexOfObject:viewController];
    if (index == NSNotFound || index == ([_viewControllers count] - 1)) {
        return nil;
    }
    index++;
    return [self viewControllerAtIndex:index];
}

#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    NSInteger index = [_viewControllers indexOfObject:pageViewController.viewControllers.firstObject];
    if ([self.delegate respondsToSelector:@selector(pageViewController:currentIndex:)]){
        [self.delegate pageViewController:self currentIndex:index];
    }
    _currentIndex = index;
    [_segmentedControl setSelectedSegmentIndex:_currentIndex];
}

#pragma mark - UIScrollViewDelegate  左右滑动切换视图

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.x - self.view.frame.size.width;
    if ([self.delegate respondsToSelector:@selector(pageViewController:currentOffset:)]){
        [self.delegate pageViewController:self currentOffset:offset];
    }
}

@end
