//
//  LiveUserCell.m
//  ins
//
//  Created by Sper on 16/11/14.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "LiveUserCell.h"

@interface LiveUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UIImageView *smallImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation LiveUserCell

- (void)setModel:(LiveUserModel *)model{
    _model = model;
    
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:_model.bigpic] placeholderImage:nil];
    [self.smallImageView sd_setImageWithURL:[NSURL URLWithString:_model.smallpic] placeholderImage:nil];
    self.titleLabel.text = _model.myname;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
