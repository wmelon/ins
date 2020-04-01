//
//  PageViewControllerCell.h
//  ins
//
//  Created by Sper on 16/8/5.
//  Copyright © 2016年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SensationModel.h"
#import "SensationCell.h"

@class PageViewControllerCell;
@protocol PageViewControllerCellDelegate <NSObject>

- (void)PageViewControllerCell:(PageViewControllerCell *)pageViewControllerCell scorlPageTabBarAtIndex:(NSInteger)index;

@end

@interface PageViewControllerCell : UICollectionViewCell
@property (nonatomic , strong)NSArray * rows;
@property (nonatomic , weak)id<PageViewControllerCellDelegate> delegate;
- (void)switchToPageIndex:(NSInteger)index;
@end
