//
//  PersonHeadImageCell.m
//  BeautyBankCSJ1.0
//
//  Created by Sper on 16/4/15.
//  Copyright © 2016年 陈仕家. All rights reserved.
//

#import "PersonHeadImageCell.h"

@interface PersonHeadImageCell()
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeight;

@end

@implementation PersonHeadImageCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lineHeight.constant = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
