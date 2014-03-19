//
//  TestClass.h
//  ClassConverter
//
//  Created by satyso on 14-3-5.
//  Copyright (c) 2014年 satyso. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestClass : NSObject
//{
//    char*   p;
//}

@property (nonatomic, assign,setter = uintegerTest:)       NSUInteger      uinteger;
@property (nonatomic, strong, setter = strTest:)           NSString*       str;
@property (nonatomic, assign, setter = doubleValueTest:)   double          doubleValue;
@property (nonatomic, assign)       unsigned char   uc;


@end
