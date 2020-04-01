//
//  UrlSchemeSkip.m
//  PumpkinCar
//
//  Created by Sper on 16/7/6.
//  Copyright © 2016年 mrocker. All rights reserved.
//

#import "UrlSchemeSkip.h"

@implementation UrlSchemeSkip

+ (void)urlSkipByScheme:(NSURL *)url
{
    if (!url || [url.absoluteString isEqualToString:@""]) {
        return;
    }
    // 跳转作品详情
    [UrlSchemeSkip skipSensationDetail:url];
}
#pragma mark -- 套餐购买记录
+ (void)skipSensationDetail:(NSURL *)url{
//    uni://darenhome?userId=1c1ptw
    SwitchViewController *_svc = [SwitchViewController sharedSVC];
    NSDictionary * dict = [[self class] paramDictWithUrl:url];
    if ([dict objectForKey:@"userId"]){
        [_svc pushViewController:_svc.SensationDetailViewController withObjects:@{@"userId":[dict objectForKey:@"userId"]} navigationBarHidden:YES];
    }
}
+ (NSDictionary *)paramDictWithUrl:(NSURL *)url {
    NSString *consult = @"uni://darenhome?";
    NSString *urlSting = [url absoluteString];
    if ([urlSting rangeOfString:consult].location != NSNotFound) {
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithCapacity:4];
        NSString *propertys = [urlSting substringFromIndex:( int )(consult.length)];
        NSArray *subArray = [propertys componentsSeparatedByString:@ "&" ];
        for ( NSInteger index = 0 ; index < subArray.count; index++) {
            NSArray *dicArray = [subArray[index] componentsSeparatedByString:@ "=" ];
            if(dicArray.count>0) {
                [tempDic setObject:dicArray.lastObject forKey:dicArray.firstObject];
            }
        }
        return tempDic;
    }
    return nil;
}
@end
