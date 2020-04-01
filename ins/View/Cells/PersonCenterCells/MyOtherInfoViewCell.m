//
//  MyOtherInfoViewCell.m
//  PumpkinCar
//
//  Created by FSAnonymous on 16/3/23.
//  Copyright © 2016年 mrocker. All rights reserved.
//

#import "MyOtherInfoViewCell.h"

@interface MyOtherInfoViewCell ()
@property (nonatomic, strong) UIImageView *indicatorIcon;
@end
@implementation MyOtherInfoViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NSString *cellId = NSStringFromClass([self class]);
    MyOtherInfoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}
- (void)setupView {
    self.textLabel.textColor = UIColorFromRGB(0x333333);
    self.textLabel.font = [UIFont systemFontOfSize:14];
    _icon = [UIImageView new];
    _icon.contentMode = UIViewContentModeScaleAspectFit;
    _icon.clipsToBounds = YES;
    [self.contentView addSubview: _icon];
    
    _contentLabel = [UILabel new];
    _contentLabel.textColor = UIColorFromRGB(0x9b9b9b);
    _contentLabel.font = [UIFont systemFontOfSize:12];
    _contentLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_contentLabel];
    
    _infoCount = [UILabel new];
    _infoCount.textColor = UIColorFromRGB(0x333333);
    _infoCount.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_infoCount];
    
    _hotWord = [UILabel new];
    _hotWord.textColor = UIColorFromRGB(0x333333);
    _hotWord.textAlignment = NSTextAlignmentRight;
    _hotWord.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_hotWord];
    
    _sepLine = [UILabel new];
    _sepLine.backgroundColor = UIColorFromRGB(0xe1e1e1);
    [self.contentView addSubview:_sepLine];
    
    _indicatorIcon = [UIImageView new];
    UIImage *theImage =
    [[UIImage imageNamed:@"right"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _indicatorIcon.image = theImage;
    _indicatorIcon.tintColor = UIColorFromRGB(0xc9c9c9);
    [self.contentView addSubview:_indicatorIcon];
}

- (void)setInfoCountStr:(NSString *)infoCountStr {
    _infoCountStr = infoCountStr;
    _infoCount.text = infoCountStr;
    [_infoCount sizeToFit];
}

- (void)setHotWordStr:(NSString *)hotWordStr {
    _hotWordStr = hotWordStr;
    _hotWord.text = hotWordStr;
    [_hotWord sizeToFit];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    if (self.icon.image){
        self.icon.frame = CGRectMake(16, (44-16)/2, 16, 16);
    }else {
        self.icon.frame = CGRectMake(8, 0, 0, 0);
    }
    self.textLabel.x = CGRectGetMaxX(self.icon.frame) + 8;
    _infoCount.x = self.textLabel.text.length * 14 + 16 + 10;
    _infoCount.y = (self.height - 14)/2 -2;
    _hotWord.x = kScreenWidth - 16 - 6 - _hotWord.width - 10;
    _hotWord.y = (self.height - 14)/2 -2;
    _indicatorIcon.frame = CGRectMake(kScreenWidth - 16 - 6, (self.height - 12)/2, 6, 12);
    _contentLabel.frame = CGRectMake(kScreenWidth - 22 - 10 - 100, (self.height - 12)/2, 100, 12);
    _sepLine.frame = CGRectMake(0, self.contentView.height - 0.5, kScreenWidth, 0.5);
    
}@end
