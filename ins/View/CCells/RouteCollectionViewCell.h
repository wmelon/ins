//
//  RouteCollectionViewCell.h
//  ins
//
//  Created by Sper on 16/7/18.
//  Copyright © 2016年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface RouteCollectionViewInfo : NSObject

@property (nonatomic, assign) NSInteger routeID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end

@interface RouteCollectionViewCell : UICollectionViewCell
{
    UILabel *_titleLabel;
    UILabel *_subtitleLabel;
    UIImageView *_nextImageView;
}
/**公交线路*/
@property (nonatomic , strong)AMapTransit * transit;
//@property (nonatomic , strong)RouteCollectionViewInfo *info;
@end
