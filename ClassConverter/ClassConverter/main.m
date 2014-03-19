//
//  main.m
//  ClassConverter
//
//  Created by satyso on 14-2-24.
//  Copyright (c) 2014年 satyso. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TestClass.h"

#import "SYClassConverter.h"

#import <objc/runtime.h>

void display(id object);

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // insert code here...
        NSNumber* c = [NSNumber numberWithChar:'q'];
        NSDictionary* dic = @{@"str":@"dicStr",@"uinteger":@1,@"doubleValue":@3.4,@"uc":c};
        id test = [SYClassConverter constructObjectWithClassName:@"TestClassA" fromDictionary:dic];
//        id test = [SYClassConverter constructObjectWithClassName:@"TestClass" fromDictionary:dic];
        
//        TestClass* test = [TestClass new];
        [SYClassConverter contructObject:test withDictionary:dic];
        
        display(test);
    }
    return 0;
}

void display(id object)
{
    unsigned int numIvars = 0;
    Ivar * ivars = class_copyIvarList([object class], &numIvars);
    
    for(int i = 0; i < numIvars; i++)
    {
        Ivar thisIvar = ivars[i];
        NSString* name = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
        id value = [object valueForKey:name];
        if ([value respondsToSelector:@selector(objCType)])
        {
            NSLog(@"%@ = %@, type = %s", name, value, [value objCType]);
        }
        else
        {
            NSLog(@"%@ = %@, type = %s", name, value, class_getName([value class]));
        }
    }
}