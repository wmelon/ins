 

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define UserLat [AppDataManager defaultManager].mapLocation.coordinate.latitude
#define UserLng [AppDataManager defaultManager].mapLocation.coordinate.longitude

@interface AppDataManager : NSObject
@property (nonatomic ,strong)CLLocation * mapLocation; //定位坐标

+(instancetype)defaultManager;

@end
