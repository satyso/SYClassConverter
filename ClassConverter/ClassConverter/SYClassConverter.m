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
        
        const char * type = NULL;
        id object = [dic objectForKey:name];
        if ([object respondsToSelector:@selector(objCType)])
        {
            type = [object objCType];
        }
        else
        {
            type = "@";
        }
        
        switch (type[0]) {
            case _C_ID:
            case _C_CLASS:
#if __has_feature(objc_arc)
                propertyAttributeArray = @[@"nonamotic",@"strong"];
#else
                propertyAttributeArray = @[@"nonamotic",@"retain"];
#endif
                break;
            default:
                propertyAttributeArray = @[@"nonamotic",@"assign"];
                break;
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
            const char* readOnly = property_copyAttributeValue(property, "R");
            if (readOnly != NULL)
            {
                continue;
            }
            
            const char* setterName = property_copyAttributeValue(property, "S");
            SEL sel;
            if (setterName != NULL)
            {
                sel = NSSelectorFromString([NSString stringWithUTF8String:setterName]);
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
                    const char* type = property_copyAttributeValue(property, "T");
                    NSGetSizeAndAlignment(type, &bufferSize, NULL);
                    void* buffer = malloc(bufferSize);
                    
                    NSGetSizeAndAlignment([value objCType], &bufferSize, NULL);
                    void* buffer1 = (void*)malloc(bufferSize);
                    [value getValue:buffer1];
                    memcpy(buffer,buffer1,bufferSize);
                    [invocation setArgument:buffer atIndex:2];
                    [invocation retainArguments];
                    free(buffer);
                    free(buffer1);
                    
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
