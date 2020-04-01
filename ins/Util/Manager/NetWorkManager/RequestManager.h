 

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^ProgressHandler)(CGFloat progress);
typedef void(^RequestFailureHandler)(NSError *error,NSUInteger statusCode);
typedef void(^RequestSuccessHandler)(id responseObject, NSUInteger statusCode);

@interface MKRequestTask : NSObject
@property(strong, nonatomic)id sessionTaskOrOperation;
-(void)cancel;
@end

@interface RequestManager : NSObject

#pragma mark --
#pragma mark --  POST
+ (MKRequestTask *) postRequestWithURLPath:(NSString *)requestPath withParamer:(NSDictionary *)paramer completionHandler:(RequestSuccessHandler)completionHandler RequestFailureHandler:(RequestFailureHandler)RequestFailureHandler;

#pragma mark --
#pragma mark --  GET
+ (MKRequestTask *) getRequestWithURLPath:(NSString *)requestPath withParamer:(NSDictionary *)paramer completionHandler:(RequestSuccessHandler)completionHandler RequestFailureHandler:(RequestFailureHandler)RequestFailureHandler;

#pragma mark --
#pragma mark --  DELETE
+ (MKRequestTask *) deleteRequestWithURLPath:(NSString *)requestPath withParamer:(NSDictionary *)paramer completionHandler:(RequestSuccessHandler)completionHandler RequestFailureHandler:(RequestFailureHandler)RequestFailureHandler;

#pragma mark --
#pragma mark --  UPLOAD
+ (MKRequestTask *) uploadFileRequestWithURLPath:(NSString *)requestPath withParamer:(NSDictionary *)paramer postData:(NSData *)postData postType:(NSInteger)postType completionHandler:(RequestSuccessHandler)completionHandler progressHandler:(ProgressHandler)progressHandler RequestFailureHandler:(RequestFailureHandler)RequestFailureHandler;

#pragma mark --
#pragma mark --  DOWNLOAD
+ (MKRequestTask *) downloadFileRquestWithFileUrl:(NSString *)fileUrl fileName:(NSString *)fileName fileCachePath:(NSString *)fileCachePath completionHandler:(RequestSuccessHandler) completionHandler progressHandle:(ProgressHandler)progressHandle RequestFailureHandler:(RequestFailureHandler)RequestFailureHandler;

@end
