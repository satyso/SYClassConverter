//
//  NSDictionary+Util.m
//  ClassConverter
//
//  Created by satyso on 14-2-25.
//  Copyright (c) 2014年 satyso. All rights reserved.
//

#import "NSDictionary+Util.h"

@implementation NSDictionary (Util)

-(id) objectForKey:(id)key defaultValue:(id)value
{
    id tmp = [self objectForKey:key];
    if (tmp == nil)
    {
        tmp = value;
    }
    return tmp;
}

-(NSString*) stringForKey:(id)key defaultValue:(NSString*)value
{
    id tmp = [self objectForKey:key];
    if ([tmp isKindOfClass:[NSString class]])
    {
        return tmp;
    }
    else
    {
        return value;
    }
}

-(char) charForKey:(id)key defaultValue:(char)value
{
    NSNumber* tmp = [self objectForKey:key];
    if (strcmp([tmp objCType], @encode(char)) != 0)
    {
        return value;
    }
    else
    {
        return [tmp charValue];
    }
}

-(unsigned char) unsignedCharForKey:(id)key defaultValue:(unsigned char)value
{
    NSNumber* tmp = [self objectForKey:key];
    if (strcmp([tmp objCType], @encode(unsigned char)) != 0)
    {
        return value;
    }
    else
    {
        return [tmp unsignedCharValue];
    }
}

-(short) shortForKey:(id)key defaultValue:(short)value
{
    NSNumber* tmp = [self objectForKey:key];
    if (strcmp([tmp objCType], @encode(short)) != 0)
    {
        return value;
    }
    else
    {
        return [tmp charValue];
    }
}

-(unsigned short) unsignedShortForKey:(id)key defaultValue:(unsigned short)value
{
    NSNumber* tmp = [self objectForKey:key];
    if (strcmp([tmp objCType], @encode(unsigned short)) != 0)
    {
        return value;
    }
    else
    {
        return [tmp unsignedShortValue];
    }
}

-(int) intForKey:(id)key defaultValue:(int)value
{
    NSNumber* tmp = [self objectForKey:key];
    if (strcmp([tmp objCType], @encode(int)) != 0)
    {
        return value;
    }
    else
    {
        return [tmp intValue];
    }
}

-(unsigned int) unsignedIntForKey:(id)key defaultValue:(unsigned int)value
{
    NSNumber* tmp = [self objectForKey:key];
    if (strcmp([tmp objCType], @encode(unsigned int)) != 0)
    {
        return value;
    }
    else
    {
        return [tmp unsignedIntValue];
    }
}

-(long) longForKey:(id)key defaultValue:(long)value
{
    NSNumber* tmp = [self objectForKey:key];
    if (strcmp([tmp objCType], @encode(long)) != 0)
    {
        return value;
    }
    else
    {
        return [tmp longValue];
    }
}

-(unsigned long) unsignedLogForKey:(id)key defaultValue:(unsigned long)value
{
    NSNumber* tmp = [self objectForKey:key];
    if (strcmp([tmp objCType], @encode(unsigned long)) != 0)
    {
        return value;
    }
    else
    {
        return [tmp unsignedLongValue];
    }
}

-(long long) longLongForKey:(id)key defaultValue:(long long)value
{
    NSNumber* tmp = [self objectForKey:key];
    if (strcmp([tmp objCType], @encode(long long)) != 0)
    {
        return value;
    }
    else
    {
        return [tmp longLongValue];
    }
}

-(unsigned long long) unsignedLongLongForKey:(id)key defaultValue:(unsigned long long)value
{
    NSNumber* tmp = [self objectForKey:key];
    if (strcmp([tmp objCType], @encode(unsigned long long)) != 0)
    {
        return value;
    }
    else
    {
        return [tmp unsignedLongLongValue];
    }
}

-(float) floatForKey:(id)key defaultValue:(float)value
{
    NSNumber* tmp = [self objectForKey:key];
    if (strcmp([tmp objCType], @encode(float)) != 0)
    {
        return value;
    }
    else
    {
        return [tmp floatValue];
    }
}

-(double) doubleForKey:(id)key defaultValue:(double)value
{
    NSNumber* tmp = [self objectForKey:key];
    if (strcmp([tmp objCType], @encode(double)) != 0)
    {
        return value;
    }
    else
    {
        return [tmp doubleValue];
    }
}

-(BOOL) boolForKey:(id)key defaultValue:(BOOL)value
{
    NSNumber* tmp = [self objectForKey:key];
    if (strcmp([tmp objCType], @encode(BOOL)) != 0)
    {
        return value;
    }
    else
    {
        return [tmp boolValue];
    }
}

-(NSInteger) integerForKey:(id)key defaultValue:(NSInteger)value
{
    NSNumber* tmp = [self objectForKey:key];
    if (strcmp([tmp objCType], @encode(NSInteger)) != 0)
    {
        return value;
    }
    else
    {
        return [tmp integerValue];
    }
}

-(NSUInteger) unsignedIntegerForKey:(id)key defaultValue:(NSUInteger)value
{
    NSNumber* tmp = [self objectForKey:key];
    if (strcmp([tmp objCType], @encode(NSUInteger)) != 0)
    {
        return value;
    }
    else
    {
        return [tmp unsignedIntegerValue];
    }
}


-(NSValue*) valueForKey:(id)key type:(const char*)type
{
    id tmp = [self objectForKey:key];
    if ((tmp != nil) && strcmp([tmp objCType], type) != 0)
    {
        return nil;
    }
    else
    {
        return tmp;
    }
}

@end
