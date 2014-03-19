//
//  NSDictionary+Util.h
//  ClassConverter
//
//  Created by satyso on 14-2-25.
//  Copyright (c) 2014年 satyso. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Util)

-(id) objectForKey:(id)key defaultValue:(id)value;

-(NSString*) stringForKey:(id)key defaultValue:(NSString*)value;

-(char) charForKey:(id)key defaultValue:(char)value;

-(unsigned char) unsignedCharForKey:(id)key defaultValue:(unsigned char)value;

-(short) shortForKey:(id)key defaultValue:(short)value;

-(unsigned short) unsignedShortForKey:(id)key defaultValue:(unsigned short)value;

-(int) intForKey:(id)key defaultValue:(int)value;

-(unsigned int) unsignedIntForKey:(id)key defaultValue:(unsigned int)value;

-(long) longForKey:(id)key defaultValue:(long)value;

-(unsigned long) unsignedLogForKey:(id)key defaultValue:(unsigned long)value;

-(long long) longLongForKey:(id)key defaultValue:(long long)value;

-(unsigned long long) unsignedLongLongForKey:(id)key defaultValue:(unsigned long long)value;

-(float) floatForKey:(id)key defaultValue:(float)value;

-(double) doubleForKey:(id)key defaultValue:(double)value;

-(BOOL) boolForKey:(id)key defaultValue:(BOOL)value;

-(NSInteger) integerForKey:(id)key defaultValue:(NSInteger)value;

-(NSUInteger) unsignedIntegerForKey:(id)key defaultValue:(NSUInteger)value;

-(NSValue*) valueForKey:(id)key type:(const char*)type;

@end
