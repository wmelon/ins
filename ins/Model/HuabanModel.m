//
//  HuabanModel.m
//  仿花瓣
//
//  Created by Sper on 16/8/12.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "HuabanModel.h"
static NSString * baseImage = @"http://img.hb.aicdn.com/";
static NSString * baseFile =  @"http://hbfile.b0.upaiyun.com/";
static NSString * baseTopic = @"http://hb-topic-img.b0.upaiyun.com/";

@implementation HuabanModel
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"file" :[File class],
             @"user" : [User class],
             @"board": [Board class]};
}

+ (void)requestHuaBanList:(NSDictionary *)param Success:(RequestSuccessHandler)success failed:(RequestFailureHandler)failed{
    [RequestManager getRequestWithURLPath:@"http://api.huaban.com/popular" withParamer:param completionHandler:^(id responseObject, NSUInteger statusCode) {
        success(responseObject , statusCode);
    } RequestFailureHandler:^(NSError *error, NSUInteger statusCode) {
        failed(error , statusCode);
    }];
}
@end

@implementation File
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"bucket":@"bucket",
             @"key":@"key",
             @"realImageKey":@"realImageKey"};
}

- (NSString *)realImageKey{
    if (self.key != nil) {
        if (self.bucket != nil) {
            if ([self.bucket isEqualToString:@"hb-topic-img"]){
                return [NSString stringWithFormat:@"%@%@",baseTopic,self.key];
            }else if ([self.bucket isEqualToString:@"hbfile"]){
                return [NSString stringWithFormat:@"%@%@",baseFile,self.key];
            }else {
                return [NSString stringWithFormat:@"%@%@",baseImage,self.key];
            }
        } else {
            return [NSString stringWithFormat:@"%@%@",baseImage,self.key];
        }
    } else {
        return @"";
    }
}
@end

@implementation User
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{};
}

@end
@implementation Board
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{};
}

@end