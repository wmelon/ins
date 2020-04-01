//
//  NSDictionary+NilSafe.m
//  NSDictionary-NilSafe
//
//  Created by Allen Hsu on 6/22/16.
//  Copyright © 2016 Glow Inc. All rights reserved.
//

#import <objc/runtime.h>
#import "NSDictionary+NilSafe.h"


@implementation NSDictionary (NilSafe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        WMSwizzleMethod(self, @selector(initWithObjects:forKeys:count:), @selector(gl_initWithObjects:forKeys:count:));
        
        WMSwizzleMethod(object_getClass(self), @selector(dictionaryWithObjects:forKeys:count:), @selector(gl_dictionaryWithObjects:forKeys:count:));
        
//        NSLog(@"self %@ %p" , self , self);
//        NSLog(@"self class %@  %p" , [self class],[self class]);
//        NSLog(@"super %@  %p" , [super class],[super class]);
//        NSLog(@"class_getSuperclass %@  %p" , class_getSuperclass(self),class_getSuperclass(self));
//        NSLog(@"object_getClass %@ %p" , object_getClass(self) ,object_getClass(self));
    });
}

+ (instancetype)gl_dictionaryWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key || !obj || obj == (id)kCFNull) {
            continue;
        }
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self gl_dictionaryWithObjects:safeObjects forKeys:safeKeys count:j];
}

- (instancetype)gl_initWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key || !obj || obj == (id)kCFNull) {
            continue;
        }
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self gl_initWithObjects:safeObjects forKeys:safeKeys count:j];
}

@end

@implementation NSMutableDictionary (NilSafe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = NSClassFromString(@"__NSDictionaryM");
        WMSwizzleMethod(class, @selector(setObject:forKey:), @selector(gl_setObject:forKey:));
        WMSwizzleMethod(class, @selector(setObject:forKeyedSubscript:), @selector(gl_setObject:forKeyedSubscript:));
    });
}

- (void)gl_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (!aKey || !anObject || anObject == (id)kCFNull) {
        return;
    }
    [self gl_setObject:anObject forKey:aKey];
}

- (void)gl_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    if (!key || !obj || obj == (id)kCFNull) {
        return;
    }
    [self gl_setObject:obj forKeyedSubscript:key];
}

@end

@implementation NSNull (NilSafe)


+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        WMSwizzleMethod(self, @selector(methodSignatureForSelector:), @selector(gl_methodSignatureForSelector:));
        WMSwizzleMethod(self, @selector(forwardInvocation:), @selector(gl_forwardInvocation:));
    });
}

- (NSMethodSignature *)gl_methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sig = [self gl_methodSignatureForSelector:aSelector];
    if (sig) {
        return sig;
    }
    return [NSMethodSignature signatureWithObjCTypes:@encode(void)];
}

- (void)gl_forwardInvocation:(NSInvocation *)anInvocation {
    NSUInteger returnLength = [[anInvocation methodSignature] methodReturnLength];
    if (!returnLength) {
        // nothing to do
        return;
    }

    // set return value to all zero bits
    char buffer[returnLength];
    memset(buffer, 0, returnLength);

    [anInvocation setReturnValue:buffer];
}

@end
