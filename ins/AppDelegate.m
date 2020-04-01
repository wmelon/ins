//
//  AppDelegate.m
//  ins
//
//  Created by Sper on 16/6/26.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "AppDelegate.h"
#import "SwitchViewController.h"
#import "LocationModel.h"
#import "IntroVideoViewController.h"

//#import "iflyMSC/IFlySpeechSynthesizer.h"
//#import "iflyMSC/IFlySpeechSynthesizerDelegate.h"
//#import "iflyMSC/IFlySpeechConstant.h"
//#import "iflyMSC/IFlySpeechUtility.h"
//#import "iflyMSC/IFlySetting.h"

#import <AMapNaviKit/AMapNaviKit.h>
#import <AMapNaviKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)configureAPIKey{
    [[LocationModel shareLocationModel] startLocation];
    //配置用户Key
    [AMapNaviServices sharedServices].apiKey = @"f1ad4e34e2af055a4a0297d717548608";
    [MAMapServices sharedServices].apiKey = @"f1ad4e34e2af055a4a0297d717548608";
    [AMapSearchServices sharedServices].apiKey = @"f1ad4e34e2af055a4a0297d717548608";
}
//- (void)configIFlySpeech
//{
//    [IFlySpeechUtility createUtility:[NSString stringWithFormat:@"appid=%@,timeout=%@",@"5784cf7e",@"20000"]];
//    
//    [IFlySetting setLogFile:LVL_NONE];
//    [IFlySetting showLogcat:NO];
//    
//    // 设置语音合成的参数
//    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"50" forKey:[IFlySpeechConstant SPEED]];//合成的语速,取值范围 0~100
//    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"50" forKey:[IFlySpeechConstant VOLUME]];//合成的音量;取值范围 0~100
//    
//    // 发音人,默认为”xiaoyan”;可以设置的参数列表可参考个 性化发音人列表;
//    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"xiaoyan" forKey:[IFlySpeechConstant VOICE_NAME]];
//    
//    // 音频采样率,目前支持的采样率有 16000 和 8000;
//    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"8000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
//    
//    // 当你再不需要保存音频时，请在必要的地方加上这行。
//    [[IFlySpeechSynthesizer sharedInstance] setParameter:nil forKey:[IFlySpeechConstant TTS_AUDIO_PATH]];
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [self configIFlySpeech];
    /// 加入这句会出现手势不可滑动  （猜测可能是因为需要记录界面启动时间而影响到手势）
//    [OneAPM startWithApplicationToken: @"62C8F252D9B7AF081FEC91401567CA2272"];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    IntroVideoViewController *RootVc = [[IntroVideoViewController alloc] init];
    self.window.rootViewController = RootVc;
    [self.window makeKeyAndVisible];
    [RootVc disPlayIntroVideo:^{
        self.window.rootViewController = [SwitchViewController sharedSVC].rootNaviController;
    }];
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
