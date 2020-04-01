//
//  SensationProductCell.m
//  ins
//
//  Created by Sper on 16/7/31.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "SensationProductCell.h"

@interface SensationProductCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *lookCount;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UIImageView *leftImage;
@property (weak, nonatomic) IBOutlet UIImageView *middleImage;
@property (weak, nonatomic) IBOutlet UIImageView *rightImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeight;

@end

@implementation SensationProductCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(ProductModel *)model{
    _model = model;
    
    [_model.imgs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ImageModel * imageModel = obj;
        [self.leftImage sd_setImageWithURL:[NSURL URLWithString:imageModel.img] placeholderImage:nil];
        [self.middleImage sd_setImageWithURL:[NSURL URLWithString:imageModel.img] placeholderImage:nil];
        [self.rightImage sd_setImageWithURL:[NSURL URLWithString:imageModel.img] placeholderImage:nil];
    }];
   
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_model.avatar] placeholderImage:nil];
    self.name.text =_model.uname;
    self.lookCount.text = [NSString stringWithFormat:@"%@" , _model.visitors];
    self.time.text = [NSString stringWithFormat:@"%@" , _model.created];
}
@end
