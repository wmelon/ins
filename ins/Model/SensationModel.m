//
//  SensationModel.m
//  ins
//
//  Created by Sper on 16/7/31.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "SensationModel.h"

@implementation SensationModel
+ (void)requestSensationListWithParam:(NSDictionary *)param success:(RequestSuccessHandler)success failed:(RequestFailureHandler)failed{
    [RequestManager getRequestWithURLPath:KURLStringInternetSensation withParamer:param completionHandler:^(id responseObject, NSUInteger statusCode) {
        success(responseObject , statusCode);
    } RequestFailureHandler:^(NSError *error, NSUInteger statusCode) {
        failed(error , statusCode);
    }];
}
+ (void)requestSensationDetailWithParam:(NSDictionary *)param success:(RequestSuccessHandler)success failed:(RequestFailureHandler)failed{
    [RequestManager getRequestWithURLPath:KURLStringInternetSensationDetail withParamer:param completionHandler:^(id responseObject, NSUInteger statusCode) {
        success(responseObject , statusCode);
    } RequestFailureHandler:^(NSError *error, NSUInteger statusCode) {
        failed(error , statusCode);
    }];
}
@end
