//
//  CampaignInviteCell.m
//  ins
//
//  Created by Sper on 16/7/13.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "CampaignInviteCell.h"

@implementation CampaignInviteCell
+ (CampaignInviteCell *)cellWithTableView:(UITableView *)tableView{
    NSString * cellId = NSStringFromClass([self class]);
    CampaignInviteCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed: cellId owner:nil options:nil] lastObject];
    }
    return cell;
}
//- (void)setModel:(CampaignInviteModel *)model{
//    _model = model;
//}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
