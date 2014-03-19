//
//  SYClassConverter.h
//  ClassConverter
//
//  Created by satyso on 14-2-24.
//  Copyright (c) 2014年 satyso. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYClassConverter : NSObject

/**
 *  用dic填充该类字段。如果class不存在，则根据dic的结构，构建一个类，并用dic填充
 *  class instance init with dic. If the class does not exist, according to the structure of dic construct a class, and init with dic
 *
 *  @param className
 *  @param dic
 *
 *  @return
 */
+(id) constructObjectWithClassName:(NSString*)className fromDictionary:(NSDictionary*)dic;

+(Class) createClassWithName:(NSString*)className superClass:(Class)c fromDictionary:(NSDictionary*)dic;

+(id) contructObject:(id)object withDictionary:(NSDictionary*)dic;

@end
