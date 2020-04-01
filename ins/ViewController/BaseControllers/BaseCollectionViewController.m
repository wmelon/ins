//
//  BaseCollectionViewController.m
//  ins
//
//  Created by Sper on 16/7/31.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "BaseCollectionViewController.h"

@interface BaseCollectionViewController ()
@property(nonatomic, strong)UICollectionViewFlowLayout *flowLayout;
@end

@implementation BaseCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;

    // Do any additional setup after loading the view.
    [self setupCollectionView];
    [self addNewDataRefresh];
    [self addMoreDataRefresh];
}
- (void)setupCollectionView {
    _flowLayout = [UICollectionViewFlowLayout new];
    _flowLayout.minimumInteritemSpacing = 15;
    _flowLayout.minimumLineSpacing = 15;
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:_flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    // Register cell classes
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.view addSubview:_collectionView];
    
    _rows = [NSMutableArray array];
}
// 添加下拉刷新
- (void)addNewDataRefresh {
    __weak typeof (self)weakself = self;
    if ([self shouldShowRefresh]) {
        // 下拉刷新
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakself requestRefresh];
        }];
        
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        _collectionView.mj_header.automaticallyChangeAlpha = YES;
    }
}
// 添加上拉加载更多
- (void)addMoreDataRefresh {
    __weak typeof (self)weakself = self;
    if ([self shouldShowGetMore]) {
        // 上拉刷新
        _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakself requestGetMore];
        }];
        _collectionView.mj_footer.automaticallyChangeAlpha = YES;
    }
}
/**开始刷新*/
-(void)beginRequest{
    [_collectionView.mj_header beginRefreshing];
}
/**停止刷新*/
-(void)finishRequest{
    [_collectionView.mj_header endRefreshing];
    [_collectionView.mj_footer endRefreshing];
}
-(void)requestRefresh{
    NSLog(@"%s 需要重写",__FUNCTION__);
    [self finishRequest];
}
-(void)requestGetMore{
    NSLog(@"%s 需要重写",__FUNCTION__);
    [self finishRequest];
}
#pragma mark - overridable
-(BOOL)shouldShowGetMore{
    return YES;
}

-(BOOL)shouldShowRefresh{
    return YES;
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
