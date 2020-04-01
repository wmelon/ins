/**
 *  ReadMe:
 *  AboutLog:
 *  >>>>> 代表请求出的信息
 *  <<<<< 代表获取到的信息
 *
 */

#import "RequestManager.h"
#import "URLManager.h"

@implementation MKRequestTask

- (instancetype)initWithTaskOrOperation:(id)obj
{
    self = [super init];
    if (self) {
        _sessionTaskOrOperation = obj;
    }
    return self;
}

- (void)cancel
{
    if ([_sessionTaskOrOperation respondsToSelector:@selector(cancel)]) {
        [_sessionTaskOrOperation cancel];
    }
}
@end

@implementation RequestManager
+ (NSString *)appendInfoToString:(NSString *)string{
//    NSString *signature = [NSString stringWithFormat:@"%@%@",[AppDataManager defaultManager].userInfo[@"secretkey"], string].md5.md5;
//    NSString * platform = @"hairdresser_iOS";
//    if ([string rangeOfString:@"?"].length) {
//        return [NSString stringWithFormat:@"%@&token=%@&signature=%@&client=hairdresser&ver=%@&apptype=%@&sysVersion=iOS%.1lf&nid=%@&platform=%@", string, [AppDataManager defaultManager].token, signature, AppVersion, [NSString platform], iOSVersion,[Utility saveAndGetIDFA] ? [Utility saveAndGetIDFA] : @"",platform];
//    }
//    string = [NSString stringWithFormat:@"%@?token=%@&signature=%@&client=hairdresser&ver=%@&apptype=%@&sysVersion=iOS%.1lf&nid=%@&platform=%@", string, [AppDataManager defaultManager].token, signature, AppVersion, [NSString platform], iOSVersion,[Utility saveAndGetIDFA] ? [Utility saveAndGetIDFA] : @"",platform];
    return string;
}
+ (MKRequestTask *)postRequestWithURLPath:(NSString *)requestPath withParamer:(NSDictionary *)paramer completionHandler:(RequestSuccessHandler)completionHandler RequestFailureHandler:(RequestFailureHandler)RequestFailureHandler{
    
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    
    operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    requestPath = [RequestManager appendInfoToString:requestPath];
    
#ifdef DEBUG
    NSLog(@">>>>> path: %@ get parameters:\n%@",requestPath,paramer);
#endif
    AFHTTPRequestOperation *operation = [operationManager POST:[URLManager requestURLGenetatedWithURL:requestPath] parameters:paramer success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:kNilOptions error:nil];
        
#ifdef DEBUG
        NSLog(@"<<<<< path: %@ result dic:\n%@",requestPath,requestTmp);
#endif
        completionHandler(resultDic , operation.response.statusCode);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSDictionary *errorDic = error.userInfo;
        NSString *errorString = [[NSString alloc]initWithData:errorDic[@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding];
#ifdef DEBUG
        NSLog(@"请求失败---->%@",requestPath);
        NSLog(@"failure error description: %@",errorString);
#endif
        if(!errorString || !errorString.length){
            errorString = @"请求失败";
        }
        if(operation.response.statusCode == 401){
            errorString = @"请重新登录";
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NeedLoginNotification" object:nil];
        }
        if (502 == operation.response.statusCode) {
            errorString = @"请求失败，请重新尝试";
        }
        if (504 == operation.response.statusCode) {
            errorString = @"请求超时，请重新尝试";
        }
        NSError *e = [[NSError alloc]initWithDomain:errorString code:operation.response.statusCode userInfo:nil];
        RequestFailureHandler(e,operation.response.statusCode);
        
    }];
    
    return [[MKRequestTask alloc] initWithTaskOrOperation:operation];
}

+ (MKRequestTask *) getRequestWithURLPath:(NSString *)requestPath withParamer:(NSDictionary *)paramer completionHandler:(RequestSuccessHandler)completionHandler RequestFailureHandler:(RequestFailureHandler)RequestFailureHandler{
    
    
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    
    operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    requestPath = [RequestManager appendInfoToString:requestPath];
    
#ifdef DEBUG
    NSLog(@">>>>> path: %@ get parameters:\n%@",requestPath,paramer);
#endif
    
    AFHTTPRequestOperation * operation = [operationManager GET:[URLManager requestURLGenetatedWithURL:requestPath] parameters:paramer success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:kNilOptions error:nil];
        
#ifdef DEBUG
        NSLog(@"<<<path: %@ result dic:\n%@",requestPath,resultDic);
#endif
        completionHandler(resultDic,operation.response.statusCode);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSDictionary *errorDic = error.userInfo;
        NSString *errorString = [[NSString alloc]initWithData:errorDic[@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding];
#ifdef DEBUG
        NSLog(@"请求失败---->%@",requestPath);
        NSLog(@"failure error description: %@",errorString);
#endif
        if(!errorString || !errorString.length){
            errorString = @"请求失败";
        }
        if(operation.response.statusCode == 401){
            errorString = @"请重新登录";
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NeedLoginNotification" object:nil];
        }
        if (502 == operation.response.statusCode) {
            errorString = @"请求失败，请重新尝试";
        }
        if (504 == operation.response.statusCode) {
            errorString = @"请求超时，请重新尝试";
        }
        NSError *e = [[NSError alloc]initWithDomain:errorString code:operation.response.statusCode userInfo:nil];
        RequestFailureHandler(e,operation.response.statusCode);
    }];
    
    //#endif
    return [[MKRequestTask alloc]initWithTaskOrOperation:operation];
}

+ (MKRequestTask *) deleteRequestWithURLPath:(NSString *)requestPath withParamer:(NSDictionary *)paramer completionHandler:(RequestSuccessHandler)completionHandler RequestFailureHandler:(RequestFailureHandler)RequestFailureHandler{
    
    
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    
    operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    requestPath = [RequestManager appendInfoToString:requestPath];
    
#ifdef DEBUG
    NSLog(@">>>path: %@ post parameters:\n%@",requestPath,paramer);
#endif
    
    AFHTTPRequestOperation *operation = [operationManager DELETE:[URLManager requestURLGenetatedWithURL:requestPath] parameters:paramer success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:kNilOptions error:nil];
        
#ifdef DEBUG
        NSLog(@"<<<<< path: %@ result dic:\n%@",requestPath,resultDic);
#endif
        
        completionHandler(resultDic,operation.response.statusCode);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(operation.response.statusCode == 401){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NeedLoginNotification" object:nil];
        }
        
        NSDictionary *errorDic = error.userInfo;
        NSString *errorString = [[NSString alloc]initWithData:errorDic[@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding];
#ifdef DEBUG
        NSLog(@"请求失败---->%@",requestPath);
        NSLog(@"failure error description: %@",errorString);
#endif
        if(!errorString || !errorString.length){
            errorString = @"请求失败";
        }
        NSError *e = [[NSError alloc]initWithDomain:errorString code:operation.response.statusCode userInfo:nil];
        RequestFailureHandler(e,operation.response.statusCode);
        
    }];
    
    return [[MKRequestTask alloc]initWithTaskOrOperation:operation];
}

+ (MKRequestTask *) uploadFileRequestWithURLPath:(NSString *)requestPath withParamer:(NSDictionary *)paramer postData:(NSData *)postData postType:(NSInteger)postType completionHandler:(RequestSuccessHandler)completionHandler progressHandler:(ProgressHandler)progressHandler RequestFailureHandler:(RequestFailureHandler)RequestFailureHandler{
    
    NSString *fileName = @"file";
    if (postType == 0) {
        fileName = @"image.jpg";
    }else{
        fileName = @"video.mp4";
    }
    
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    
    NSString* url = [URLManager requestURLGenetatedWithURL:requestPath];
    NSMutableURLRequest *request =
    [serializer multipartFormRequestWithMethod:@"POST" URLString:url parameters:paramer constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:postData
                                    name:@"bin"
                                fileName:fileName
                                mimeType:@"application/octet-stream"];
    } error:nil];
    
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    AFHTTPRequestOperation *operation =
    [operationManager HTTPRequestOperationWithRequest:request
                                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                  
                                                  NSUInteger statusCode = operation.response.statusCode;
                                                  if (statusCode == 200) {
                                                      NSString *requestTmp = [NSString stringWithString:operation.responseString];
                                                      NSLog(@"<<<<< Success:\n%@\n string:\n%@", operation.response,requestTmp);
                                                      NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];

                                                      NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:kNilOptions error:nil];
                                                      
                                                      completionHandler(resultDic , operation.response.statusCode);
                                                      
                                                  }
                                              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                  if(operation.response.statusCode == 401){
                                                      [[NSNotificationCenter defaultCenter] postNotificationName:@"NeedLoginNotification" object:nil];
                                                  }
                                                  
                                                  NSDictionary *errorDic = error.userInfo;
                                                  NSString *errorString = [[NSString alloc]initWithData:errorDic[@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding];
#ifdef DEBUG
                                                  NSLog(@"请求失败---->%@",requestPath);
                                                  NSLog(@"failure error description: %@",errorString);
#endif
                                                  if(!errorString || !errorString.length){
                                                      errorString = @"请求失败";
                                                  }
                                                  NSError *e = [[NSError alloc]initWithDomain:errorString code:operation.response.statusCode userInfo:nil];
                                                  RequestFailureHandler(e,operation.response.statusCode);
                                              }];
    
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        CGFloat progress = (bytesWritten / (double)totalBytesWritten) * 100;
        if (progressHandler) {
            progressHandler(progress);
        }
    }];
    
    [operation start];
    
    return [[MKRequestTask alloc]initWithTaskOrOperation:operation];
    
}

+ (MKRequestTask *)downloadFileRquestWithFileUrl:(NSString *)fileUrl fileName:(NSString *)fileName fileCachePath:(NSString *)fileCachePath completionHandler:(RequestSuccessHandler)completionHandler progressHandle:(ProgressHandler)progressHandle RequestFailureHandler:(RequestFailureHandler)RequestFailureHandler{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:fileUrl]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:fileCachePath append:NO];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSUInteger statusCode = operation.response.statusCode;
        if (statusCode == 200) {
            completionHandler(fileCachePath,operation.response.statusCode);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSDictionary *errorDic = error.userInfo;
        NSString *errorString = [[NSString alloc]initWithData:errorDic[@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding];
        NSLog(@"failure error description: %@",errorString);
        RequestFailureHandler(error,operation.response.statusCode);
    }];
    
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        CGFloat progress = (bytesRead / totalBytesRead) * 100;
        progressHandle(progress);
    }];
    
    [operation start];
    
    return [[MKRequestTask alloc]initWithTaskOrOperation:operation];
}
@end
