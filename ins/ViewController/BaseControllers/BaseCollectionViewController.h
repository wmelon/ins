//
//  BaseCollectionViewController.h
//  ins
//
//  Created by Sper on 16/7/31.
//  Copyright © 2016年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface BaseCollectionViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    UICollectionView *_collectionView;
    NSMutableArray *_rows;
}
/** 返回的行数 */
@property(nonatomic,strong)NSMutableArray *rows;
/** collectionView */
@property(nonatomic, strong)UICollectionView *collectionView;

/**开始刷新*/
-(void)beginRequest;
/**停止刷新*/
-(void)finishRequest;

#pragma mark - 以下方法可以被子类重写
/**
 *  如果不想要下拉刷新，子类需要重写这个方法并返回NO
 *
 *  @return 默认为YES
 */
-(BOOL)shouldShowRefresh;
/**
 *  如果不想要上拉加载更多，子类需要重写这个方法并返回NO
 *
 *  @return 默认为YES
 */
-(BOOL)shouldShowGetMore;
/**
 *  子类需要完成重写这个方法，这个方法默认调用finishRequest方法，子类在其请求完成回调后，需要手动调用finishRequest
 */
-(void)requestRefresh;
/**
 *  子类需要完成重写这个方法，这个方法默认调用finishRequest方法，子类在其请求完成回调后，需要手动调用finishRequest
 */
-(void)requestGetMore;
@end
