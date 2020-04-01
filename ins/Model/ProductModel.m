//
//  ProductModel.m
//  ins
//
//  Created by Sper on 16/7/31.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"imgs" : [ImageModel class]};
}

+ (void)requestSensationHotProductWithParam:(NSDictionary *)param success:(RequestSuccessHandler)success failed:(RequestFailureHandler)failed{
    [RequestManager getRequestWithURLPath:KURLStringSensationHotProduce withParamer:param completionHandler:^(id responseObject, NSUInteger statusCode) {
        success(responseObject , statusCode);
    } RequestFailureHandler:^(NSError *error, NSUInteger statusCode) {
        failed(error , statusCode);
    }];
}
@end

@implementation ImageModel

@end
