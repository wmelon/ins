//
//  NSObject+WMModel.h
//  ins
//
//  Created by Sper on 16/10/24.
//  Copyright © 2016年 WM. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WMModel;

@protocol WMModel <NSObject>
@optional
+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass;
+ (NSDictionary<NSString *, id> *)modelCustomPropertyMapper;
@end

@interface NSObject (WMModel)
+ (instancetype)wm_modelWithDictionary:(NSDictionary *)dict;
@end

@interface WMClassInfo : NSObject
@property (nonatomic, strong , readonly) NSMutableDictionary *propertyInfos;
@property (nonatomic, strong , readonly) NSMutableDictionary *methodInfos;
@property (nonatomic, strong , readonly) NSMutableDictionary *ivarInfos;
@property (nonatomic, assign , readonly) Class cls;
@property (nonatomic, assign , readonly) Class superCls;
@property (nonatomic, assign , readonly) Class metaCls;
@property (nonatomic, assign , readonly) BOOL isMetaCls;

@end



@interface WMClassMethodInfo : NSObject
@property (nonatomic , assign , readonly)Method method;
@property (nonatomic, strong, readonly) NSString *name;                 ///< method name
@property (nonatomic , assign ,readonly)SEL sel;
@property (nonatomic , assign , readonly)IMP imp;
@property (nonatomic , assign , readonly)NSString *typeEncoding;
@property (nonatomic , assign , readonly)NSString *returnTypeEncoding;
@end


@interface WMClassPropertyInfo : NSObject
@property (nonatomic , assign ,readonly)SEL setter;
@property (nonatomic , assign , readonly)SEL getter; 
@property (nonatomic , assign ,readonly)objc_property_t property;
@property (nonatomic, strong, readonly) NSString *name;                 ///< Property name
@property (nonatomic , assign , readonly)Class cls;
//@property (nonatomic, assign, readonly) YYEncodingType type;      ///< property's type
@property (nonatomic, strong, readonly) NSString *typeEncoding;   ///< property's encoding value
@end

@interface WMClassIvarInfo : NSObject
@property (nonatomic, strong, readonly) NSString *name;                 ///< Ivar name
@property (nonatomic , assign , readonly)Ivar ivar;
@property (nonatomic, assign, readonly) ptrdiff_t offset;       ///< Ivar's offset
@property (nonatomic, strong, readonly) NSString *typeEncoding; ///< Ivar's type encoding
//@property (nonatomic, assign, readonly) YYEncodingType type;    ///< Ivar's type
@end
