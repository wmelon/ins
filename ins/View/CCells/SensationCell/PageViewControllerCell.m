//
//  PageViewControllerCell.m
//  ins
//
//  Created by Sper on 16/8/5.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "PageViewControllerCell.h"

static NSString * SensationCellID = @"SensationCellID";

@interface PageViewControllerCell()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    SwitchViewController * _svc;
}
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,assign)NSInteger curPageIndex;
@property (nonatomic,strong)NSMutableArray * scrollViewArray;
@end

@implementation PageViewControllerCell
- (NSMutableArray *)scrollViewArray{
    if (!_scrollViewArray){
        _scrollViewArray = [NSMutableArray array];
        _svc = [SwitchViewController sharedSVC];
    }
    return _scrollViewArray;
}
- (instancetype)init{
    if (self = [super init]){
        [self initView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self initView];
    }
    return self;
}
- (void)initView{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 2615)];
    _scrollView.contentSize = CGSizeMake(kScreenWidth * 3, 0);
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    [self.contentView addSubview:_scrollView];
    
    
    for (NSInteger index = 0; index < 3; ++index) {
        UICollectionViewFlowLayout *_flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumInteritemSpacing = 15;
        _flowLayout.minimumLineSpacing = 15;
        // 设置滚动方向
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(index * kScreenWidth, 0, kScreenWidth, _scrollView.height) collectionViewLayout:_flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.opaque = YES;
        _collectionView.collectionViewLayout = _flowLayout;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.autoresizingMask = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"SensationCell" bundle:nil] forCellWithReuseIdentifier:SensationCellID];
//        UIScrollView *pageVerScrollView = [_dataSource slidePageScrollView:self pageVerticalScrollViewForIndex:index];
//        pageVerScrollView.frame = CGRectMake(index * viewWidth, 0, viewWidth, viewHight);
//        pageVerScrollView.contentInset = UIEdgeInsetsMake(headerContentViewHieght, 0, footerViewHieght, 0);
//        pageVerScrollView.scrollIndicatorInsets = UIEdgeInsetsMake(headerContentViewHieght, 0, footerViewHieght, 0);
        [_scrollView addSubview:_collectionView];
        [self.scrollViewArray addObject:_collectionView];
    }

}
- (void)setRows:(NSArray *)rows{  // 设置数据的时候reload一次collectionView就可以了。不需要每一次去滚动scorllerView都去reload UIcollectionView。否者这样会特别的卡
    _rows = rows;
    
    NSInteger rowCount = (self.rows.count / 3);  // 总行数
    CGFloat rowHeight = ((kScreenWidth - 15 * 4) / 3 + 30);
    _scrollView.frame = CGRectMake(0, 0, kScreenWidth, rowCount  *  rowHeight + 15 * (rowCount + 1));
    [self.scrollViewArray enumerateObjectsUsingBlock:^(UICollectionView * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.height =  rowCount  *  rowHeight + 15 * (rowCount + 1);
        [obj reloadData];
    }];
}

- (void)switchToPageIndex:(NSInteger)index{
    _scrollView.contentOffset  = CGPointMake(index * kScreenWidth, 0);
}

// horizen scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = (NSInteger)(scrollView.contentOffset.x/CGRectGetWidth(scrollView.frame));
    
    if (_curPageIndex != index) {
//        if (index >= _pageViewArray.count) {
//            index = _pageViewArray.count-1;
//        }
//        if (index < 0) {
//            index = 0;
//        }
//        
//        [self addPageViewKeyPathOffsetWithOldIndex:_curPageIndex newIndex:index];
        _curPageIndex = index;
        if ([self.delegate respondsToSelector:@selector(PageViewControllerCell:scorlPageTabBarAtIndex:)]){
            [self.delegate PageViewControllerCell:self scorlPageTabBarAtIndex:_curPageIndex];
        }
        
        
//        [self.scrollViewArray[_curPageIndex] reloadData];
//        if (_pageTabBar) {
//            [_pageTabBar switchToPageIndex:_curPageIndex];
//        }
//        if (_delegateFlags.horizenScrollToPageIndex) {
//            [_delegate slidePageScrollView:self horizenScrollToPageIndex:_curPageIndex];
//        }
    }
}

//- (void)layoutSubviews{
//    [super layoutSubviews];
//}

#pragma mark 设置单个itemSize
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((kScreenWidth - 15 * 4) / 3, (kScreenWidth - 15 * 4) / 3 + 30);
}
#pragma mark 设置有多少个section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark 设置某个分组有多少行
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.rows.count;
}

#pragma mark 设置某个Item显示什么内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SensationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SensationCellID forIndexPath:indexPath];
    cell.backgroundColor  =[UIColor lightGrayColor];
    if (self.rows.count){
        cell.model = self.rows[indexPath.row];
    }
    return cell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 15.0;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 15, 0, 15);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SensationModel * model = self.rows[indexPath.row];
    [UrlSchemeSkip urlSkipByScheme:[NSURL URLWithString:model.link]];
}
@end

