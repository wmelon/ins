
/*!
 @header VideoModel.m
 
 @abstract  作者Github地址：https://github.com/zhengwenming
            作者CSDN博客地址:http://blog.csdn.net/wenmingzheng
 
 @author   Created by zhengwenming on  16/1/20
 
 @version 1.00 16/1/20 Creation(版本信息)
 
   Copyright © 2016年 郑文明. All rights reserved.
 */

#import "VideoModel.h"

@implementation VideoModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"]) {
        self.descriptionDe = value;
    }
}

+ (void)getSIDArrayWithSuccess:(RequestSuccessHandler)success failed:(RequestFailureHandler)failed;{
    [RequestManager getRequestWithURLPath:KURLStringVideoPlayList withParamer:nil completionHandler:^(id responseObject, NSUInteger statusCode) {
        success(responseObject , statusCode);
    } RequestFailureHandler:^(NSError *error, NSUInteger statusCode) {
        failed(error , statusCode);
    }];
}

+ (void)getVideoListWithListID:(NSString *)ID success:(RequestSuccessHandler)success failed:(RequestFailureHandler)failed{
    
}
@end
