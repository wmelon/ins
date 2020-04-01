//
//  WeChatPublicNoCell.h
//  ins
//
//  Created by Sper on 16/7/5.
//  Copyright © 2016年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeChatPublicNoModel.h"

@interface WeChatPublicNoCell : UITableViewCell
@property (nonatomic,strong)WeChatPublicNoModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
