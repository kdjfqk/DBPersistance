//
//  DBPConvertor.m
//  DBPersistance
//
//  Created by YNKJMACMINI2 on 15/12/17.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import "DBPConvertor.h"
#import "DBPConvertorProtocol.h"
#import "NSObject+DBPExtension.h"
#import "NSDate+DBPExtension.h"
#import "NSString+DBPExtension.h"
#import "DBPConfiguration.h"

@interface DBPConvertor()
@property (nonatomic, weak) id<DBPConvertorProtocol> child;
@end

@implementation DBPConvertor

- (instancetype)init
{
    self = [super init];
    if (self && [self conformsToProtocol:@protocol(DBPConvertorProtocol)]) {
        self.child = (id<DBPConvertorProtocol>)self;
    } else {
        NSException *exception = [NSException exceptionWithName:@"DBPConvertor init error" reason:@"the child class must conforms to protocol: <DBPConvertorProtocol>" userInfo:nil];
        @throw exception;
    }
    return self;
}

-(NSDictionary *)convertToDictionaryWithObject:(id)obj
{
    NSMutableDictionary *result =[[NSMutableDictionary alloc] init];
    NSDictionary<NSString*,NSDictionary<NSString*,NSString*>*> *supportedClassMap = [self.child supportedClassMap];
    [supportedClassMap enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSDictionary<NSString *,NSString *> * _Nonnull map, BOOL * _Nonnull stop) {
        if ([[[obj class] description] isEqualToString:key]) {
            *stop = YES;
            [map enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull coloumnName, NSString * _Nonnull propertyName, BOOL * _Nonnull stop) {
                //检查是obj中是否有该属性，没有则抛异常
                if (![obj hasProperty:propertyName]) {
                    NSException *exp = [[NSException alloc]  initWithName:@"convert Object to NSDictionary error" reason:[NSString stringWithFormat:@"can't find the %@ property in %@ Class",propertyName,key] userInfo:nil];
                    @throw exp;
                }
                id propertyValue = [obj valueForKey:propertyName];
                //对于NSDate类型的数据，将其转换为NSString类型，再放入字典
                if ([propertyValue isKindOfClass:[NSDate class]]) {
                    propertyValue = [((NSDate*)propertyValue) toString:DBDateFormatString];
                }
                if (propertyValue==nil) {
                    propertyValue = [NSNull null];
                }
                [result setObject:propertyValue forKey:coloumnName];
            }];
        }
    }];
    return result;
}

-(id)convertToObjectWithDictionary:(NSDictionary*)dic destClass:(Class)destClass
{
    id obj = [[destClass alloc] init];
    NSDictionary<NSString*,NSDictionary<NSString*,NSString*>*> *supportedClassMap = [self.child supportedClassMap];
    [supportedClassMap enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSDictionary<NSString *,NSString *> * _Nonnull map, BOOL * _Nonnull stop) {
        if ([[destClass description] isEqualToString:key]) {
            *stop=YES;
            [map enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull coloumnName, NSString * _Nonnull propertyName, BOOL * _Nonnull stop) {
                if([dic[coloumnName] isKindOfClass:[NSNull class]])
                {
                    [obj setValue:nil forKey:propertyName];
                }
                else
                {
                    NSString *pAttributes = [obj propertyAttributesWithName:propertyName];
                    if ([pAttributes rangeOfString:[[NSDate class] description]].location!=NSNotFound) {
                        //对于NSDate类型的属性，将从字典中取出的字符串值转换为NSDate，再赋值给obj
                        NSDate *d = [((NSString *)dic[coloumnName]) toDate];
                        [obj setValue:d forKey:propertyName];
                    }
                    else
                    {
                        //对于非NSDate类型的属性，直接赋值给obj
                        [obj setValue:dic[coloumnName] forKey:propertyName];
                    }
                }
            }];
        }
    }];
    return obj;
}
@end
