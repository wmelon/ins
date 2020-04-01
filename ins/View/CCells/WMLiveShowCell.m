//
//  WMLiveShowCell.m
//  ins
//
//  Created by Sper on 16/11/14.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "WMLiveShowCell.h"
#import "UIImage+ALinExtension.h"
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

@interface WMLiveShowCell(){
    SwitchViewController * _svc;
}
///** 直播播放器 */
//@property (nonatomic, strong) IJKFFMoviePlayerController *moviePlayer;
///** 直播开始前的占位图片 */
//@property(nonatomic, weak) UIImageView *placeHolderView;
///** 底部的工具栏 */
//@property(nonatomic, weak) ALinBottomToolView *toolView;
///** 粒子动画 */
//@property(nonatomic, weak) CAEmitterLayer *emitterLayer;
///** 同类型直播视图 */
//@property(nonatomic, strong)UIView *catEarView;
@end

@implementation WMLiveShowCell

//- (UIImageView *)placeHolderView
//{
//    if (!_placeHolderView) {
//        UIImageView *imageView = [[UIImageView alloc] init];
//        imageView.frame = self.contentView.bounds;
//        imageView.image = [UIImage imageNamed:@"profile_user_414x414"];
//        [self.contentView addSubview:imageView];
//        _placeHolderView = imageView;
//        [_svc showGifLoding:nil message:nil];
//        // 强制布局
//        [_placeHolderView layoutIfNeeded];
//    }
//    return _placeHolderView;
//}
//- (UIView *)catEarView{
//    if (!_catEarView){
//        _catEarView = [[UIView alloc] init];
//        _catEarView.backgroundColor = [UIColor redColor];
//        [self.moviePlayer.view addSubview:_catEarView];
//        [_catEarView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(@-30);
//            make.centerY.equalTo(self.moviePlayer.view);
//            make.width.height.equalTo(@98);
//        }];
//    }
//    return _catEarView;
//}
//- (ALinBottomToolView *)toolView
//{
//    if (!_toolView) {
//        ALinBottomToolView *toolView = [[ALinBottomToolView alloc] init];
//        [toolView setClickToolBlock:^(LiveToolType type) {
//            switch (type) {
//                case LiveToolTypePublicTalk:
//                    
//                    break;
//                case LiveToolTypePrivateTalk:
//                    
//                    break;
//                case LiveToolTypeGift:
//                    
//                    break;
//                case LiveToolTypeRank:
//                    
//                    break;
//                case LiveToolTypeShare:
//                    
//                    break;
//                case LiveToolTypeClose:
//                    [self quit];
//                    break;
//                default:
//                    break;
//            }
//        }];
//        [self.contentView insertSubview:toolView aboveSubview:self.placeHolderView];
//        [toolView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.equalTo(@0);
//            make.bottom.equalTo(@-10);
//            make.height.equalTo(@40);
//        }];
//        _toolView = toolView;
//    }
//    return _toolView;
//}
//- (void)quit
//{
//    if (_moviePlayer) {
//        [self.moviePlayer shutdown];
//        [[NSNotificationCenter defaultCenter] removeObserver:self];
//    }
//    if (_catEarView) {
//        [_catEarView removeFromSuperview];
//        _catEarView = nil;
//    }
//    [self.parentVc dismissViewControllerAnimated:YES completion:nil];
//}
//
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    if (self = [super initWithFrame:frame]) {
//        _svc = [SwitchViewController sharedSVC];
//        self.toolView.hidden = NO;
//    }
//    return self;
//}
//- (void)setModel:(LiveUserModel *)model{
//    _model = model;
//    [self plarFLV:_model.flv placeHolderUrl:_model.bigpic];
//}
//
//- (void)plarFLV:(NSString *)flv placeHolderUrl:(NSString *)placeHolderUrl{
//    if (_moviePlayer) {
//        if (_moviePlayer) {
//            [self.contentView insertSubview:self.placeHolderView aboveSubview:_moviePlayer.view];
//        }
//        [_moviePlayer shutdown];
//        [_moviePlayer.view removeFromSuperview];
//        _moviePlayer = nil;
//        [[NSNotificationCenter defaultCenter] removeObserver:self];
//    }
//    
//    // 如果切换主播, 取消之前的动画
//    if (_emitterLayer) {
//        [_emitterLayer removeFromSuperlayer];
//        _emitterLayer = nil;
//    }
//    
//    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:placeHolderUrl] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.placeHolderView.image = [UIImage blurImage:image blur:0.8];
//        });
//    }];
//    
//    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
//    [options setPlayerOptionIntValue:1  forKey:@"videotoolbox"];
//    
//    // 帧速率(fps) （可以改，确认非标准桢率会导致音画不同步，所以只能设定为15或者29.97）
//    [options setPlayerOptionIntValue:29.97 forKey:@"r"];
//    // -vol——设置音量大小，256为标准音量。（要设置成两倍音量时则输入512，依此类推
//    [options setPlayerOptionIntValue:512 forKey:@"vol"];
//    IJKFFMoviePlayerController *moviePlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:flv withOptions:options];
//    moviePlayer.view.frame = self.contentView.bounds;
//    // 填充fill
//    moviePlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
//    // 设置自动播放(必须设置为NO, 防止自动播放, 才能更好的控制直播的状态)
//    moviePlayer.shouldAutoplay = NO;
//    // 默认不显示
//    moviePlayer.shouldShowHudView = NO;
//    
//    [self.contentView insertSubview:moviePlayer.view atIndex:0];
//    
//    [moviePlayer prepareToPlay];
//    
//    self.moviePlayer = moviePlayer;
//    
//    // 设置监听
//    [self initObserver];
//    
//    // 显示工会其他主播和类似主播
////    [moviePlayer.view bringSubviewToFront:self.otherView];
//    
//    // 开始来访动画
//    [self.emitterLayer setHidden:NO];
//    
//}
//- (CAEmitterLayer *)emitterLayer
//{
//    if (!_emitterLayer) {
//        CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
//        // 发射器在xy平面的中心位置
//        emitterLayer.emitterPosition = CGPointMake(self.moviePlayer.view.frame.size.width-50,self.moviePlayer.view.frame.size.height-50);
//        // 发射器的尺寸大小
//        emitterLayer.emitterSize = CGSizeMake(20, 20);
//        // 渲染模式
//        emitterLayer.renderMode = kCAEmitterLayerUnordered;
//        // 开启三维效果
//        //    _emitterLayer.preservesDepth = YES;
//        NSMutableArray *array = [NSMutableArray array];
//        // 创建粒子
//        for (int i = 0; i<10; i++) {
//            // 发射单元
//            CAEmitterCell *stepCell = [CAEmitterCell emitterCell];
//            // 粒子的创建速率，默认为1/s
//            stepCell.birthRate = 1;
//            // 粒子存活时间
//            stepCell.lifetime = arc4random_uniform(4) + 1;
//            // 粒子的生存时间容差
//            stepCell.lifetimeRange = 1.5;
//            // 颜色
//            // fire.color=[[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1]CGColor];
//            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"good%d_30x30", i]];
//            // 粒子显示的内容
//            stepCell.contents = (id)[image CGImage];
//            // 粒子的名字
//            //            [fire setName:@"step%d", i];
//            // 粒子的运动速度
//            stepCell.velocity = arc4random_uniform(100) + 100;
//            // 粒子速度的容差
//            stepCell.velocityRange = 80;
//            // 粒子在xy平面的发射角度
//            stepCell.emissionLongitude = M_PI+M_PI_2;;
//            // 粒子发射角度的容差
//            stepCell.emissionRange = M_PI_2/6;
//            // 缩放比例
//            stepCell.scale = 0.3;
//            [array addObject:stepCell];
//        }
//        
//        emitterLayer.emitterCells = array;
//        [_moviePlayer.view.layer insertSublayer:emitterLayer below:self.catEarView.layer];
//        _emitterLayer = emitterLayer;
//    }
//    return _emitterLayer;
//}
//
//- (void)initObserver
//{
//    // 监听视频是否播放完成
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinish) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:self.moviePlayer];
//}
//
//#pragma mark - notify method
//
//- (void)stateDidChange
//{
//    if ((self.moviePlayer.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
//        if (!self.moviePlayer.isPlaying) {
//            [self.moviePlayer play];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                if (_placeHolderView) {
//                    [_placeHolderView removeFromSuperview];
//                    _placeHolderView = nil;
////                    [self.moviePlayer.view addSubview:_renderer.view];
//                }
//                [_svc hideGufLoding];
//            });
//        }else{
//            // 如果是网络状态不好, 断开后恢复, 也需要去掉加载
//            if (_svc.gifView.isAnimating) {
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [_svc hideGufLoding];
//                });
//            }
//        }
//    }else if (self.moviePlayer.loadState & IJKMPMovieLoadStateStalled){ // 网速不佳, 自动暂停状态
//        [_svc showGifLoding:nil message:nil];
//    }
//}
//
//- (void)didFinish
//{
//    NSLog(@"加载状态...%ld %ld %s", self.moviePlayer.loadState, self.moviePlayer.playbackState, __func__);
//    // 因为网速或者其他原因导致直播stop了, 也要显示GIF
//    if (self.moviePlayer.loadState & IJKMPMovieLoadStateStalled && !_svc.gifView) {
//        [_svc showGifLoding:nil message:nil];
//        return;
//    }
//    //    方法：
//    //      1、重新获取直播地址，服务端控制是否有地址返回。
//    //      2、用户http请求该地址，若请求成功表示直播未结束，否则结束
////    __weak typeof(self)weakSelf = self;
////    [[ALinNetworkTool shareTool] GET:self.live.flv parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
////        NSLog(@"请求成功%@, 等待继续播放", responseObject);
////    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
////        NSLog(@"请求失败, 加载失败界面, 关闭播放器%@", error);
////        [weakSelf.moviePlayer shutdown];
////        [weakSelf.moviePlayer.view removeFromSuperview];
////        weakSelf.moviePlayer = nil;
////        weakSelf.endView.hidden = NO;
////    }];
//}
//
//@end
//
//
//@implementation ALinBottomToolView
//
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    if (self = [super initWithFrame:frame]) {
//        [self setup];
//    }
//    return self;
//}
//
//- (NSArray *)tools
//{
//    return @[@"talk_public_40x40", @"talk_private_40x40", @"talk_sendgift_40x40", @"talk_rank_40x40", @"talk_share_40x40", @"talk_close_40x40"];
//}
//
//- (void)setup
//{
//    CGFloat wh = 40;
//    CGFloat margin = (kScreenWidth - wh * self.tools.count) / (self.tools.count + 1.0);
//    CGFloat x = 0;
//    CGFloat y = 0;
//    for (int i = 0; i<self.tools.count; i++) {
//        x = margin + (margin + wh) * i;
//        UIImageView *toolView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, wh, wh)];
//        toolView.userInteractionEnabled = YES;
//        toolView.tag = i;
//        toolView.image = [UIImage imageNamed:self.tools[i]];
//        [toolView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)]];
//        [self addSubview:toolView];
//    }
//}
//
//- (void)click:(UITapGestureRecognizer *)tapRec
//{
//    if (self.clickToolBlock) {
//        self.clickToolBlock(tapRec.view.tag);
//    }
//}
@end


