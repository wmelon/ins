 

#import <UIKit/UIKit.h>

#import "XlSegmentView.h"
#import "XlSegementItem.h"

@protocol XlSegementControlDetegate;

@interface XlSegementControl : UIControl

- (id)initWithSegmentViews:(NSArray *)items;

- (id)initWithItems:(NSArray *)items;

- (void)setTitle:(NSString *)title forSegmentAtIndex:(NSUInteger)index;

- (void)setImage:(UIImage *)image setHighlineImage:(UIImage *)highlineImage forSegmentAtIndex:(NSUInteger)index;

- (void)removeSegmentAtIndex:(NSUInteger)index;

- (void)removeAllSegments;

@property(nonatomic) NSInteger selectedSegmentIndex;

/* Default tintColor is nil. The tintColor is inherited through the superview hierarchy. See UIView for more information.
 */
@property(nonatomic,retain) UIColor *tintColor;

@property(nonatomic,retain) UIView *backgroundView;
//字体的颜色
@property(nonatomic,strong) UIColor *textColor;
//字体选中的颜色
@property(nonatomic,strong) UIColor *selectTextColor;
//分隔图片 如果有才显示
@property(nonatomic,retain) UIImage *separatorImage;
//字体
@property (nonatomic)UIFont *font;
//底部选中条颜色
@property (nonatomic)UIColor *lineColor;
//是否显示底部选中条  默认显示
@property (nonatomic)BOOL isShowBottomLine;
//底部移动的标志icon
@property (nonatomic, strong) UIImage *bottomIcon;
//底部线条的左右间距
@property (nonatomic, assign) CGFloat bottomLineMargin;

@property(nonatomic,weak) id<XlSegementControlDetegate>delegate;

@end


@protocol XlSegementControlDetegate <NSObject>

//selectedSegmentIndex 改变时
-(void)segmentedControl:(XlSegementControl*)segmentedControl didSelectIndex:(NSInteger)index;
@end
