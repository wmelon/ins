//
//  WMAppController.m
//  ins
//
//  Created by Sper on 16/9/23.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "WMAppController.h"

@interface PrivateApi_LSApplicationWorkspace
- (NSArray *)allInstalledApplications;
- (void)openApplicationWithBundleID:(NSString *)bundleId;
@end

@implementation WMAppController{
    NSArray * _installedApplications;
    PrivateApi_LSApplicationWorkspace *_workspace;
}

- (instancetype)init{
    if (self = [super init]){
        _workspace = [NSClassFromString(@"LSApplicationWorkspace") new];
    }
    return self;
}
+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static WMAppController * instance;
    dispatch_once(&onceToken, ^{
        instance = [[WMAppController alloc] init];
    });
    return instance;
}

- (NSArray *)installedApplications{
    if (nil == _installedApplications){
        _installedApplications = [self readApps];
    }
    return _installedApplications;
}
- (NSArray *)readApps{
    NSArray * array = [_workspace allInstalledApplications];
    NSMutableArray * applications = [NSMutableArray arrayWithCapacity:array.count];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull proxy, NSUInteger idx, BOOL * _Nonnull stop) {
        WMApp * app = [WMApp appWithPrivateProxy:proxy];
        if (!app.isHiddenApp){
            [applications addObject:app];
        }
    }];
    return applications;
}
- (void)openApplicationWithBundleID:(NSString *)bundleId{
    [_workspace openApplicationWithBundleID:bundleId];
}

//    //获取不到成员变量
//    int count = 0;
//    Ivar *members = class_copyIvarList([LSApplicationProxy_class class], &count);
//    for (int i = 0 ; i < count; i++) {
//        Ivar var = members[i];
//        const char *memberName = ivar_getName(var);
////        const char *memberType = ivar_getTypeEncoding(var);
//        NSLog(@"属性名称--------%s",memberName);
//    }
//    count = 0;
//    Method *memberMethods = class_copyMethodList(LSApplicationProxy_class, &count);
//    for (int i = 0; i < count; i++) {
//        SEL name = method_getName(memberMethods[i]);
//        NSString *methodName = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
//        NSLog(@"member method:%@", methodName);
//    }


@end
