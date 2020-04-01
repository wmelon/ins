//
//  BaseViewController.m
//  中间者设计模式框架搭建
//
//  Created by Sper on 16/5/31.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "BaseViewController.h"
#import "AppNavigationBar.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)dealloc{
    NSLog(@"dealloc____%@______",self);
}
- (instancetype)init{
    if (self = [super init]){
        _svc = [SwitchViewController sharedSVC];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor pageBackgroundColor];
    // Do any additional setup after loading the view.
    if([self shouldShowBackItem]){
        [self showBackItem];
    }
}
-(void)showBackItem {
    UIButton* btn = [self.class buttonWithImage:[UIImage imageNamed:@"back"] title:nil target:self action:@selector(backItemAction:)];
    btn.frame = CGRectMake(0, 0, 28, 28);
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    btn.adjustsImageWhenHighlighted = NO;
    [self addItemForLeft:YES withItem:item spaceWidth:-8];
}
+ (UIButton*)buttonWithImage:(UIImage*)image title:(NSString*)title target:(id)target action:(SEL)action {
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (title) {
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateNormal];
    } else {
        [btn setImage:image forState:UIControlStateNormal];
    }
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    return btn;
}
-(void)addItemForLeft:(BOOL)left withItem:(UIBarButtonItem*)item spaceWidth:(CGFloat)width {
    UIBarButtonItem *space = [[UIBarButtonItem alloc]
                              initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                              target:nil action:nil];
    space.width = width;
    if (left) {
        self.navigationItem.leftBarButtonItems = @[space,item];
    } else {
        self.navigationItem.rightBarButtonItems = @[space,item];
    }
}
-(UIButton *)showRightButton:(NSString *)title image:(UIImage *)image selImage:(UIImage *)selImage{
    UIButton *button = [self.class buttonWithImage:image title:title target:self action:@selector(rightAction:)];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    button.contentEdgeInsets = UIEdgeInsetsZero;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addItemForLeft:NO withItem:item spaceWidth:0];
    return button;
}
- (void)rightAction:(UIButton *)button
{
    NSLog(@"子类需重写%s",__FUNCTION__);
}
- (void)backItemAction:(UIButton *)button{
    [_svc popViewController];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldShowBackItem{
    return YES;
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
