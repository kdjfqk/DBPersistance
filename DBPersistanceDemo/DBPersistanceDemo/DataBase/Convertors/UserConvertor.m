//
//  UserConvertor.m
//  DBPersistance
//
//  Created by YNKJMACMINI2 on 15/12/17.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import "UserConvertor.h"
#import "DBContant.h"
#import "User.h"
#import "DBTypeConvertor.h"

@implementation UserConvertor

-(NSDictionary<NSString*,NSDictionary<NSString*,DBPConvertorMapItem*>*> *)supportedClassMap
{
    return @{[[User class] description]:@{User_Id:[[DBPConvertorMapItem alloc] initWithPropertyName:@"userId" typeConvertor:nil],
                                          User_Age:[[DBPConvertorMapItem alloc] initWithPropertyName:@"age" typeConvertor:[DBDefaultTypeConvertor class]],
                                          User_Birthday:[[DBPConvertorMapItem alloc] initWithPropertyName:@"birthday" typeConvertor:[DBDateTypeConvertor class]],
                                          User_Height:[[DBPConvertorMapItem alloc] initWithPropertyName:@"height" typeConvertor:[DBFloatTypeConvertor class]],
                                          User_Married:[[DBPConvertorMapItem alloc] initWithPropertyName:@"married" typeConvertor:[DBDefaultTypeConvertor class]],
                                          User_Address:[[DBPConvertorMapItem alloc] initWithPropertyName:@"address" typeConvertor:[DBCustomObjTypeConvertor class]]
                                          }
             };
}
@end
