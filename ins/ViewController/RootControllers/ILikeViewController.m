//
//  ILikeViewController.m
//  ins
//
//  Created by Sper on 16/6/26.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "ILikeViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "ZOZolaZoomTransition.h"
#import "XHWaterCollectionCell.h"
#import "PinDetailViewController.h"

static NSString * cellID = @"XHHuabanCollectionCell";

@interface ILikeViewController ()<CHTCollectionViewDelegateWaterfallLayout,ZOZolaZoomTransitionDelegate,UINavigationControllerDelegate>
@property (nonatomic , strong)NSMutableArray * dataSource;
@property (nonatomic , strong)XHWaterCollectionCell * selectedCell;
@property (nonatomic , assign)NSInteger page;
@property (nonatomic , assign)CGFloat offY;
@end

@implementation ILikeViewController
- (instancetype)init{
    if (self = [super init]){
        self.title = @"关注";
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
    CHTCollectionViewWaterfallLayout * layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    layout.columnCount = 2;
    // Change individual layout attributes for the spacing between cells
    layout.minimumColumnSpacing = 10.0;
    layout.minimumInteritemSpacing = 10.0;
    //  设置collectionView的 四周的内边距
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self.collectionView registerNib:[UINib nibWithNibName:@"XHWaterCollectionCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    self.navigationController.delegate = self;
    [self beginRequest];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.collectionView.contentOffset.y < self.collectionView.contentSize.height - kScreenHeight){
        if (self.collectionView.contentOffset.y > _offY){
            [UIView animateWithDuration:0.5 animations:^{
                self.tabBarController.tabBar.y = kScreenHeight;
            }];
        }else {
            [UIView animateWithDuration:0.5 animations:^{
                self.tabBarController.tabBar.y = kScreenHeight - 49;
            }];
        }
        _offY = self.collectionView.contentOffset.y;
    }else {
        _offY = self.collectionView.contentOffset.y;
        [UIView animateWithDuration:0.5 animations:^{
            self.tabBarController.tabBar.y = kScreenHeight;
        }];
    }
}

- (void)requestRefresh{
    self.page = 1;
    [self requestData];
}
- (void)requestGetMore{
    self.page += 1;
    [self requestData];
}
- (void)requestData{
    [HuabanModel requestHuaBanList:@{@"page":@(self.page)} Success:^(id responseObject, NSUInteger statusCode) {
        if (self.page == 1){
            [self.dataSource setArray:[HuabanModel pc_modelListWithArray:responseObject[@"pins"]]];
        }else {
            [self.dataSource addObjectsFromArray:[HuabanModel pc_modelListWithArray:responseObject[@"pins"]]];
        }
        [self.collectionView reloadData];
        [self finishRequest];
    } failed:^(NSError *error, NSUInteger statusCode) {
        [self finishRequest];
    }];
}
#pragma mark -- collectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    HuabanModel * model = self.dataSource[indexPath.row];
    return [XHWaterCollectionCell getSize:model];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XHWaterCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    [cell setModel:self.dataSource[indexPath.row]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //MARK: - UICollectionViewDelegate
    _selectedCell = (XHWaterCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    CGRect frrr = [self.view convertRect:_selectedCell.frame fromView:collectionView];
    CGPoint point = self.collectionView.contentOffset;
    point.y -= self.collectionView.frame.size.height*0.5 - (frrr.origin.y+frrr.size.height*0.5);
    if (point.y < -64) {
        point.y = -64;
    }
    [self.collectionView setContentOffset:point animated:YES];
    self.view.frame = CGRectMake(0, 0, kScreenWidth, [UIScreen mainScreen].bounds.size.height);
    
    PinDetailViewController * vc = [PinDetailViewController new];
    vc.model = self.dataSource[indexPath.item];
    [self.navigationController pushViewController:vc animated:YES];
}
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
//    if (fromVC != self && toVC != self)  {
//        return nil;
//    }
    if (![fromVC isKindOfClass:[PinDetailViewController class]] && ![toVC isKindOfClass:[PinDetailViewController class]]){
        return nil;
    }
    NSInteger type = (operation == UINavigationControllerOperationPush) ? ZOTransitionTypePresenting : ZOTransitionTypeDismissing;
    
    if (type == ZOTransitionTypeDismissing) {
        //        [self.collectionView setContentOffset:CGPointMake(0 , -64) animated: false];
    }
    
    ZOZolaZoomTransition * zoomTransition =  [[ZOZolaZoomTransition alloc] initWithTargetView:_selectedCell.photoImageView type:type duration:0.5 delegate:self];
    
    zoomTransition.fadeColor = self.view.backgroundColor;
    
    return zoomTransition;
    
    return nil;
}

- (CGRect)zolaZoomTransition:(ZOZolaZoomTransition *)zoomTransition
        startingFrameForView:(UIView *)targetView
              relativeToView:(UIView *)relativeView
          fromViewController:(UIViewController *)fromViewController
            toViewController:(UIViewController *)toViewController{
    CGRect rect = CGRectZero;
    
    if (zoomTransition.type == ZOTransitionTypePresenting) {
        
        if (fromViewController == self) {
            UIView * view = targetView;
            rect = [view convertRect:view.bounds toView:relativeView];
        } else {
            UIView * view = targetView;
            rect = [view convertRect:view.bounds toView:relativeView];
        }
        
    } else {
        PinDetailViewController * vc = (PinDetailViewController *)fromViewController;
        UIView * view = vc.imageView;
        rect = [view convertRect:view.bounds toView:relativeView];
    }
    return rect;
    
}

- (CGRect)zolaZoomTransition:(ZOZolaZoomTransition *)zoomTransition
       finishingFrameForView:(UIView *)targetView
              relativeToView:(UIView *)relativeView
          fromViewController:(UIViewController *)fromViewComtroller
            toViewController:(UIViewController *)toViewController{
    CGRect rect = CGRectZero;
    
    if (zoomTransition.type == ZOTransitionTypePresenting) {
        
        PinDetailViewController * vc = (PinDetailViewController *)toViewController;
        UIView * view = vc.imageView;
        rect = [view convertRect:view.bounds toView:relativeView];
        
    } else {
        UIView * view = targetView;
        rect = [view convertRect:view.bounds toView:relativeView];
    }
    return rect;
}
- (NSArray *)supplementaryViewsForZolaZoomTransition:(ZOZolaZoomTransition *)zoomTransition{
    if (zoomTransition.type == ZOTransitionTypePresenting) {
        return nil;
    }
    
    NSMutableArray * clippedCells = [NSMutableArray array];
    [self.collectionView.visibleCells enumerateObjectsUsingBlock:^(__kindof UICollectionViewCell * _Nonnull visibleCell, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect convertedRect = [visibleCell convertRect:visibleCell.bounds toView:self.view];
        if (!CGRectContainsRect(self.view.frame, convertedRect)){
            [clippedCells addObject:visibleCell];
        }
    }];
    return clippedCells;
}
- (CGRect)zolaZoomTransition:(ZOZolaZoomTransition *)zoomTransition
   frameForSupplementaryView:(UIView *)supplementaryView
              relativeToView:(UIView *)relativeView{
    if (zoomTransition.type == ZOTransitionTypeDismissing) {
        return CGRectZero;
    }
    
    return [supplementaryView convertRect:supplementaryView.bounds toView:relativeView];
}

- (NSMutableArray *)dataSource{
    if (!_dataSource){
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
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
