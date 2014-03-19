//
//  Runtime_arc.h
//  ClassConverter
//
//  Created by satyso on 14-2-25.
//  Copyright (c) 2014年 satyso. All rights reserved.
//

#ifndef ClassConverter_Runtime_arc_h
#define ClassConverter_Runtime_arc_h

#ifdef __OBJC__

#import <objc/runtime.h>

#import <Foundation/Foundation.h>

id const class_createInstance_arc(Class const class);

Ivar setInstanceVariable_arc(id obj, const char *name, void *value);

BOOL class_addProperty_ex(Class c, NSString* name, id value, NSArray* propertyAttributeArray);

#endif

#endif