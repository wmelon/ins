//
//  WeChatPublicNoCell.m
//  ins
//
//  Created by Sper on 16/7/5.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "WeChatPublicNoCell.h"
#import "NSNumber+Format.h"

@interface WeChatPublicNoCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeight;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *publicNo;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *keyWord;
@property (weak, nonatomic) IBOutlet UILabel *number;

@end

@implementation WeChatPublicNoCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *cellId = NSStringFromClass([self class]);
    WeChatPublicNoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed: cellId owner:nil options:nil] lastObject];
    }
    return cell;
}
- (void)setModel:(WeChatPublicNoModel *)model{
    _model = model;
    
    self.iconImage.layer.cornerRadius = self.iconImage.width / 2;
    self.iconImage.layer.masksToBounds = YES;
    [self.iconImage sd_setImageWithURL:_model.kol_avatar_url];
    self.name.text = _model.biz_name;
    self.publicNo.text = [NSString stringWithFormat:@"微信号:%@",_model.biz_code];
    self.desc.text = _model.kol_info;
//    self.keyWord = 
    self.number.text = [_model.kol_influence_score stringResultWithNumber:0];
    
}
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
