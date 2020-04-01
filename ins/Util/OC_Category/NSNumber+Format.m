//
//  NSNumber+Format.m
//  ins
//
//  Created by Sper on 16/7/8.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "NSNumber+Format.h"

@implementation NSNumber (Format)
- (NSString *)stringResultWithNumber:(NSInteger)floatNumber{
//    把floor换成ceil就可以四舍五入了
    return [NSString stringWithFormat:@"%g" , ceil(self.doubleValue * pow(10, floatNumber) / pow(10, floatNumber))];
}
@end
