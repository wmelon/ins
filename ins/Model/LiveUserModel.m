//
//  LiveUserModel.m
//  ins
//
//  Created by Sper on 16/11/14.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "LiveUserModel.h"

@implementation LiveUserModel
/// 获取直播用户列表
+ (void)requestLiveListParam:(NSDictionary *)param
                     Success:(RequestSuccessHandler)success
                      failed:(RequestFailureHandler)failed{
    [RequestManager getRequestWithURLPath:KURLStringGetHotLiveList withParamer:param completionHandler:^(id responseObject, NSUInteger statusCode) {
        success(responseObject , statusCode);
    } RequestFailureHandler:^(NSError *error, NSUInteger statusCode) {
        failed(error , statusCode);
    }];
}
@end
