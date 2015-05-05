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
        NSArray* array = @[@"frist",@"second"];
        NSDictionary* dic = @{@"str":@"dicStr",@"uinteger":@1,@"doubleValue":@3.4,@"uc":c,@"strArray":array};
        
//        NSLog(@"classNotExist===========");
//        {
//            id classNotExist = [SYClassConverter constructObjectWithClassName:@"TestClassAAAAA" fromDictionary:dic];
//            display(classNotExist);
//        }
        
        NSLog(@"classExist===========");
        {
            id classExist = [SYClassConverter constructObjectWithClassName:@"TestClass" fromDictionary:dic];
            display(classExist);
        }
//
//        
//        NSLog(@"objectExist===========");
//        {
//            TestClass* objectExist = [TestClass new];
//            [SYClassConverter contructObject:objectExist withDictionary:dic];
//            display(objectExist);
//        }
    }
    return 0;
}

void display(id object)
{
    unsigned int numIvars = 0;
    Ivar * ivars = class_copyIvarList([object class], &numIvars);
    NSLog(@"class name = %s", class_getName([object class]));
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
    
    NSLog(@"property--------------");
    
    unsigned int num = 0;
    objc_property_t* propertyList = class_copyPropertyList([object class], &num);
    for (int i = 0; i < num; i++)
    {
        NSLog(@"property attributes = %s", property_getAttributes(propertyList[i]));
    }
}