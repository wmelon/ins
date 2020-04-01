 

#import <Foundation/Foundation.h>
extern NSString *const KBaseURL;  //服务器地址

#pragma mark -- 用户请求接口名称
// ver 1.0.0 add
extern NSString *const KURLStringSensationHotProduce; // 红人热门作品 GET
extern NSString *const KURLStringInternetSensation; //网络红人列表数据 GET
extern NSString *const KURLStringInternetSensationDetail; // 网络红人详情 GET
extern NSString *const KURLStringWeChatPublicNoList; //微信公众号列表 POST
extern NSString *const KURLStringVideoPlayList; //视频播放列表 GET
extern NSString *const KURLStringWeChatPublicNoArticlesList; // 微信公众号发过的文章 GET
extern NSString *const KURLStringWeChatPublicNoCategories; // 微信公众号所属类别 GET
extern NSString *const KURLStringWeChatPublicNoTags; // 微信公众号描述标签 GET
extern NSString *const KURLStringGetHotLiveList; /// 获取直播列表数据 GET



@interface URLManager : NSObject
+ (NSString *)requestURLGenetatedWithURL:(NSString *const) path;
@end
