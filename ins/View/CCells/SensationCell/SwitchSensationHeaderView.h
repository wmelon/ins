//
//  SwitchSensationHeaderView.h
//  ins
//
//  Created by Sper on 16/8/6.
//  Copyright © 2016年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SwitchSensationHeaderView;

@protocol SwitchSensationHeaderViewDelegate <NSObject>

- (void)switchSensationHeaderView:(SwitchSensationHeaderView *)SwitchSensationHeaderView clickedPageTabBarAtIndex:(NSInteger)index;

@end

@interface SwitchSensationHeaderView : UICollectionReusableView
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, strong) UIFont *selectedTextFont;

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *selectedTextColor;

@property (nonatomic, strong) UIColor *horIndicatorColor;
@property (nonatomic, assign) CGFloat horIndicatorHeight;

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, assign) UIEdgeInsets edgeInset;   // view edge Inset
@property (nonatomic, assign) CGFloat titleSpacing;     // title button spacing

@property (nonatomic, weak) id<SwitchSensationHeaderViewDelegate> delegate;

// override, auto call ,when TYSlidePageScrollView index change, you can change your pageTabBar index on this method
- (void)switchToPageIndex:(NSInteger)index;

@end
