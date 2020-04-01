//
//  IntroVideoViewController.h
//  ins
//
//  Created by Sper on 16/8/11.
//  Copyright © 2016年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^IntroVideoPlayBlock)(void);
@interface IntroVideoViewController : UIViewController
- (void)disPlayIntroVideo:(IntroVideoPlayBlock)block;
@end
