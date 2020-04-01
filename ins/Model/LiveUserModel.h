//
//  LiveUserModel.h
//  ins
//
//  Created by Sper on 16/11/14.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "BaseModel.h"

@interface LiveUserModel : BaseModel
@property (nonatomic , strong)NSString * gps;  /// 定位城市
@property (nonatomic , strong)NSString * flv; /// 视频文件
@property (nonatomic , strong)NSString * userId; /// 用户id WeiXin18802618
@property (nonatomic , strong)NSString * myname; /// 用户名称
@property (nonatomic , strong)NSString * signatures; /// 描述文案
@property (nonatomic , strong)NSString * smallpic; /// 小图片
@property (nonatomic , strong)NSString * bigpic; /// 大图
@property (nonatomic , strong)NSString * familyName; ///房间名称

@property (nonatomic , strong)NSNumber * allnum;
@property (nonatomic , strong)NSNumber * roomid;
@property (nonatomic , strong)NSNumber * serverid;
@property (nonatomic , strong)NSNumber * starlevel;
@property (nonatomic , strong)NSNumber * isSign;
@property (nonatomic , strong)NSNumber * nation;
@property (nonatomic , strong)NSNumber * useridx;


/// 获取直播用户列表
+ (void)requestLiveListParam:(NSDictionary *)param
                     Success:(RequestSuccessHandler)success
                      failed:(RequestFailureHandler)failed;

@end
