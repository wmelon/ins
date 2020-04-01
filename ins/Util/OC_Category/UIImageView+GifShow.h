//
//  UIImageView+GifShow.h
//  ins
//
//  Created by Sper on 16/11/15.
//  Copyright © 2016年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (GifShow)

// 播放GIF
- (void)playGifAnim:(NSArray *)images;
// 停止动画
- (void)stopGifAnim;
@end
