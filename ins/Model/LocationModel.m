

#import "LocationModel.h"
#import <math.h>
#import <CoreLocation/CoreLocation.h>

const double pi = 3.14159265358979324;
const double a = 6378245.0;
const double ee = 0.00669342162296594323;

@interface LocationModel ()<CLLocationManagerDelegate>

@property(nonatomic,strong)CLLocationManager *locMgr;

@end

@implementation LocationModel

+ (instancetype)shareLocationModel
{
    static LocationModel *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [[self alloc] init];
        }
    });
    return instance;
}

-(void)startLocation
{
    if([CLLocationManager locationServicesEnabled]) {
        if (ISIos8 || ISIos9) {
            [self.locMgr requestWhenInUseAuthorization];
        }
        [self.locMgr startUpdatingLocation];
    }else {
        
    }
}

-(CLLocationManager *)locMgr
{
    if(!_locMgr){
        _locMgr = [[CLLocationManager alloc] init];
        _locMgr.delegate = self;
        //每隔多少米定位一次
        _locMgr.distanceFilter = 100.0;
        //设置定位的精准度，一般精准度越高，越耗电(将周围一定值的范围看作一个地点)
        _locMgr.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    }
    
    return _locMgr;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *currentLocation = [locations lastObject];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark *placemark in placemarks) {
            self.currentCity = [[placemark.addressDictionary objectForKey:@"City"] substringToIndex:2];
            NSLog(@"当前城市---%@" , self.currentCity);
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
//                [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationStringCurrentCity object:nil];
            });
        }
    }];
    
    // 获取火星坐标
    currentLocation = [self transformWithLocations:currentLocation];
    [[AppDataManager defaultManager] setMapLocation:currentLocation];
    [self.locMgr stopUpdatingLocation];
}

// 将 地球坐标 转换为 火星坐标
- (CLLocation *)transformWithLocations:(CLLocation *)currentLocation
{
    double wgLat = currentLocation.coordinate.latitude;
    double wgLon = currentLocation.coordinate.longitude;
    if ([self outOfChinaWithLat:wgLat Lon:wgLon])
    {
        return currentLocation;
    }
    double dLat = [self transformLatWithX:wgLon - 105 Y:wgLat - 35];
    double dLon = [self transformLonWithX:wgLon - 105 Y:wgLat - 35];
    double radLat = wgLat / 180.0 * pi;
    double magic = sin(radLat);
    magic = 1 - ee * magic * magic;
    double sqrtMagic = sqrt(magic);
    dLat = (dLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * pi);
    dLon = (dLon * 180.0) / (a / sqrtMagic * cos(radLat) * pi);
    currentLocation = [[CLLocation alloc] initWithLatitude:wgLat + dLat longitude:wgLon + dLon];
    return currentLocation;
}

- (BOOL)outOfChinaWithLat:(double)lat Lon:(double) lon
{
    if (lon < 72.004 || lon > 137.8347)
        return true;
    if (lat < 0.8293 || lat > 55.8271)
        return true;
    return false;
}

- (double)transformLatWithX:(double)x Y:(double)y
{
    double ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0;
    ret += (20.0 * sin(y * pi) + 40.0 * sin(y / 3.0 * pi)) * 2.0 / 3.0;
    ret += (160.0 * sin(y / 12.0 * pi) + 320 * sin(y * pi / 30.0)) * 2.0 / 3.0;
    return ret;
}

- (double)transformLonWithX:(double)x Y:(double)y
{
    double ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0;
    ret += (20.0 * sin(x * pi) + 40.0 * sin(x / 3.0 * pi)) * 2.0 / 3.0;
    ret += (150.0 * sin(x / 12.0 * pi) + 300.0 * sin(x / 30.0 * pi)) * 2.0 / 3.0;
    return ret;
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
//    [[AppDataManager defaultManager] setMapLocation:nil];
    [self.locMgr stopUpdatingLocation];
}

@end
