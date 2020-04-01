//
//  WeChatPublicNoModel.m
//  ins
//
//  Created by Sper on 16/7/5.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "WeChatPublicNoModel.h"

@implementation WeChatPublicNoModel

+ (void)requestWeChatPublicNoWithParam:(NSDictionary *)param success:(RequestSuccessHandler)success failed:(RequestFailureHandler)failed{
    [RequestManager postRequestWithURLPath:KURLStringWeChatPublicNoList withParamer:param completionHandler:^(id responseObject, NSUInteger statusCode) {
        success(responseObject,statusCode);
    } RequestFailureHandler:^(NSError *error, NSUInteger statusCode) {
        failed(error,statusCode);
    }];
}
@end
