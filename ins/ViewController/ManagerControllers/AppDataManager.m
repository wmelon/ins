

#import "AppDataManager.h"
static AppDataManager* instance;


@interface AppDataManager ()
@property(readonly, nonatomic)NSUserDefaults* userDefaults;
@property(readonly, nonatomic)NSDictionary * userDictionary;
@end

@implementation AppDataManager

+(instancetype)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AppDataManager alloc] init];
    });
    return instance;
}
@end
