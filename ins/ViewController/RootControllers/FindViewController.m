//
//  FindViewController.m
//  ins
//
//  Created by Sper on 16/6/26.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "FindViewController.h"
#import "VideoPlayViewController.h"
#import "WeChatPublicNoViewController.h"

#import "WMPageViewController.h"
#import "XlSegementControl.h"

@interface FindViewController ()<WMPageViewControllerScrollDelegate,XlSegementControlDetegate>
@property (nonatomic, strong) WMPageViewController * pageViewController;
@property (nonatomic, strong) XlSegementControl *segmentedControl;
@property (nonatomic, strong) UIImageView *bgImage;
@property (nonatomic, strong) UIImageView *selImage;
@end

@implementation FindViewController
- (instancetype)init{
    if (self = [super init]){
        self.title = @"发现";
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_svc.rootNaviController setNavigationBarHidden:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [self aSegmentedControl];
    [self showRightButton:@"开始直播" image:nil selImage:nil];
    [self createPageViewController];
}

#pragma mark -- getter and setter
- (void)createPageViewController{
    _pageViewController = [[WMPageViewController alloc] init];
    _pageViewController.view.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64);
    _pageViewController.pageScrollEnabled = NO;
    _pageViewController.delegate = self;
    NSMutableArray * array = [NSMutableArray array];
    for (int i = 0 ; i < self.segementTitles.count ; i++){
        if (i == 0){  //视频播放
            VideoPlayViewController *vc = [VideoPlayViewController new];
            [array addObject:vc];
        }else {
            WeChatPublicNoViewController *vc = [WeChatPublicNoViewController new];
            [array addObject:vc];
        }
    }
    _pageViewController.viewControllers = array;
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
}
-(XlSegementControl*)aSegmentedControl {
    NSInteger count = self.segementTitles.count;
    NSMutableArray* arr = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i ++) {
        XlSegementItem* item = [XlSegementItem itemWithTitle:self.segementTitles[i] image:nil highlightedImage:nil];
        [arr addObject:item];
    }
    _segmentedControl = [[XlSegementControl alloc] initWithItems:arr];
    _segmentedControl.frame = CGRectMake(0, 0, 144, 24);
    _segmentedControl.tag = 9999;
    _segmentedControl.delegate = self;
    _segmentedControl.font = [UIFont systemFontOfSize:14];
    _segmentedControl.textColor =  [UIColor whiteColor];
    _segmentedControl.selectTextColor = UIColorFromRGB(0x333333);
    
    _bgImage = [[UIImageView alloc] init];
    _bgImage.image = [UIImage imageNamed:@"tab_blank"];
    _bgImage.frame = CGRectMake(0,0, _segmentedControl.width, _segmentedControl.height);
    _selImage = [[UIImageView alloc] init];
    _selImage.image = [UIImage imageNamed:@"tab_highlighted"];
    _selImage.frame = CGRectMake(0,0,72 , _segmentedControl.height);
    [_bgImage addSubview:_selImage];
    [_segmentedControl.backgroundView addSubview:_bgImage];
    
    _segmentedControl.lineColor = [UIColor clearColor];
    return _segmentedControl;
}
- (NSArray *)segementTitles{
    return @[@"视频",@"公众号"];
}
-(void)segmentedControl:(XlSegementControl*)segmentedControl didSelectIndex:(NSInteger)index
{
    [UIView animateWithDuration:0.2 animations:^{
        if (index == 0) {
            _selImage.frame = CGRectMake(0,0,72 , segmentedControl.height);
        } else {
            _selImage.frame = CGRectMake(72,0,72 , segmentedControl.height);
        }
    }];
    //切换视图控制器
    [self.pageViewController setCurrentViewControllerAtIndex:index animated:YES];
}
#pragma mark -- wmPageViewCOntrollerDelagate
- (void)pageViewController:(WMPageViewController *)pageViewController currentIndex:(NSInteger)currentIndex{
    [self segmentedControl:_segmentedControl didSelectIndex:currentIndex];
}

- (void)selectSegmentIndex {
    _segmentedControl.selectedSegmentIndex = 1;
    [self segmentedControl:_segmentedControl didSelectIndex:1];
    
}

/// 进入直播界面
- (void)rightAction:(UIButton *)button{
    [_svc pushViewController:_svc.WMLiveListViewController];
}


- (BOOL)shouldShowBackItem{
    return NO;
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
