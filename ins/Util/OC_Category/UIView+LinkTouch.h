//
//  UIView+LinkTouch.h
//  ins
//
//  Created by Sper on 16/9/28.
//  Copyright © 2016年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LinkTouch)
@property(nullable, nonatomic, strong)UIColor * highlightedColor;
- (void)addTarget:(nullable id)target action:(nullable SEL)action forControlEvents:(UIControlEvents)controlEvents;
@end
