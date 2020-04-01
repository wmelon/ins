//
//  IntroVideoViewController.m
//  ins
//
//  Created by Sper on 16/8/11.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "IntroVideoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "WMAdManager.h"

@interface IntroVideoViewController ()
@property (nonatomic , strong)IntroVideoPlayBlock block;
@property (nonatomic,weak) AVPlayer *Playerview; // 播放器
@end

@implementation IntroVideoViewController
- (void)disPlayIntroVideo:(IntroVideoPlayBlock)block{
    self.block = block;
}
- (instancetype)init{
    if (self = [super init]){
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self playerAVPlayer]; // 播放器
    self.view.backgroundColor = [UIColor clearColor];
    
    
    UIView * bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    
    UIImageView * adImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 135)];
    adImg.image = [WMAdManager getAdImage];
    [bgView addSubview:adImg];
    
    
    UIImageView * bottomImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 135 , kScreenWidth, 135)];
    bottomImg.image = [UIImage imageNamed:@"adBottom"];
    [bgView addSubview:bottomImg];
    
    bgView.alpha = 0.99;
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self.view addSubview:bgView];
    [UIView animateWithDuration:3.0 animations:^{
        bgView.alpha = 1.0;
    } completion:^(BOOL finished) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [UIView animateWithDuration:0.25 animations:^{
            bgView.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (self.block){
                self.block();
            }
        }];
    }];
    
    
    
    
    
    
    
//    NSString * path = [[NSBundle mainBundle]pathForResource:@"intro_video" ofType:@"mp4"];
//    NSURL * url = [NSURL fileURLWithPath:path];
//    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
//    [self.moviePlayer.view setFrame:self.view.bounds];
//    [self.moviePlayer play];
//    [self.moviePlayer setShouldAutoplay:YES]; // And other options you can look through the documentation.
//    [self.view addSubview:self.moviePlayer.view];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playBackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
}
/** 播放器 */
- (void)playerAVPlayer
{
    // 播放mp4
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"intro_video" ofType:@"mp4"];
    NSURL *sourceMovieURL = [NSURL fileURLWithPath:filePath];
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
    
    AVPlayerItem * playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    self.Playerview = [AVPlayer playerWithPlayerItem:playerItem];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.Playerview];
    
    playerLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    self.Playerview.actionAtItemEnd = AVPlayerItemStatusFailed;
    
    [self.view.layer addSublayer:playerLayer];
    
    [self.Playerview play];
    
    //注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playBackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}
- (void)dealloc{
    _block = nil;
}
- (void)playBackFinished:(NSNotification *)noti{
    if (self.block){
        self.block();
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
