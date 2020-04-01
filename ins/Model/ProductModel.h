//
//  ProductModel.h
//  ins
//
//  Created by Sper on 16/7/31.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "BaseModel.h"
@class ImageModel;
@interface ProductModel : BaseModel
@property (nonatomic , strong)NSString *userId; // 用户id
@property (nonatomic , strong)NSString *uname; // 用户名
@property (nonatomic , strong)NSString *avatar;  // 用户图片
@property (nonatomic , strong)NSString *avatarLink; //urlScheme跳转
@property (nonatomic , strong)NSString *content;  // 内容
@property (nonatomic , strong)NSString *link;  // urlScheme跳转详情
@property (nonatomic , strong)NSNumber *created;
@property (nonatomic , strong)NSNumber *visitors;
@property (nonatomic , strong)NSNumber *like;
@property (nonatomic , assign)BOOL isLiked;
@property (nonatomic , strong)NSArray * imgs;

+ (void)requestSensationHotProductWithParam:(NSDictionary *)param success:(RequestSuccessHandler)success failed:(RequestFailureHandler)failed;
@end

@interface ImageModel : BaseModel
@property (nonatomic , strong)NSNumber *type;
@property (nonatomic , strong)NSString *img;
@property (nonatomic , strong)NSString *videoId;
@property (nonatomic , strong)NSNumber *w;  // 图片宽
@property (nonatomic , strong)NSNumber *h;  // 图片高
@end