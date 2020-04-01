//
//  MyOtherInfoViewCell.h
//  PumpkinCar
//
//  Created by FSAnonymous on 16/3/23.
//  Copyright © 2016年 mrocker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOtherInfoViewCell : UITableViewCell
@property (nonatomic, copy) NSString *infoCountStr;
@property (nonatomic ,copy) NSString *hotWordStr;
@property (nonatomic, strong) UILabel *infoCount;
@property (nonatomic, strong) UILabel *hotWord;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *sepLine;
@property (nonatomic, strong) UIImageView *icon;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
