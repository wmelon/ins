//
//  WMAppController.h
//  ins
//
//  Created by Sper on 16/9/23.
//  Copyright © 2016年 WM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WMApp.h"

@interface WMAppController : NSObject
@property (nonatomic , readonly)NSArray *installedApplications;

+ (instancetype)sharedInstance;
- (void)openApplicationWithBundleID:(NSString *)bundleId;
@end
