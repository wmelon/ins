//
//  SensationDetailHeadIconView.m
//  ins
//
//  Created by Sper on 16/8/10.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "SensationDetailHeadIconView.h"

@interface SensationDetailHeadIconView()<ScalableCoverDelegate>
@property (nonatomic, strong) UIImageView *imageView; // 下拉放大图片
@end

@implementation SensationDetailHeadIconView
- (instancetype)initWithScaleTableView:(UITableView *)tableView
                                 frame:(CGRect) frame{
    if (self = [super initWithFrame:frame]){
        if (!tableView.scalableCover) {
            [tableView addScalableCoverWithImage:[UIImage imageNamed:@"test1.jpg"]];
        }else {
            tableView.scalableCover.image = [UIImage imageNamed:@"test1.jpg"];
        }
        _imageView = tableView.scalableCover;
        _imageView.frame = tableView.scalableCover.frame;
        tableView.scalableCover.delegate = self;
    }
    return self;
}
- (void)settingFrame:(CGRect)frame {
    self.frame = frame;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
