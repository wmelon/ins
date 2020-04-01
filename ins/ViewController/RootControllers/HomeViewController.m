//
//  HomeViewController.m
//  ins
//
//  Created by Sper on 16/6/26.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "HomeViewController.h"
#import "SensationProductCell.h"
#import "AllHotProductFootView.h"
#import "XLPlainFlowLayout.h"
#import "PageViewControllerCell.h"
#import "SwitchSensationHeaderView.h"
#import "AppNavigationBar.h"

static NSString * const SensationCellID = @"PageViewControllerCell";
static NSString * const SensationProductCellID = @"SensationProductCell";

#define kFooterIdentifier @"kFooterIdentifier"
#define kHeaderIdentifier @"kHeaderIdentifier"

@interface HomeViewController ()<SwitchSensationHeaderViewDelegate,PageViewControllerCellDelegate>
@property (nonatomic , strong)NSMutableArray * hotProductArray;
@property (nonatomic , strong)PageViewControllerCell * cell;
@property (nonatomic , strong)SwitchSensationHeaderView * headerView;

@property (nonatomic, strong) AppNavigationBar *navBar;
@end

@implementation HomeViewController

- (instancetype)init{
    if (self = [super init]){
        self.title = @"INS";
        [self showRightButton:@"开始导航" image:nil selImage:nil];
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_svc.rootNaviController setNavigationBarHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
    
//    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    self.navBar = [[AppNavigationBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
//    self.navBar.barTintColor = [UIColor blackColor];
    [[[self.navBar subviews] objectAtIndex:0] setAlpha:0];
    
//    self.navBar.items = @[navItem];
//    self.navBar.translucent = NO;
    [self.view addSubview:self.navBar];
    
//
//    CGRectMake(0, 0, 60, 22)
    UIButton * leftButton = [[UIButton alloc] initWithFrame:CGRectMake(16, 20 + (44 - 22) / 2, 60, 22)];
    [leftButton setTitle:@"<上海" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [leftButton setBackgroundColor:UIColorFromARGB(0x000000, 0.6)];
    leftButton.layer.cornerRadius = 10;
//    UIBarButtonItem * leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
//    [navItem setLeftBarButtonItem:leftBarButton];
    [self.navBar addSubview:leftButton];
    
    
//
//    CGRectMake(0, 0, 26, 26)
    UIButton * rightButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 16 - 26, 20 + (44 - 26) / 2, 26, 26)];
    [rightButton setTitle:@"🔍" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton setBackgroundColor:UIColorFromARGB(0x000000, 0.6)];
    rightButton.layer.cornerRadius = 13;
//    UIBarButtonItem * rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
//    [navItem setRightBarButtonItem:rightBarButton];
    [self.navBar addSubview:rightButton];
    
    
//
//    CGRectMake(0, 0, 130, 22)
    UIButton * middleButton = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth - 130) / 2, 20 + (44 - 22) / 2, 130, 22)];
    middleButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [middleButton setTitle:@"门店地图>" forState:UIControlStateNormal];
    [middleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [middleButton setBackgroundColor:UIColorFromARGB(0x000000, 0.6)];
    middleButton.layer.cornerRadius = 10;
//    navItem.titleView = middleButton;
    [self.navBar addSubview:middleButton];
    
    
    
    XLPlainFlowLayout *layout = [XLPlainFlowLayout new];
    layout.naviHeight = 0.0;
    [self.collectionView setCollectionViewLayout:layout];
    self.collectionView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49);
    [self.collectionView registerNib:[UINib nibWithNibName:@"SensationProductCell" bundle:nil] forCellWithReuseIdentifier:SensationProductCellID];
    [self.collectionView registerClass:[PageViewControllerCell class] forCellWithReuseIdentifier:SensationCellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"AllHotProductFootView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kFooterIdentifier];
    [self.collectionView registerClass:[SwitchSensationHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderIdentifier];
    [self beginRequest];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset_Y = scrollView.contentOffset.y;
    CGFloat alpha = (offset_Y)/230.0f;
    [[[self.navBar subviews] objectAtIndex:0] setAlpha:alpha];
}

- (void)requestRefresh{
    [self loadSensationHotProduct];
    [self loadSensationList];
}
- (void)requestGetMore{
    [self finishRequest];
}
- (void)loadSensationHotProduct{
    NSDictionary * dict = @{@"_ab":@"1228",
                            @"_app":@"uni",
                            @"_at":@"2a7620ea270c6f55",
                            @"_atype":@"iphone",
                            @"_av":@"211",
                            @"_channel":@"NIUAppStore",
                            @"_did":@"23025992-0737-49D8-AB71-98F4FFCCE3BD",
                            @"_fs":@"NIUAppStore211",
                            @"_lang":@"zh_CN",
                            @"_network":@"2",
                            @"_saveMode":@"0",
                            @"_sdklevel":@"9.3.2",
                            @"_swidth":@"750",
                            @"_t":@"1469943646",
                            @"_version":@"2.1.1.1228",
                            @"minfo":@"iPhone7,2"};
    [ProductModel requestSensationHotProductWithParam:dict success:^(id responseObject, NSUInteger statusCode) {
        if (statusCode == 200){
            [self.hotProductArray setArray:[ProductModel pc_modelListWithArray:[responseObject objectForKey:@"result"][@"hotTwitters"]]];
            [self.collectionView reloadData];
        }
        [self finishRequest];
    } failed:^(NSError *error, NSUInteger statusCode) {
        [self finishRequest];
    }];
}
- (void)loadSensationList{
    NSDictionary * dict = @{@"_ab":@"1228",
                            @"_app":@"uni",
                            @"_at":@"f9a333caa64d67e7",
                            @"_atype":@"iphone",
                            @"_av":@"211",
                            @"_channel":@"NIUAppStore",
                            @"_did":@"23025992-0737-49D8-AB71-98F4FFCCE3BD",
                            @"_fs":@"NIUAppStore211",
                            @"_lang":@"zh_CN",
                            @"_network":@"2",
                            @"_saveMode":@"0",
                            @"_sdklevel":@"9.3.2",
                            @"_swidth":@"750",
                            @"_t":@"1470389776",
                            @"_version":@"2.1.1.1228",
                            @"minfo":@"iPhone7,2",
                            @"cateId":@"1003",
                            @"info":@"71d73155caa93d5393bdceb247d40a92,1470386693,119ms4y,11jyfdi,11739yc,127m31u,111ez3e,116ipq4,1zp0rq,11dmyls,1gy2ss,122tna0,11j2to4,1plld2,12g1fi4,1nxixs,1jcym4,11b5pji,121v3ii,19bmdu,1gpu96,1pbvuu,11oe7ru,1gtayu,121pq80,190d78,1ljsa2,12c3906,12jso1w,11bwa3g,115tq4m,110g3i0,1qh6oe,1c1ptw,1nscb4,1barki,11gnit6,1istu2,115e89g,1fz7uy,122s12e,1m4oos,1biozq,1dpjx8,124hx7w,11zwhve,1uil5o,12kwq58,1w6hmm,1u9gmw,115xo6k,15r38y,11ey18i"};
    [SensationModel requestSensationListWithParam:dict success:^(id responseObject, NSUInteger statusCode) {
        if (statusCode == 200){
            [self.rows removeAllObjects];
            NSArray * updateList = responseObject[@"result"][@"updateList"];
            NSArray * addList = responseObject[@"result"][@"addList"];
            for (NSDictionary * dict in updateList) {
                SensationModel * model = [[SensationModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [self.rows addObject:model];
            }
            for (NSDictionary * dict in addList) {
                SensationModel * model = [[SensationModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [self.rows addObject:model];
            }
            [self.collectionView reloadData];
        }
        [self finishRequest];
    } failed:^(NSError *error, NSUInteger statusCode) {
        [self finishRequest];
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return section == 0 ? 2 : 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0){
        // Configure the cell
        SensationProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SensationProductCellID forIndexPath:indexPath];
        if (self.hotProductArray.count){
            [cell setModel:self.hotProductArray[indexPath.row]];
        }
        return cell;
    }else {
        _cell = [collectionView dequeueReusableCellWithReuseIdentifier:SensationCellID forIndexPath:indexPath];
        _cell.delegate = self;
        if (self.rows.count){
            _cell.rows = self.rows;
        }
        return _cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0)
    {
        return CGSizeMake(kScreenWidth, 180);
    }else {
        NSInteger rowCount = (self.rows.count / 3);  // 总行数
        CGFloat rowHeight = ((kScreenWidth - 15 * 4) / 3 + 30);
        return CGSizeMake(kScreenWidth, rowCount  *  rowHeight + 15 * (rowCount + 1));
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return (section == 0) ? UIEdgeInsetsZero : UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return (section == 0) ? 0.001 : 0.001;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return (section == 0) ? 0.001 : 0.001;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        if (indexPath.section == 0){
            UICollectionReusableView * footerView =
            [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kFooterIdentifier forIndexPath:indexPath];
            return footerView;
        }
        return nil;
    }else if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        if (indexPath.section == 1){
            _headerView = (SwitchSensationHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderIdentifier forIndexPath:indexPath];
            _headerView.delegate = self;
            [_headerView setTitleArray:@[@"人气榜",@"活跃榜",@"推荐榜"]];
            _headerView.backgroundColor = [UIColor yellowColor];
            return _headerView;
        }
    }
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return section == 0 ? CGSizeMake(kScreenWidth, 50) : CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return section == 0 ? CGSizeZero : CGSizeMake(kScreenWidth, 50);
}
- (void)rightAction:(UIButton *)button{
    [_svc pushViewController:_svc.MapRouteNavigationViewController];
}

#pragma mark -- switchSensationHeaderViewDelegate
- (void)switchSensationHeaderView:(SwitchSensationHeaderView *)SwitchSensationHeaderView clickedPageTabBarAtIndex:(NSInteger)index{
    [_cell switchToPageIndex:index];
}
#pragma mark -- PageViewControllerCellDelegate
- (void)PageViewControllerCell:(PageViewControllerCell *)pageViewControllerCell scorlPageTabBarAtIndex:(NSInteger)index{
    [_headerView switchToPageIndex:index];
}

- (NSMutableArray *)hotProductArray{
    if (_hotProductArray == nil){
        _hotProductArray = [NSMutableArray array];
    }
    return _hotProductArray;
}
- (BOOL)shouldShowBackItem{
    return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end






