 

#import <Foundation/Foundation.h>
#import "YYModel.h"

/**
 *  该model是所有model的基类，该类继承自一个三方类库的一个model，并实现了一个协议，供解析数据之用，具体使用请查看具体文档
 */
@interface BaseModel : NSObject
/**
 *  YYModel 返回属性的映射关系，一样的不用写  eg:  "Id":"id"
 *
 *  @return 解析完成的字典
 */
+ (NSDictionary *)modelCustomPropertyMapper;
/**
 *  返回属性中模型的映射关系， eg:  "item":[ItemModel class]
 *
 *  @return 解析完成的字典
 */
+ (NSDictionary *)modelContainerPropertyGenericClass;

/**
 *  字典返回模型
 *
 *  @param dict  字典数据
 *
 *  @return 模型数据
 */
+ (instancetype)pc_modelWithDictionary:(NSDictionary *)dict;
/**
 *  字典解析成数组
 *
 *  @param array json数组数据
 *
 *  @return 模型数组
 */
+ (NSArray *)pc_modelListWithArray:(NSArray *)array;

@end
