//
//  PersonOrderStatusCell.m
//  BeautyBankCSJ1.0
//
//  Created by Sper on 16/4/15.
//  Copyright © 2016年 陈仕家. All rights reserved.
//

#import "PersonOrderStatusCell.h"
#import "UIView+LinkTouch.h"

@interface PersonOrderStatusCell()
@property (weak, nonatomic) IBOutlet UIView *leftBgView;
@property (weak, nonatomic) IBOutlet UIView *middleBgView;
@property (weak, nonatomic) IBOutlet UIView *rightBgView;
@property (weak, nonatomic) IBOutlet UILabel *lineOne;
@property (weak, nonatomic) IBOutlet UILabel *lineTwo;

@property (weak, nonatomic) IBOutlet UILabel *waitPayLabel;
@property (weak, nonatomic) IBOutlet UILabel *waitPayCount;

@property (weak, nonatomic) IBOutlet UILabel *waitServiceLabel;
@property (weak, nonatomic) IBOutlet UILabel *waitServiceCount;

@property (weak, nonatomic) IBOutlet UILabel *waitCommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *waitCommentCount;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineOneWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineTwoWidth;
@end

@implementation PersonOrderStatusCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lineOneWidth.constant = 0.5;
    self.lineTwoWidth.constant = 0.5;
    
    
    self.leftBgView.backgroundColor = [UIColor clearColor];
    [self.leftBgView addTarget:self action:@selector(waitPayClick) forControlEvents:UIControlEventTouchUpInside];
    self.middleBgView.backgroundColor = [UIColor clearColor];
    [self.middleBgView addTarget:self action:@selector(waitServiceClick) forControlEvents:UIControlEventTouchUpInside];
    self.rightBgView.backgroundColor = [UIColor clearColor];
    [self.rightBgView addTarget:self action:@selector(waitCommentClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.lineOne.backgroundColor = UIColorFromRGB(0xE1E1E1);
    self.lineTwo.backgroundColor = UIColorFromRGB(0xE1E1E1);
    
    self.waitPayLabel.textColor = UIColorFromRGB(0x333333);
    self.waitPayLabel.userInteractionEnabled = YES;
    self.waitPayCount.textColor = UIColorFromRGB(0x9B9B9B);
    self.waitServiceCount.textColor = UIColorFromRGB(0x9B9B9B);
    self.waitServiceLabel.textColor = UIColorFromRGB(0x333333);
    self.waitServiceLabel.userInteractionEnabled = YES;
    self.waitCommentCount.textColor = UIColorFromRGB(0x9B9B9B);
    self.waitCommentLabel.textColor = UIColorFromRGB(0x333333);
    self.waitCommentLabel.userInteractionEnabled = YES;
    
//    UITapGestureRecognizer * leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(waitPayClick)];
//    [self.leftBgView addGestureRecognizer:leftTap];
//    
//    UITapGestureRecognizer * middleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(waitServiceClick)];
//    [self.middleBgView addGestureRecognizer:middleTap];
//
//    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(waitCommentClick)];
//    [self.rightBgView addGestureRecognizer:rightTap];
}

#pragma mark -- 待支付点击
- (void)waitPayClick{
    NSLog(@"待支付点击");
}
#pragma mark -- 待服务点击
- (void)waitServiceClick{
    NSLog(@"待服务点击");
}
#pragma mark -- 待评价点击
- (void)waitCommentClick{
    NSLog(@"待评价点击");
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
