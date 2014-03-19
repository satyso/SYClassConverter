//
//  TestClass.m
//  ClassConverter
//
//  Created by satyso on 14-3-5.
//  Copyright (c) 2014年 satyso. All rights reserved.
//

#import "TestClass.h"

@implementation TestClass
//@synthesize str;
//@synthesize uinteger;
//@synthesize doubleValue;
//@synthesize uc;

- (NSString*)description
{
    return [NSString stringWithFormat:@"str = %@, uinteger = %lu,doubleValue = %lf,uc = %c", self.str,(unsigned long)self.uinteger,self.doubleValue,self.uc];
}

- (void)uintegerTest:(NSUInteger)a
{
    _uinteger = a;
}

- (void)setDoubleValue:(double)d
{
    _doubleValue = d;
}

- (void)doubleValueTest:(double)doubleValue
{
    _doubleValue = doubleValue;
}

- (void)strTest:(NSString *)str
{
    _str = [str copy];
}
@end
