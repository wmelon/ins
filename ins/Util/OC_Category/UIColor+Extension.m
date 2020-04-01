//
//  UIColor+Extension.m
//  ins
//
//  Created by Sper on 16/6/28.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)
+ (UIColor *)mainColor {
    return [UIColor colorWithRed:69.0 / 255 green:60.0 / 255 blue:77.0/ 255 alpha:1];
}
+ (UIColor *)pageBackgroundColor{
    return UIColorFromRGB(0xEFEFF4);
}
+ (UIColor *)lineColor{
    return UIColorFromRGB(0xE1E1E1);
}
@end
