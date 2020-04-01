

#import <Foundation/Foundation.h>

//定位
@interface LocationModel : NSObject

@property (nonatomic, strong) NSString *currentCity;

+ (LocationModel *)shareLocationModel;

-(void)startLocation;

@end
