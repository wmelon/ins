//
//  WeChatPublicNoModel.h
//  ins
//
//  Created by Sper on 16/7/5.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "BaseModel.h"

@interface WeChatPublicNoModel : BaseModel
@property (nonatomic,strong)NSString *kol_id;
@property (nonatomic,strong)NSString *biz_code;  //biz_code : "rmrbwx"
@property (nonatomic,strong)NSString *biz_name;  //biz_name : "人民日报"
@property (nonatomic,strong)NSURL *kol_avatar_url; //
@property (nonatomic,strong)NSURL *qrcode_url;
@property (nonatomic,strong)NSString *kol_info;
@property (nonatomic,strong)NSString *kol_name;
@property (nonatomic,strong)NSString *kol_relative;

@property (nonatomic,strong)NSArray *kol_body_parts;
@property (nonatomic,strong)NSArray *kol_brands;
@property (nonatomic,strong)NSArray *kol_category;
@property (nonatomic,strong)NSArray *kol_features;
@property (nonatomic,strong)NSArray *kol_industries;
@property (nonatomic,strong)NSArray *kol_keywords;
@property (nonatomic,strong)NSArray *kol_locations;
@property (nonatomic,strong)NSArray *kol_people_names;
@property (nonatomic,strong)NSArray *kol_product_models;

@property (nonatomic,strong)NSNumber *kol_sum_read_num_30;
@property (nonatomic,strong)NSNumber *like_read_rate_30;
@property (nonatomic,strong)NSNumber *kol_avg_read_num_30;
@property (nonatomic,strong)NSNumber *kol_influence_score;
@property (nonatomic,strong)NSNumber *kol_max_read_num_30;

/**
 *  请求微信公众账号
 *
 *  @param param
 *  @param success
 *  @param failed
 */
+ (void)requestWeChatPublicNoWithParam:(NSDictionary *)param success:(RequestSuccessHandler)success failed:(RequestFailureHandler)failed;
@end
