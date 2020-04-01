//
//  MapRouteNavigationViewController.m
//  ins
//
//  Created by Sper on 16/7/14.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "MapRouteNavigationViewController.h"
#import <AMapNaviKit/MAMapKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AMapSearchKit/AMapSearchKit.h>
//#import "iflyMSC/IFlySpeechError.h"
//#import "iflyMSC/IFlySpeechSynthesizer.h"
//#import "iflyMSC/IFlySpeechSynthesizerDelegate.h"

#import "DestinationView.h"
#import "QuickStartAnnotationView.h"
#import "LocationModel.h"
#import "RouteCollectionViewCell.h"

#define kRouteIndicatorViewHeight   90.f
#define kCollectionCellIdentifier   @"kCollectionCellIdentifier"

typedef NS_ENUM(NSInteger, TravelTypes)
{
    TravelTypeCar = 0,      // 驾车方式
    TravelTypeBus ,          // 公交方式
    TravelTypeWalk         // 步行方式
};
//AMapNaviManagerDelegate,AMapNaviViewControllerDelegate,IFlySpeechSynthesizerDelegate
@interface MapRouteNavigationViewController ()<MAMapViewDelegate,AMapSearchDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    AMapSearchAPI *_search;
}
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapNaviPoint* startPoint;
@property (nonatomic, strong) AMapNaviPoint* endPoint;

//@property (nonatomic, strong) AMapNaviViewController *naviViewController;
//@property (nonatomic, strong) AMapNaviManager *naviManager;
//@property (nonatomic, strong) IFlySpeechSynthesizer *iFlySpeechSynthesizer;

@property (nonatomic, assign) TravelTypes travelTypes; //交通方式
@property (nonatomic, strong) NSArray *pathPolylines; //所有路线

/**驾车路线规划*/
@property (nonatomic, strong) AMapDrivingRouteSearchRequest *Drivingrequest;
/**走路路线规划*/
@property (nonatomic, strong) AMapWalkingRouteSearchRequest *Walkingrequest;
/**公交路线规划*/
@property (nonatomic, strong) AMapTransitRouteSearchRequest * transitRequest;

/**公交所有路线规划视图*/
@property (nonatomic, strong) UICollectionView *busRouteView;
//@property (nonatomic, assign) BOOL CalculateRouteSuccess;//规划路线成功
@property (nonatomic, strong) NSMutableArray *routeIndicatorInfoArray; //所有路线的数据

/**驾车和步行底部显示视图*/
@property (nonatomic, strong) DestinationView * destinationView;
@property (nonatomic, strong) NSMutableArray *polylines;//导航线路绘制
@property (nonatomic, strong) UIButton * selButton; //记录选择的按钮

@end

@implementation MapRouteNavigationViewController

- (instancetype)init{
    if (self = [super init]){
        _startPoint = [AMapNaviPoint locationWithLatitude:[AppDataManager defaultManager].mapLocation.coordinate.latitude longitude:[AppDataManager defaultManager].mapLocation.coordinate.longitude];
        _endPoint   = [AMapNaviPoint locationWithLatitude:31.207131 longitude:121.362737];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self initNaviManager];
//    [self initNaviViewController];
//    [self initIFlySpeech];
    
    [self initMapView];
    [self initRouteIndicatorView];
    [self initMapSearch];
}

#pragma mark - Init & Construct
- (void)initNavigationItem{
    UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 142, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    
    UIButton * leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    leftBtn.tag = TravelTypeCar;
    [leftBtn addTarget:self action:@selector(segCtrlClick:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.backgroundColor = [UIColor clearColor];
    [leftBtn setImage:[UIImage imageNamed:@"car_nor"] forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"car_sel"] forState:UIControlStateSelected];
    [titleView addSubview:leftBtn];
    
    UIButton * middleBtn = [[UIButton alloc] initWithFrame:CGRectMake(49, 0, 44, 44)];
    middleBtn.tag = TravelTypeBus;
    [middleBtn addTarget:self action:@selector(segCtrlClick:) forControlEvents:UIControlEventTouchUpInside];
    middleBtn.backgroundColor = [UIColor clearColor];
    [middleBtn setImage:[UIImage imageNamed:@"bus_nor"] forState:UIControlStateNormal];
    [middleBtn setImage:[UIImage imageNamed:@"bus_sel"] forState:UIControlStateSelected];
    [titleView addSubview:middleBtn];
    
    UIButton * rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(49 + 49, 0, 44, 44)];
    rightBtn.tag = TravelTypeWalk;
    [rightBtn addTarget:self action:@selector(segCtrlClick:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.backgroundColor = [UIColor clearColor];
    [rightBtn setImage:[UIImage imageNamed:@"walk_nor"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"walk_sel"] forState:UIControlStateSelected];
    [titleView addSubview:rightBtn];
    
    [self segCtrlClick:leftBtn];
//    UISegmentedControl *segCtrl = [[UISegmentedControl alloc] initWithItems:@[@"驾车", @"步行",@"公交"]];
//    [segCtrl addTarget:self action:@selector(segCtrlClick:) forControlEvents:UIControlEventValueChanged];
//    [segCtrl setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17]}
//                           forState:UIControlStateNormal];
//    segCtrl.selectedSegmentIndex = 0;
//    self.travelTypes = segCtrl.selectedSegmentIndex;
//    // 路线规划开始导航
//    [self calculateRoute];
//    segCtrl.frame = CGRectMake((kScreenWidth-150)/2, 10, 150, 30);
    self.navigationItem.titleView = titleView;
}

//- (void)initNaviViewController
//{
//    if (_naviViewController == nil)
//    {
//        _naviViewController = [[AMapNaviViewController alloc] initWithDelegate:self];
//    }
//}
//- (void)initNaviManager
//{
//    if (self.naviManager == nil)
//    {
//        _naviManager = [[AMapNaviManager alloc] init];
//    }
//    
//    self.naviManager.delegate = self;
//}

- (void)initMapView
{
    if (self.mapView == nil)
    {
        self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    }
    self.mapView.delegate = self;
    [_mapView setZoomLevel:13];//级别，3-19
    /**显示用户位置*/
    [self.mapView setShowsUserLocation:YES];
    
    MAPointAnnotation *_annotation = [[MAPointAnnotation alloc] init];
    self.mapView.centerCoordinate = CLLocationCoordinate2DMake(_endPoint.latitude, _endPoint.longitude);
    [_annotation setCoordinate:CLLocationCoordinate2DMake(_endPoint.latitude, _endPoint.longitude)];
    [_annotation setTitle:@"南瓜车"];
    [_annotation setSubtitle:@"南瓜车理发天下第一"];
    [self.mapView addAnnotations:@[_annotation]];
    [self.mapView showAnnotations:@[_annotation] animated:YES];
    [self.view addSubview:self.mapView];
}
/**导航多路径显示*/
- (void)initRouteIndicatorView
{
    _destinationView = [[[NSBundle mainBundle] loadNibNamed:@"DestinationView" owner:nil options:nil] lastObject];
    _destinationView.frame = CGRectMake(0, kScreenHeight - 64 - 100, self.view.width, 100);
    _destinationView.hidden = YES;
    [self.view addSubview:_destinationView];
    
    UIButton * myLocation = [[UIButton alloc] initWithFrame:CGRectMake(16, kScreenHeight - 64 - 150, 25, 25)];
    [myLocation setImage:[UIImage imageNamed:@"photobtn"] forState:UIControlStateNormal];
    [myLocation addTarget:self action:@selector(myLocationClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myLocation];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _busRouteView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds) - kRouteIndicatorViewHeight - 10, CGRectGetWidth(self.view.bounds), kRouteIndicatorViewHeight) collectionViewLayout:layout];
    _busRouteView.hidden = YES;
    _busRouteView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    _busRouteView.backgroundColor = [UIColor clearColor];
    _busRouteView.pagingEnabled = YES;
    _busRouteView.showsVerticalScrollIndicator = NO;
    _busRouteView.showsHorizontalScrollIndicator = NO;
    
    _busRouteView.delegate = self;
    _busRouteView.dataSource = self;
    
    [self.view addSubview:_busRouteView];
}
/**定位到我的位置*/
- (void)myLocationClick:(UIButton *)button{
    self.mapView.centerCoordinate = [AppDataManager defaultManager].mapLocation.coordinate;
}
//- (void)initIFlySpeech
//{
//    if (self.iFlySpeechSynthesizer == nil)
//    {
//        _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
//    }
//    
//    _iFlySpeechSynthesizer.delegate = self;
//}
- (void)initMapSearch{
    //初始化检索对象
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    //构造AMapDrivingRouteSearchRequest对象，设置驾车路径规划请求参数
    _Drivingrequest = [[AMapDrivingRouteSearchRequest alloc] init];
    _Walkingrequest = [[AMapWalkingRouteSearchRequest alloc] init];
    _transitRequest = [[AMapTransitRouteSearchRequest alloc] init];
    
    [self initNavigationItem];
}

#pragma mark - Button Action
//选择导航方式
- (void)segCtrlClick:(UIButton *)segCtrl{
    segCtrl.selected = YES;
    _selButton.selected = NO;
    _selButton = segCtrl;
    
    self.travelTypes = segCtrl.tag;
    [_mapView removeOverlays:_mapView.overlays];
    // 路线规划开始导航
    [self calculateRoute];
}
- (void)calculateRoute{
    switch (self.travelTypes) {
        case TravelTypeCar:  // 汽车导航
        {
            _busRouteView.hidden = YES;
            _destinationView.hidden = NO;
            [self searchNaviCar];
//            [self.naviManager calculateDriveRouteWithStartPoints:startPoints endPoints:endPoints wayPoints:nil drivingStrategy:0];
        }
            break;
        case TravelTypeWalk:  // 走路导航
        {
            _busRouteView.hidden = YES;
            _destinationView.hidden = NO;
            [self searchNaviWalk];
//            [self.naviManager calculateWalkRouteWithStartPoints:startPoints endPoints:endPoints];
        }
            break;
        case TravelTypeBus:  // 公交导航
        {
            _busRouteView.hidden = NO;
            _destinationView.hidden = YES;
            [self searchNaviBus];
        }
            break;
        default:
            break;
    }
}
#pragma mark -- 驾车路线规划
- (void)searchNaviCar{
    //设置起点，我选择了当前位置，mapView有这个属性
    _Drivingrequest.origin = [AMapGeoPoint locationWithLatitude:_startPoint.latitude longitude:_startPoint.longitude];
    //设置终点，可以选择手点
    _Drivingrequest.destination = [AMapGeoPoint locationWithLatitude:_endPoint.latitude longitude:_endPoint.longitude];
    
    //    request.strategy = 2;//距离优先
    _Drivingrequest.requireExtension = YES;
    
    //发起路径搜索，发起后会执行代理方法
    //这里使用的是步行路径
    [_search AMapDrivingRouteSearch:_Drivingrequest];
}
#pragma mark -- 走路路线规划
- (void)searchNaviWalk{
    //设置起点，我选择了当前位置，mapView有这个属性
    _Walkingrequest.origin = [AMapGeoPoint locationWithLatitude:_startPoint.latitude longitude:_startPoint.longitude];
    //设置终点，可以选择手点
    _Walkingrequest.destination = [AMapGeoPoint locationWithLatitude:_endPoint.latitude longitude:_endPoint.longitude];
    
    //    request.strategy = 2;//距离优先
    
    //发起路径搜索，发起后会执行代理方法
    //这里使用的是步行路径
    [_search AMapWalkingRouteSearch: _Walkingrequest];
}
#pragma mark -- 公交路线规划
- (void)searchNaviBus{
    _transitRequest.city = [LocationModel shareLocationModel].currentCity;
    _transitRequest.requireExtension = YES;
    /* 出发点. */
    _transitRequest.origin = [AMapGeoPoint locationWithLatitude:_startPoint.latitude
                                                     longitude:_startPoint.longitude];
    /* 目的地. */
    _transitRequest.destination = [AMapGeoPoint locationWithLatitude:_endPoint.latitude
                                                          longitude:_endPoint.longitude];
    [_search AMapTransitRouteSearch:_transitRequest];
}

#pragma mark -- AMapSearchDelegate  实现公交路线规划回调函数
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response{
    if(response.route == nil)
    {
        return;
    }
    if (response.count > 0)
    {
        //移除地图原本的遮盖
        [_mapView removeOverlays:_pathPolylines];
        _pathPolylines = nil;
        
        if (self.travelTypes == TravelTypeCar || self.travelTypes == TravelTypeWalk){
            AMapPath * path = response.route.paths[0];
            // 只显⽰第⼀条 规划的路径
            _pathPolylines = [self polylinesForPath:path];
            [_destinationView setPath:path];
        }else if (self.travelTypes == TravelTypeBus){
            AMapRoute * route = response.route;
            _pathPolylines = [self polylinesForRoute:route];
        }
        //添加新的遮盖，然后会触发代理方法进行绘制
        [_mapView addOverlays:_pathPolylines];
    }
}
// 公交路线规划
- (NSArray *)polylinesForRoute:(AMapRoute *)route{
    if (route == nil || route.transits.count == 0)
    {
        return nil;
    }
    [self.routeIndicatorInfoArray removeAllObjects];
    __block NSMutableArray *oneTranLine;
    
    [route.transits enumerateObjectsUsingBlock:^(AMapTransit * transit, NSUInteger idx, BOOL * _Nonnull stop) {
        
        oneTranLine = [NSMutableArray array];
        
        [transit.segments enumerateObjectsUsingBlock:^(AMapSegment *segment, NSUInteger idx, BOOL *stop) {
            
            /**步行路段解析*/
            [segment.walking.steps enumerateObjectsUsingBlock:^(AMapStep *step, NSUInteger idx, BOOL * _Nonnull stop) {
                NSUInteger count = 0;
                CLLocationCoordinate2D *coordinates = [self coordinatesForString:step.polyline
                                                                 coordinateCount:&count
                                                                      parseToken:@";"];
                MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coordinates count:count];
                
                [oneTranLine addObject:polyline];
                free(coordinates), coordinates = NULL;
            }];
            
            /**公交路段解析*/
            [segment.buslines enumerateObjectsUsingBlock:^(AMapBusLine *busline, NSUInteger idx, BOOL * _Nonnull stop) {
                NSUInteger count = 0;
                CLLocationCoordinate2D *coordinates = [self coordinatesForString:busline.polyline
                                                                 coordinateCount:&count
                                                                      parseToken:@";"];
                MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coordinates count:count];
                
                [oneTranLine addObject:polyline];
                free(coordinates), coordinates = NULL;
            }];
        }];
        [self.polylines addObject:oneTranLine];
        /**建议路线数据源*/
        [self.routeIndicatorInfoArray addObject:transit];
    }];
    [_busRouteView reloadData];
    return [self.polylines firstObject];
}

// 驾车和走路路线解析
- (NSArray *)polylinesForPath:(AMapPath *)path
{
    if (path == nil || path.steps.count == 0)
    {
        return nil;
    }
    NSMutableArray *polylines = [NSMutableArray array];
    [path.steps enumerateObjectsUsingBlock:^(AMapStep *step, NSUInteger idx, BOOL *stop) {
        NSUInteger count = 0;
        CLLocationCoordinate2D *coordinates = [self coordinatesForString:step.polyline
                                                         coordinateCount:&count
                                                              parseToken:@";"];
        MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coordinates count:count];
    
        [polylines addObject:polyline];
        free(coordinates), coordinates = NULL;
    }];
    return polylines;
}

//解析经纬度
- (CLLocationCoordinate2D *)coordinatesForString:(NSString *)string
                                 coordinateCount:(NSUInteger *)coordinateCount
                                      parseToken:(NSString *)token
{
    if (string == nil)
    {
        return NULL;
    }
    
    if (token == nil)
    {
        token = @",";
    }
    
    NSString *str = @"";
    if (![token isEqualToString:@","])
    {
        str = [string stringByReplacingOccurrencesOfString:token withString:@","];
    }
    
    else
    {
        str = [NSString stringWithString:string];
    }
    
    NSArray *components = [str componentsSeparatedByString:@","];
    NSUInteger count = [components count] / 2;
    if (coordinateCount != NULL)
    {
        *coordinateCount = count;
    }
    CLLocationCoordinate2D *coordinates = (CLLocationCoordinate2D*)malloc(count * sizeof(CLLocationCoordinate2D));
    
    for (int i = 0; i < count; i++)
    {
        coordinates[i].longitude = [[components objectAtIndex:2 * i]     doubleValue];
        coordinates[i].latitude  = [[components objectAtIndex:2 * i + 1] doubleValue];
    }
    return coordinates;
}

//绘制遮盖时执行的代理方法
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    /* 自定义定位精度对应的MACircleView. */
    //画路线
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        //初始化一个路线类型的view
        MAPolylineRenderer *polygonView = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        //设置线宽颜色等
        polygonView.lineWidth = 5.f;
        polygonView.strokeColor = [UIColor colorWithRed:0.015 green:0.658 blue:0.986 alpha:1.000];
        polygonView.fillColor = [UIColor colorWithRed:0.940 green:0.771 blue:0.143 alpha:0.800];
        polygonView.lineJoinType = kMALineJoinRound;//连接类型
        
        //返回view，就进行了添加
        return polygonView;
    }
    return nil;
    
}

// 规划失败回调函数
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error{
    NSLog(@"%@" , error);
}

#pragma mark -- MAMapViewDelegate
- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    if ([view.annotation isKindOfClass:[MAPointAnnotation class]])
    {
        MAPointAnnotation *annotation = (MAPointAnnotation *)view.annotation;
        
        _endPoint = [AMapNaviPoint locationWithLatitude:annotation.coordinate.latitude
                                              longitude:annotation.coordinate.longitude];
        
//        if (_CalculateRouteSuccess){
//            /**规划路线成功进入导航界面*/
//            [self.naviManager presentNaviViewController:self.naviViewController animated:YES];
//        }
    }
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"QuickStartAnnotationView";
        QuickStartAnnotationView *annotationView = (QuickStartAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        
        if (annotationView == nil)
        {
            annotationView = [[QuickStartAnnotationView alloc] initWithAnnotation:annotation
                                                                  reuseIdentifier:pointReuseIndetifier];
        }
        
        annotationView.canShowCallout = YES;
        annotationView.draggable = NO;
        
        return annotationView;
    }
    
    return nil;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.routeIndicatorInfoArray.count ? self.routeIndicatorInfoArray.count + 1 : 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RouteCollectionViewCell *cell;
    if (indexPath.row == self.routeIndicatorInfoArray.count && self.routeIndicatorInfoArray.count){
        static NSString * cellID = @"routeIndicatorInfoLastCell";
        [collectionView registerClass:[RouteCollectionViewCell class] forCellWithReuseIdentifier:cellID];
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    }else {
        [_busRouteView registerNib:[UINib nibWithNibName:@"RouteCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kCollectionCellIdentifier];
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCellIdentifier forIndexPath:indexPath];
        if (self.routeIndicatorInfoArray.count){
            cell.transit = self.routeIndicatorInfoArray[indexPath.row];
        }
    }
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CGRectGetWidth(collectionView.bounds) - 10, CGRectGetHeight(collectionView.bounds));
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 5, 0, 5);
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.routeIndicatorInfoArray.count){
        /**调起三方地图导航*/
        
    }
//    DriveNaviViewController *driveVC = [[DriveNaviViewController alloc] init];
//    [driveVC setDelegate:self];
//    
//    //将driveView添加到AMapNaviDriveManager中
//    [self.driveManager addDataRepresentative:driveVC.driveView];
//    
//    [self.navigationController pushViewController:driveVC animated:NO];
//    [self.driveManager startEmulatorNavi];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    /**停止滚动移除所有覆盖层*/
    [_mapView removeOverlays:_mapView.overlays];
    RouteCollectionViewCell *cell = [[self.busRouteView visibleCells] firstObject];
    NSIndexPath *indexPath = [self.busRouteView indexPathForCell:cell];
    if (indexPath.row < self.routeIndicatorInfoArray.count){
        [_mapView addOverlays:self.polylines[indexPath.row]];
    }
}

#pragma mark - AMapNaviManager Delegate

//- (void)naviManager:(AMapNaviManager *)naviManager error:(NSError *)error
//{
//    NSLog(@"error:{%@}",error.localizedDescription);
//    _CalculateRouteSuccess = YES;
//}
//
//- (void)naviManager:(AMapNaviManager *)naviManager didPresentNaviViewController:(UIViewController *)naviViewController
//{
//    NSLog(@"didPresentNaviViewController");
//    [self.naviManager startEmulatorNavi];
//}
//
//- (void)naviManager:(AMapNaviManager *)naviManager didDismissNaviViewController:(UIViewController *)naviViewController
//{
//    NSLog(@"didDismissNaviViewController");
//}
//
//- (void)naviManagerOnCalculateRouteSuccess:(AMapNaviManager *)naviManager
//{
//    NSLog(@"OnCalculateRouteSuccess");
////    DriveNaviViewController *driveVC = [[DriveNaviViewController alloc] init];
////    [driveVC setDelegate:self];
////    
////    //将driveView添加到AMapNaviDriveManager中
////    [self.driveManager addDataRepresentative:driveVC.driveView];
////    
////    [self.navigationController pushViewController:driveVC animated:NO];
////    [self.driveManager startGPSNavi];
//}
#pragma mark - Handle Navi Routes

//- (void)showNaviRoutes
//{
//    [self.routeIndicatorInfoArray removeAllObjects];
//    
//    for (NSNumber *aRouteID in [self.driveManager.naviRoutes allKeys])
//    {
//        AMapNaviRoute *aRoute = [[self.driveManager naviRoutes] objectForKey:aRouteID];
//        int count = (int)[[aRoute routeCoordinates] count];
//
//        //更新CollectonView的信息
//        RouteCollectionViewInfo *info = [[RouteCollectionViewInfo alloc] init];
//        info.routeID = [aRouteID integerValue];
//        info.title = [NSString stringWithFormat:@"路径ID:%ld | 路径计算策略:%ld", (long)[aRouteID integerValue], (long)[aRoute routeStrategy]];
//        info.subtitle = [NSString stringWithFormat:@"长度:%ld米 | 预估时间:%ld秒 | 分段数:%ld", (long)aRoute.routeLength, (long)aRoute.routeTime, (long)aRoute.routeSegments.count];
//        
//        [self.routeIndicatorInfoArray addObject:info];
//    }
//    
//    [self.mapView showAnnotations:self.mapView.annotations animated:NO];
//    [self.routeIndicatorView reloadData];
//    
//    [self selectNaviRouteWithID:[[self.routeIndicatorInfoArray firstObject] routeID]];
//}

//- (BOOL)naviManagerGetSoundPlayState:(AMapNaviManager *)naviManager
//{
//    NSLog(@"GetSoundPlayState");
//    return 0;
//}
//
//- (void)naviManager:(AMapNaviManager *)naviManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType
//{
//    NSLog(@"playNaviSoundString:{%ld:%@}", (long)soundStringType, soundString);
//    
//    if (soundStringType == AMapNaviSoundTypePassedReminder)
//    {
//        //用系统自带的声音做简单例子，播放其他提示音需要另外配置
//        AudioServicesPlaySystemSound(1009);
//    }
//    else
//    {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//            [_iFlySpeechSynthesizer startSpeaking:soundString];
//        });
//    }
//}
//
//- (void)naviManagerDidUpdateTrafficStatuses:(AMapNaviManager *)naviManager
//{
//    NSLog(@"DidUpdateTrafficStatuses");
//}

#pragma mark - AManNaviViewController Delegate

//- (void)naviViewControllerCloseButtonClicked:(AMapNaviViewController *)naviViewController
//{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        [self.iFlySpeechSynthesizer stopSpeaking];
//    });
//    
//    [self.naviManager stopNavi];
//    
//    [self.naviManager dismissNaviViewControllerAnimated:YES];
//}
//#pragma mark - iFlySpeechSynthesizer Delegate
//
//- (void)onCompleted:(IFlySpeechError *)error
//{
//    NSLog(@"Speak Error:{%d:%@}", error.errorCode, error.errorDesc);
//}
//
//- (void)backButtonAction
//{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        [self.iFlySpeechSynthesizer stopSpeaking];
//    });
//    
//    [self.naviManager stopNavi];
//    
//    [self.naviManager dismissNaviViewControllerAnimated:YES];
//}

//- (void)carLockButtonAction
//{
//    [self.naviViewController setIsCarLock:!self.naviViewController.isCarLock];
//}
- (NSMutableArray *)polylines{
    if (_polylines == nil){
        _polylines = [NSMutableArray array];
    }
    return _polylines;
}
- (NSMutableArray *)routeIndicatorInfoArray{
    if (_routeIndicatorInfoArray == nil){
        _routeIndicatorInfoArray = [NSMutableArray array];
    }
    return _routeIndicatorInfoArray;
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
