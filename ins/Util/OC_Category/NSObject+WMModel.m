//
//  NSObject+WMModel.m
//  ins
//
//  Created by Sper on 16/10/24.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "NSObject+WMModel.h"

typedef struct{
    void * modelSelf;
    void * modelClassInfo;
}WMModelContext;

@implementation WMClassPropertyInfo
- (instancetype)initWithPropertyInfo:(objc_property_t)property{
    if (self = [super init]){
        _property = property;
        
        const char *name = property_getName(property);
        
        if (name){
            _name = [NSString stringWithUTF8String:name];
        }
        
//        YYEncodingType type = 0;
        unsigned int attrCount = 0;
        objc_property_attribute_t *attributes =  property_copyAttributeList(property, &attrCount);
        for (int i = 0 ; i< attrCount ; i++){
            switch (attributes[i].name[0]) {
                case 'T':
                { // Type encoding
                    if (attributes[i].value) {
//                        _typeEncoding = [NSString stringWithUTF8String:attributes[i].value];
//                        type = YYEncodingGetType(attributes[i].value);
//                        if ((type & YYEncodingTypeMask) == YYEncodingTypeObject) {
                            size_t len = strlen(attributes[i].value);
                            if (len > 3) {
                                char name[len - 2];
                                name[len - 3] = '\0';
                                memcpy(name, attributes[i].value + 2, len - 3);
                                _cls = objc_getClass(name);
//                            }
                        }
                    }
                }
                    break;
                default:
                    break;
            }
        }
        
        
        
        
        if (_name.length) {
            if (!_getter) {
                _getter = NSSelectorFromString(_name);
            }
            if (!_setter) {
                _setter = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:", [_name substringToIndex:1].uppercaseString, [_name substringFromIndex:1]]);
            }
        }
    }
    return self;
}
@end

@implementation WMClassMethodInfo
- (instancetype)initWithMethodInfo:(Method)method{
    if (self = [super init]){
        _method = method;
        _sel = method_getName(method);
        _imp = method_getImplementation(method);
        const char * name = sel_getName(_sel);
        if(name){
            _name = [NSString stringWithUTF8String:name];
        }
        const char * typeEncoding = method_getTypeEncoding(method);
        if (typeEncoding){
            _typeEncoding = [NSString stringWithUTF8String:typeEncoding];
        }
        const char *returnTypeEncoding = method_copyReturnType(method);
        if (returnTypeEncoding){
            _returnTypeEncoding = [NSString stringWithUTF8String:returnTypeEncoding];
        }
    }
    return self;
}

@end

@implementation WMClassIvarInfo
- (instancetype)initWithIvarInfo:(Ivar)ivar{
    if (self = [super init]){
        _ivar = ivar;
        
        const char * name = ivar_getName(ivar);
        if (name){
            _name = [NSString stringWithUTF8String:name];
        }
        _offset = ivar_getOffset(ivar);
        const char *typeEncoding = ivar_getTypeEncoding(ivar);
        if (typeEncoding){
            _typeEncoding = [NSString stringWithUTF8String:typeEncoding];
        }
    }
    return self;
}

@end

@interface WMClassPropertyMeta : NSObject
@property (nonatomic, assign) Class cls;
@property (nonatomic, assign) Class genericCls;  /// 原始的类
@property (nonatomic, assign) Class superCls;
@property (nonatomic, assign) Class metaCls;
@property (nonatomic, assign) BOOL isMetaCls;
@property (nonatomic, assign) SEL setter;
@property (nonatomic, assign) SEL getter;
@end

@implementation WMClassPropertyMeta
+ (instancetype)metaWithClassInfo:(WMClassInfo *)classInfo propertyInfo:(WMClassPropertyInfo *)propertyInfo generic:(Class)generic {
    WMClassPropertyMeta * meta = [self new];
    
    meta->_setter = propertyInfo.setter;
    meta->_getter = propertyInfo.getter;
    
    meta->_cls = classInfo.cls;
    meta->_metaCls = classInfo.metaCls;
    meta->_superCls = classInfo.superCls;
    meta->_isMetaCls = classInfo.isMetaCls;
    meta->_genericCls = generic;
    
    return meta;
}
@end

@implementation WMClassInfo

+ (instancetype)classInfoWithClass:(Class)cls{
    if (!cls) return nil;
    WMClassInfo *classInfo = [[WMClassInfo alloc] initWithClassInfo:cls];
    return classInfo;
}
- (instancetype)initWithClassInfo:(Class)cls{
    if (!cls) return nil;
    if (self = [super init]){
        
        _cls = cls;
        _superCls = class_getSuperclass(cls);
        _isMetaCls = class_isMetaClass(cls);
        
        if (!_isMetaCls){
            _metaCls = objc_getMetaClass(class_getName(cls));
        }
        
        unsigned int methodCount = 0;
        _methodInfos = [NSMutableDictionary dictionary];
        Method *methods = class_copyMethodList(cls, &methodCount);
        for (int i = 0 ; i< methodCount ; i++){
            WMClassMethodInfo *info = [[WMClassMethodInfo alloc] initWithMethodInfo:methods[i]];
            _methodInfos[info.name] = info;
        }
        free(methods);
        
        _propertyInfos = [NSMutableDictionary dictionary];
        unsigned int propertyCount = 0;
        objc_property_t *propertys = class_copyPropertyList(cls, &propertyCount);
        for (int i = 0 ; i < propertyCount ; i ++){
            WMClassPropertyInfo * info = [[WMClassPropertyInfo alloc] initWithPropertyInfo:propertys[i]];
            _propertyInfos[info.name] = info;
        }
        free(propertys);
        
        unsigned int ivarCount = 0;
        _ivarInfos = [NSMutableDictionary dictionary];
        Ivar * ivars = class_copyIvarList(cls, &ivarCount);
        for (int i = 0 ; i < ivarCount ; i++){
            WMClassIvarInfo * info = [[WMClassIvarInfo alloc] initWithIvarInfo:ivars[i]];
            _ivarInfos[info.name] = info;
        }
        free(ivars);
    }
    return self;
}
@end

@interface WMModelMeta : NSObject
@property (nonatomic, strong , readonly) NSMutableDictionary * propertyMetas;
@end
@implementation WMModelMeta
- (instancetype)initWithMetaClass:(Class)cls{
    WMClassInfo *classInfo = [WMClassInfo classInfoWithClass:cls];
    if (!classInfo) return nil;
    if (self = [super init]){
        _propertyMetas = [NSMutableDictionary dictionary];
        
        // Get container property's generic class
        NSDictionary *genericMapper = nil;
        if ([cls respondsToSelector:@selector(modelContainerPropertyGenericClass)]) {
            genericMapper = [cls modelContainerPropertyGenericClass];
            if (genericMapper) {
                NSMutableDictionary *tmp = [NSMutableDictionary new];
                [genericMapper enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                    if (![key isKindOfClass:[NSString class]]) return;
                    Class meta = object_getClass(obj);
                    if (!meta) return;
                    if (class_isMetaClass(meta)) {
                        tmp[key] = obj;
                    } else if ([obj isKindOfClass:[NSString class]]) {
                        Class cls = NSClassFromString(obj);
                        if (cls) {
                            tmp[key] = cls;
                        }
                    }
                }];
                genericMapper = tmp;
            }
        }
        
        for (WMClassPropertyInfo * propertyInfo in classInfo.propertyInfos.allValues){
            WMClassPropertyMeta * meta = [WMClassPropertyMeta metaWithClassInfo:classInfo propertyInfo:propertyInfo generic:genericMapper[propertyInfo.name]];
            _propertyMetas[propertyInfo.name] = meta;
        }
        
//        NSMutableDictionary * mapper = [NSMutableDictionary dictionary];
        NSDictionary * propertyMapper = nil;
        if  ([cls respondsToSelector:@selector(modelCustomPropertyMapper)]){
            propertyMapper = [cls modelCustomPropertyMapper];
            [propertyMapper enumerateKeysAndObjectsUsingBlock:^(NSString *propertyName, NSString *mappedToKey, BOOL * _Nonnull stop) {
                WMClassPropertyMeta * propertyMeta = _propertyMetas[propertyName];
                if (!propertyMeta) return;
                [_propertyMetas removeObjectForKey:propertyName];
                
//                mapper[mappedToKey] = propertyMeta;
                _propertyMetas[mappedToKey] = propertyMeta;
            }];
        }
    }
    return self;
}
@end


@implementation NSObject (WMModel)

+ (instancetype)wm_modelWithDictionary:(NSDictionary *)dict{
    if (!dict || dict == (id)kCFNull) return nil;
    if (![dict isKindOfClass:[NSDictionary class]]) return nil;
    
    
    NSObject *one = [[self class] new];
    if ([one wm_modelSetWithDictionary:dict]) return one;
    return nil;
}
- (BOOL)wm_modelSetWithDictionary:(NSDictionary *)dict{
    if (!dict || dict == (id)kCFNull) return nil;
    if (![dict isKindOfClass:[NSDictionary class]]) return nil;
    
    WMModelContext context = {0};
    context.modelSelf = (__bridge void *)(self);
    
    WMModelMeta *modelMeta = [[WMModelMeta alloc] initWithMetaClass:[self class]];
    context.modelClassInfo = (__bridge void *)modelMeta;
    
    CFDictionaryApplyFunction((CFDictionaryRef)dict, ModelSetWithDictionaryFunction, &context);
    
    return YES;
}

static void ModelSetWithDictionaryFunction(const void *_key, const void *_value, void *_context) {
    NSString * key = (__bridge NSString *)_key;
    id value = (__bridge id)_value;
    
    WMModelContext *context = _context;
    id modelSelf = (__bridge id)(context->modelSelf);
    
    WMModelMeta *modelMeta = (__bridge WMModelMeta *)(context->modelClassInfo);
    WMClassPropertyMeta *meta = modelMeta.propertyMetas[key];
    
    //    while (info) {
    if (meta.setter) {
        ModelSetValueForProperty(modelSelf, meta, value);
    }
    //        propertyMeta = propertyMeta->_next;
    //    };
}
static void ModelSetValueForProperty(__unsafe_unretained id model,
                                     __unsafe_unretained WMClassPropertyMeta *meta,
                                     __unsafe_unretained id value) {
    BOOL isNull = (value == (id)kCFNull);
    if (isNull){
        ((void (*)(id, SEL, id))(void *) objc_msgSend)(model, meta.setter, (id)nil);
    }else if ([value isKindOfClass:[NSDictionary class]]){
        
        Class cls = meta.cls;
        NSObject * one = [cls new];
        [one wm_modelSetWithDictionary:value];
        
        ((void (*)(id, SEL, id))(void *) objc_msgSend)(model, meta.setter, one);
    }else if ([value isKindOfClass:[NSString class]]){
        ((void (*)(id, SEL, id))(void *) objc_msgSend)(model, meta.setter, value);
    }else if ([value isKindOfClass:[NSArray class]]){
        
        NSMutableArray *objectArr = [NSMutableArray new];
        for (id one in value) {
            if ([one isKindOfClass:[NSDictionary class]]) {
                Class cls;
                if (meta.genericCls){
                    cls = meta.genericCls;
                }else {
                    cls = meta.cls;
                }
                NSObject *newOne = [cls new];
                [newOne wm_modelSetWithDictionary:one];
                if (newOne) [objectArr addObject:newOne];
            } else{
                [objectArr addObject:one];
            }
        }
        ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta.setter, objectArr);
    }
}

@end
