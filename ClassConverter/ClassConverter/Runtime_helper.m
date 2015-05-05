//
//  Runtime_helper.m
//  ClassConverter
//
//  Created by satyso on 14-2-25.
//  Copyright (c) 2014年 satyso. All rights reserved.
//

#include <stdio.h>
#include "Runtime_helper.h"

id const class_createInstance_arc(Class const class)
{
    id instance = class_createInstance(class, 0);
    return instance;
}

Ivar setInstanceVariable_arc(id obj, const char *name, void *value)
{
    return object_setInstanceVariable(obj, name, value);
}
//http://svn.gna.org/svn/gnustep/libs/libobjc2/trunk/properties.m
BOOL class_addProperty_ex(Class c, NSString* name, id value, NSArray* propertyAttributeArray)
{
    if ([propertyAttributeArray count] > 5)
    {
        return NO;
    }
    
    objc_property_attribute_t* array = malloc(sizeof(objc_property_attribute_t) * 7);//最多7个，name type dynamic nonatomic gett sett strong
    const char* type = NULL;
    if ([value respondsToSelector:@selector(objCType)])
    {
        type = [value objCType];
    }
    else
    {
        if ([value isKindOfClass:[NSString class]])
        {
            type = "@\"NSString\"";
        }
        else
        {
            type = "@";
            const char* className = class_getName([value class]);
            if (strlen(className) > 35)
            {
                NSLog(@"class name too long");
                return NO;
            }
        }
    }
    
    NSUInteger textPosSize, textPosAlign;
    NSGetSizeAndAlignment(type, &textPosSize, &textPosAlign);
    class_addIvar(c, [name UTF8String], textPosSize, textPosAlign, type);
    
    array[0] = (objc_property_attribute_t){ "T", type };
    array[1] = (objc_property_attribute_t){ "V", [name UTF8String] };
    
    int count = 2;
    for (int i = 0; i < [propertyAttributeArray count]; i++)
    {
        NSString* attribute = [propertyAttributeArray objectAtIndex:i];
        if ([attribute compare:@"assign"] == NSOrderedSame)
        {
            
        }
        else if ([attribute compare:@"retain"] == NSOrderedSame)
        {
            array[count++] = (objc_property_attribute_t){ "&", "" };
        }
        else if ([attribute compare:@"copy"] == NSOrderedSame)
        {
            array[count++] = (objc_property_attribute_t){ "C", "" };
        }
        else if ([attribute compare:@"dynamic"] == NSOrderedSame)
        {
            array[count++] = (objc_property_attribute_t){ "D", "" };
        }
        else if ([attribute compare:@"readonly"] == NSOrderedSame)
        {
            array[count++] = (objc_property_attribute_t){ "R", "" };
        }
        else if ([attribute compare:@"weak"] == NSOrderedSame)
        {
            array[count++] = (objc_property_attribute_t){ "W", "" };
        }
        else if ([attribute compare:@"strong"] == NSOrderedSame)
        {
            array[count++] = (objc_property_attribute_t){ "&", "" };
        }
        else if ([attribute compare:@"nonatomic"] == NSOrderedSame)
        {
            array[count++] = (objc_property_attribute_t){ "N", "" };
        }
        else if ([attribute hasPrefix:@"setter"])
        {
            if (attribute.length > @"setter=:".length)
            {
                const char* setter = [[attribute substringFromIndex:@"setter=".length] UTF8String];
                array[count++] = (objc_property_attribute_t){ "S", setter };
            }
        }
        else if ([attribute hasPrefix:@"getter"])
        {
            if (attribute.length > @"getter=".length)
            {
                const char* getter = [[attribute substringFromIndex:@"getter=".length] UTF8String];
                array[count++] = (objc_property_attribute_t){ "G", getter };
            }
        }
    }

    class_addProperty(c, [name UTF8String], array, count);
    free(array);
    return YES;
}