//
//  SwitchSensationHeaderView.m
//  ins
//
//  Created by Sper on 16/8/6.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "SwitchSensationHeaderView.h"

@interface SwitchSensationHeaderView()
@property (nonatomic , strong)NSMutableArray * btnArray;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, weak) UIView *horIndicator;
@end

@implementation SwitchSensationHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _textFont = [UIFont systemFontOfSize:16];
        _selectedTextFont = [UIFont systemFontOfSize:19];
        _textColor = [UIColor darkTextColor];
        _selectedTextColor = [UIColor redColor];
        _horIndicatorColor = [UIColor redColor];
        _horIndicatorHeight = 2;
        [self addHorIndicatorView];
    }
    return self;
}

- (instancetype)init{
    if (self = [super init]){
        _textFont = [UIFont systemFontOfSize:16];
        _selectedTextFont = [UIFont systemFontOfSize:19];
        _textColor = [UIColor darkTextColor];
        _selectedTextColor = [UIColor redColor];
        _horIndicatorColor = [UIColor redColor];
        _horIndicatorHeight = 2;
        [self addHorIndicatorView];
    }
    return self;
}

#pragma mark - add subView

- (void)addHorIndicatorView
{
    UIView *horIndicator = [[UIView alloc]init];
    horIndicator.backgroundColor = _horIndicatorColor;
    [self addSubview:horIndicator];
}

- (void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    
    [self addTitleBtnArray];
}

- (void)addTitleBtnArray
{
    if (_btnArray) {
        [self removeTitleBtnArray];
    }
    
    NSMutableArray *btnArray = [NSMutableArray arrayWithCapacity:_titleArray.count];
    for (NSInteger index = 0; index < _titleArray.count; ++index) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = index;
        button.titleLabel.font = _textFont;
        [button setTitle:_titleArray[index] forState:UIControlStateNormal];
        [button setTitleColor:_textColor forState:UIControlStateNormal];
        [button setTitleColor:_selectedTextColor forState:UIControlStateSelected];
        [button addTarget:self action:@selector(tabButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [btnArray addObject:button];
        if (index == 0) {
            [self selectButton:button];
        }
    }
    _btnArray = [btnArray copy];
}

#pragma mark - action method
// clicked
- (void)tabButtonClicked:(UIButton *)button
{
    [self selectButton:button];
    
    // need ourself call this method
    [self clickedPageTabBarAtIndex:button.tag];
}

- (void)clickedPageTabBarAtIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(switchSensationHeaderView:clickedPageTabBarAtIndex:)]){
        [self.delegate switchSensationHeaderView:self clickedPageTabBarAtIndex:index];
    }
}
#pragma mark - override method
// override
- (void)switchToPageIndex:(NSInteger)index
{
    if (index >= 0 && index < _btnArray.count) {
        [self selectButton:_btnArray[index]];
    }
}
- (void)selectButton:(UIButton *)button
{
    if (_selectBtn) {
        _selectBtn.selected = NO;
        if (_selectedTextFont) {
            _selectBtn.titleLabel.font = _textFont;
        }
    }
    _selectBtn = button;
    
    CGRect frame = _horIndicator.frame;
    frame.origin.x = CGRectGetMinX(_selectBtn.frame);
    [UIView animateWithDuration:0.2 animations:^{
        _horIndicator.frame = frame;
        
    }];
    
    _selectBtn.selected = YES;
    if (_selectedTextFont) {
        _selectBtn.titleLabel.font = _selectedTextFont;
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnWidth = (CGRectGetWidth(self.frame)-_edgeInset.left-_edgeInset.right + _titleSpacing)/_btnArray.count - _titleSpacing;
    CGFloat viewHeight = CGRectGetHeight(self.frame)-_edgeInset.top-_edgeInset.bottom;
    
    [_btnArray enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        button.frame = CGRectMake(idx*(btnWidth+_titleSpacing)+_edgeInset.left, _edgeInset.top, btnWidth, viewHeight);
    }];
    
    NSInteger curIndex = 0;
    if (_selectBtn) {
        curIndex = [_btnArray indexOfObject:_selectBtn];
    }
    _horIndicator.frame = CGRectMake(curIndex*(btnWidth+_titleSpacing)+_edgeInset.left, CGRectGetHeight(self.frame) - _horIndicatorHeight, btnWidth, _horIndicatorHeight);
}


- (void)removeTitleBtnArray
{
    for (UIButton *button in _btnArray) {
        [button removeFromSuperview];
    }
    _btnArray = nil;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
