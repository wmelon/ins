//
//  AppNavigationBar.m
//  中间者设计模式框架搭建
//
//  Created by Sper on 16/5/31.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "AppNavigationBar.h"

@interface AppNavigationBar()
@property(strong, nonatomic)UIImage *storedBackgroundImage;
@end

@implementation AppNavigationBar

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Do any additional setup after loading the view.
        self.translucent = YES;
        self.barTintColor = [UIColor mainColor];
        self.tintColor = [UIColor whiteColor];
        
        NSShadow* shadow = [[NSShadow alloc] init];
        shadow.shadowColor = [UIColor clearColor];
        self.titleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor], NSShadowAttributeName:shadow};
        
        
        
//        self.translucent = YES;
//        _storedBackgroundImage = [UIImage buildImageWithColor:[UIColor whiteColor]];
//        [self setBackgroundImage:_storedBackgroundImage forBarMetrics:UIBarMetricsDefault];
//        
//        NSShadow* shadow = [[NSShadow alloc] init];
//        shadow.shadowColor = [UIColor clearColor];
//        self.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17],
//                                     NSForegroundColorAttributeName:[UIColor blackColor],
//                                     NSShadowAttributeName:shadow};
//        self.shadowImage = [[UIImage alloc] init];
//        self.layer.shadowColor = [UIColor lineColor].CGColor;
//        self.layer.shadowOffset = CGSizeMake(0, 0.5);
//        self.layer.shadowOpacity = 1;
//        self.layer.shadowRadius = 0.1;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
