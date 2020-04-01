//
//  SensationModel.h
//  ins
//
//  Created by Sper on 16/7/31.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "BaseModel.h"

@interface SensationModel : BaseModel
@property (nonatomic , strong)NSString *uname;  // 名称
@property (nonatomic , strong)NSString *avatar;  // 图片地址
@property (nonatomic , strong)NSNumber *identity_int;
@property (nonatomic , strong)NSString *link;  // urlScheme 跳转地址
@property (nonatomic , assign)BOOL isInDiscount;  //
@property (nonatomic , assign)BOOL isJourney; //

// 请求网络红人列表数据
+ (void)requestSensationListWithParam:(NSDictionary *)param success:(RequestSuccessHandler)success failed:(RequestFailureHandler)failed;

// 请求网络红人详情信息
+ (void)requestSensationDetailWithParam:(NSDictionary *)param success:(RequestSuccessHandler)success failed:(RequestFailureHandler)failed;
@end
