//
//  SYClassConverter.m
//  ClassConverter
//
//  Created by satyso on 14-2-24.
//  Copyright (c) 2014年 satyso. All rights reserved.
//

#import <objc/runtime.h>

#import "SYClassConverter.h"

#import "Runtime_helper.h"

@interface SYClassConverter ()

NSString *setter_from_key(NSString *key);

@end

@implementation SYClassConverter

+(id) constructObjectWithClassName:(NSString*)className fromDictionary:(NSDictionary*)dic
{
    Class c = NSClassFromString(className);
    if (c == nil)
    {
         c = [SYClassConverter createClassWithName:className superClass:[NSObject class] fromDictionary:dic];
    }
    
    id object = class_createInstance_arc(c);
    return [SYClassConverter contructObject:object withDictionary:(NSDictionary*)dic];
}

+(Class) createClassWithName:(NSString*)className superClass:(Class)c fromDictionary:(NSDictionary*)dic
{
    NSAssert(NSClassFromString(className) == nil, @"class is exist");
    
    if (c == nil)
    {
        c = [NSObject class];
    }
    
    NSAssert(NSStringFromClass(c) != nil, @"super class error");
    
    Class targetClass = objc_allocateClassPair(c, [className UTF8String], 0);
    
    NSArray* propertyAttributeArray = nil;//support dynamic nonatomic getter setter strong weak readonly assign retain
    
    NSArray* names = [dic allKeys];
    for (NSString* name in names)
    {
        id object = [dic objectForKey:name];
        if ([object respondsToSelector:@selector(objCType)])
        {
            propertyAttributeArray = @[@"nonatomic",@"assign"];
        }
        else
        {
            if ([object isKindOfClass:[NSString class]])
            {
                propertyAttributeArray = @[@"nonatomic",@"copy"];
            }
            else
            {
#if __has_feature(objc_arc)
                propertyAttributeArray = @[@"nonatomic",@"strong"];
#else
                propertyAttributeArray = @[@"nonatomic",@"retain"];
#endif
            }
        }
        class_addProperty_ex(targetClass, name, [dic objectForKey:name], propertyAttributeArray);
    }
    objc_registerClassPair(targetClass);
    
    return targetClass;
}

+(id) contructObject:(id)object withDictionary:(NSDictionary*)dic
{
    if (object == nil)
    {
        return nil;
    }

    unsigned int numProperties = 0;
    
    objc_property_t* properties = class_copyPropertyList([object class], &numProperties);
    
    for (int i = 0; i < numProperties; i++)
    {
        objc_property_t property = properties[i];
        NSString* name = [NSString stringWithUTF8String:property_getName(property)];
        NSValue* value = [dic objectForKey:name];
        if (value != nil)
        {
            char* readOnly = property_copyAttributeValue(property, "R");
            if (readOnly != NULL)
            {
                free(readOnly);
                continue;
            }
            
            char* setterName = property_copyAttributeValue(property, "S");
            if (setterName != NULL)
            {
                SEL sel = NSSelectorFromString([NSString stringWithUTF8String:setterName]);
                free(setterName);
                
                Method method = class_getInstanceMethod([object class], sel);
                if (method == NULL)
                {
                    continue;
                }
                
                const char* encoding = method_getTypeEncoding(method);
                NSMethodSignature *methodSignature = [NSMethodSignature signatureWithObjCTypes:encoding];
                
                NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
                [invocation setTarget:object];
                [invocation setSelector:sel];
                if ([value respondsToSelector:@selector(objCType)])
                {
                    NSUInteger bufferSize = 0;
                    char* type = property_copyAttributeValue(property, "T");
                    NSGetSizeAndAlignment(type, &bufferSize, NULL);
                    free(type);
                    
                    void* buffer = calloc(1,bufferSize);
                    [value getValue:buffer];
                    [invocation setArgument:buffer atIndex:2];
                    [invocation retainArguments];
                    free(buffer);
                }
                else
                {
                    [invocation setArgument:&value atIndex:2];
                    [invocation retainArguments];
                }
                [invocation invoke];
            }
            else
            {//default name set#propertyName#
                [object setValue:value forKey:name];
            }
        }
    }
    
    free(properties);
    return object;
}

NSString *setter_from_key(NSString *key)
{
    NSString *setter = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[key substringToIndex:1] uppercaseString]];
    setter = [NSString stringWithFormat:@"set%@:", setter];
    return setter;
}

@end
