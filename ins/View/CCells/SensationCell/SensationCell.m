//
//  SensationCell.m
//  ins
//
//  Created by Sper on 16/7/31.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "SensationCell.h"

@interface SensationCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end

@implementation SensationCell

- (void)setModel:(SensationModel *)model{
    _model= model;

    
    
    self.contentView.backgroundColor  =[UIColor greenColor];
    self.name.text = _model.uname;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_model.avatar] placeholderImage:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
