//
//  UrlSchemeSkip.h
//  PumpkinCar
//
//  Created by Sper on 16/7/6.
//  Copyright © 2016年 mrocker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UrlSchemeSkip : NSObject
/**url scheme跳转*/
+ (void)urlSkipByScheme:(NSURL *)url;
@end
