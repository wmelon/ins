//
//  UIScrollView+ScalableCover.m
//  我的app
//
//  Created by 陈荣 on 16/1/9.
//  Copyright © 2016年 陈荣. All rights reserved.
//
#import "UIScrollView+ScalableCover.h"
#import <objc/runtime.h>

static NSString * const kContentOffset = @"contentOffset";
static NSString * const kScalableCover = @"scalableCover";

@implementation UIScrollView (ScalableCover)

- (void)setScalableCover:(ScalableCover *)scalableCover
{
    [self willChangeValueForKey:kScalableCover];
    objc_setAssociatedObject(self, &kScalableCover,
                             scalableCover,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kScalableCover];
}

- (ScalableCover *)scalableCover
{
    return objc_getAssociatedObject(self, &kScalableCover);
}

- (void)addScalableCoverWithImage:(UIImage *)image
{
    ScalableCover *cover = [[ScalableCover alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, UIHeightFromfloat(MaxHeight))];
    
    cover.backgroundColor = [UIColor clearColor];
    cover.image = image;
    cover.scrollView = self;
    
    [self addSubview:cover];
    [self sendSubviewToBack:cover];//图层最底部
    
    self.scalableCover = cover;
}

- (void)removeScalableCover
{
    [self.scalableCover removeFromSuperview];
    self.scalableCover = nil;
}


@end





@implementation ScalableCover

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    
    return self;
}


- (void)setScrollView:(UIScrollView *)scrollView
{
    [_scrollView removeObserver:self forKeyPath:kContentOffset];
    _scrollView = scrollView;
    [_scrollView addObserver:self forKeyPath:kContentOffset options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeFromSuperview
{
    [_scrollView removeObserver:self forKeyPath:kContentOffset];
    [super removeFromSuperview];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.scrollView.contentOffset.y < 0) {
        CGFloat offset = -self.scrollView.contentOffset.y;
        
        /** 微博效果 */
        self.frame = CGRectMake(0, -offset, _scrollView.bounds.size.width, UIHeightFromfloat(MaxHeight) + offset);
        /** 全局放大效果 */
//        self.frame = CGRectMake(-offset, -offset, _scrollView.bounds.size.width + offset * 2, UIHeightFromfloat(MaxHeight) + offset);
        
    } else {
        self.frame = CGRectMake(0, 0, _scrollView.bounds.size.width, UIHeightFromfloat(MaxHeight));
    }
    if ([self.delegate respondsToSelector:@selector(settingFrame:)]) {
        [self.delegate settingFrame:self.frame];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setNeedsLayout];
}


@end
