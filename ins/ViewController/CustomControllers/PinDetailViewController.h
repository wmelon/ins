//
//  PinDetailViewController.h
//  仿花瓣
//
//  Created by Sper on 16/8/12.
//  Copyright © 2016年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HuabanModel.h"
#import "BaseViewController.h"

@interface PinDetailViewController : BaseViewController
@property (nonatomic , strong)HuabanModel * model;

@property (nonatomic , strong)UIImageView *imageView;
@end
