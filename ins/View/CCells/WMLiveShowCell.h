//
//  WMLiveShowCell.h
//  ins
//
//  Created by Sper on 16/11/14.
//  Copyright © 2016年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveUserModel.h"

@class ALinBottomToolView;

@interface WMLiveShowCell : UICollectionViewCell
/** 父控制器 */
@property (nonatomic, weak) UIViewController *parentVc;
@property (nonatomic , strong)LiveUserModel * model;
@end

typedef NS_ENUM(NSUInteger, LiveToolType) {
    LiveToolTypePublicTalk,
    LiveToolTypePrivateTalk,
    LiveToolTypeGift,
    LiveToolTypeRank,
    LiveToolTypeShare,
    LiveToolTypeClose
};

@interface ALinBottomToolView : UIView
/** 点击工具栏  */
@property(nonatomic, copy)void (^clickToolBlock)(LiveToolType type);
@end
