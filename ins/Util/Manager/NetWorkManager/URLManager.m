

#import "URLManager.h"

/********************************上线前需要修改地址**********************************/

#if DEBUG
NSString *const KBaseURL                     = @"";

#else
NSString *const KBaseURL                     = @"";
#endif

/********************************上线前需要修改地址**********************************/


#pragma mark -- 用户请求接口名称
NSString *const KURLStringSensationHotProduce = @"http://www.uniny.com/app/hot/v1/hot/gethotlist"; // 红人热门作品 GET
NSString *const KURLStringInternetSensation = @"http://www.uniny.com/app/user/v7/user/index"; //网络红人列表数据 GET
NSString *const KURLStringInternetSensationDetail = @"http://www.uniny.com/app/user/v11/user/gethotprofile"; // 网络红人详情 GET
NSString *const KURLStringWeChatPublicNoList = @"http://139.196.240.227:5000/search/v1.1/wechat"; //微信公众号列表 POST
NSString *const KURLStringVideoPlayList = @"http://c.m.163.com/nc/video/home/0-10.html"; //视频播放列表 GET
NSString *const KURLStringWeChatPublicNoArticlesList = @"http://139.196.240.227:5000/search/v1.1/wechat/articles"; // 微信公众号发过的文章 GET
NSString *const KURLStringWeChatPublicNoCategories = @"http://139.196.240.227:5000/search/v1.1/wechat/categories"; // 微信公众号所属类别 GET
NSString *const KURLStringWeChatPublicNoTags = @"http://139.196.240.227:5000/search/v1.1/wechat/tags"; // 微信公众号描述标签 GET
NSString *const KURLStringGetHotLiveList = @"http://live.9158.com/Fans/GetHotLive"; /// 获取直播列表数据 GET



@implementation URLManager

+ (NSString *)requestURLGenetatedWithURL:(NSString *const) path
{
    return [KBaseURL stringByAppendingString:path];
}

@end
