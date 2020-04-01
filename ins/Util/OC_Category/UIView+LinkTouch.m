//
//  UIView+LinkTouch.m
//  ins
//
//  Created by Sper on 16/9/28.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "UIView+LinkTouch.h"
#import <objc/runtime.h>

@interface UIView()
@property(nonatomic , nullable  , assign)SEL selAction;
@property(nonatomic , nullable  , strong)id target;
@property(nonatomic , strong , nullable)UIColor *normalColor;
@end

@implementation UIView (LinkTouch)

- (void)addTarget:(nullable id)target action:(nullable SEL)action forControlEvents:(UIControlEvents)controlEvents{
    self.target = target;
    self.selAction = action;
    self.userInteractionEnabled = YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if(self.target){
        self.normalColor = self.backgroundColor;
        [self setBackgroundColor:self.highlightedColor];
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    if(self.target){
        [UIView animateWithDuration:0.35 animations:^{
            [self setBackgroundColor:self.normalColor];
        } completion:^(BOOL finished) {
            if([self.target respondsToSelector:self.selAction]){
                
                IMP imp = [self.target methodForSelector:self.selAction];
                void (*func)(id, SEL) = (void *)imp;
                func(self.target,self.selAction);
                
//            ((void (*)(id, SEL))[self.selAction methodForSelector:_action])(self.target, self.selAction);
                //            [_target performSelector:_action withObject:self];
            }
        }];
    }
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    if(self.target){
        [UIView animateWithDuration:0.5 animations:^{
            [self setBackgroundColor:self.normalColor];
        } completion:^(BOOL finished) {
            
        }];
    }
}
- (void)setHighlightedColor:(UIColor *)highlightedColor{
    objc_setAssociatedObject(self, @selector(highlightedColor), highlightedColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIColor *)highlightedColor{
    UIColor *color = objc_getAssociatedObject(self, _cmd);
    if (color){
        return color;
    }
    return [UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
}
- (void)setNormalColor:(UIColor *)normalColor{
    objc_setAssociatedObject(self, @selector(normalColor), normalColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIColor *)normalColor{
    UIColor *color = objc_getAssociatedObject(self, _cmd);
    if (color){
        return color;
    }
    return [UIColor whiteColor];
}
- (void)setTarget:(id)target{
    objc_setAssociatedObject(self, @selector(target), target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (id)target{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setSelAction:(SEL)selAction{
    objc_setAssociatedObject(self, @selector(selAction), NSStringFromSelector(selAction), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (SEL)selAction{
    return NSSelectorFromString(objc_getAssociatedObject(self, _cmd));
}

@end
