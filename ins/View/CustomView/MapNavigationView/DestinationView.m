//
//  DestinationView.m
//  ins
//
//  Created by Sper on 16/7/18.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "DestinationView.h"

@interface DestinationView()
@property (weak, nonatomic) IBOutlet UILabel *arriveAddress;
@property (weak, nonatomic) IBOutlet UILabel *detailAddress;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UIButton *toButton;

@end

@implementation DestinationView

- (void)awakeFromNib{
    self.toButton.layer.cornerRadius = 3;
    self.toButton.layer.masksToBounds = YES;
}
- (void)setPath:(AMapPath *)path{
    _path = path;
    
    CGFloat distance = _path.distance / 1000.0;
    _distance.text = [NSString stringWithFormat:@"距您%.1f公里",distance];
    
    NSInteger feng = _path.duration / 60;
    NSInteger hour = feng / 60;
    _time.text = [NSString stringWithFormat:@"%ld小时%ld分" , hour , feng % 60];
}
/**开启导航*/
- (IBAction)goThere:(id)sender {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
