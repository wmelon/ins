//
//  UIScrollView+ScalableCover.h
//  我的app
//
//  Created by 陈荣 on 16/1/9.
//  Copyright © 2016年 陈荣. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat MaxHeight = 200;

@protocol ScalableCoverDelegate <NSObject>

- (void)settingFrame:(CGRect)frame;

@end
@interface ScalableCover : UIImageView

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) id<ScalableCoverDelegate> delegate ;

@end




@interface UIScrollView (ScalableCover)

@property (nonatomic, weak) ScalableCover *scalableCover;

- (void)addScalableCoverWithImage:(UIImage *)image;
- (void)removeScalableCover;

@end

