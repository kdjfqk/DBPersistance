//
//  DBPConvertor.m
//  DBPersistance
//
//  Created by YNKJMACMINI2 on 15/12/17.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import "DBPConvertor.h"
#import "NSObject+DBPExtension.h"
#import "NSDate+DBPExtension.h"
#import "NSString+DBPExtension.h"
#import "DBPConfiguration.h"
#import "DBTypeConvertor.h"

#pragma DBPConvertorMapItem
@implementation DBPConvertorMapItem

-(instancetype)initWithPropertyName:(NSString*)name typeConvertor:(Class)convertor{
    self = [super init];
    if(self){
        self.propertyName = name;
        self.typeConvertor = convertor;
    }
    return self;
}
@end


#pragma DBPConvertor
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
    NSDictionary<NSString*,NSDictionary<NSString*,DBPConvertorMapItem*>*> *supportedClassMap = [self.child supportedClassMap];
    [supportedClassMap enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSDictionary<NSString *,DBPConvertorMapItem *> * _Nonnull map, BOOL * _Nonnull stop) {
        if ([[[obj class] description] isEqualToString:key]) {
            *stop = YES;
            [map enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull coloumnName, DBPConvertorMapItem * _Nonnull mapItem, BOOL * _Nonnull stop) {
                //检查是obj中是否有该属性，没有则抛异常
                if (![obj hasProperty:mapItem.propertyName]) {
                    NSException *exp = [[NSException alloc]  initWithName:@"convert Object to NSDictionary error" reason:[NSString stringWithFormat:@"can't find the %@ property in %@ Class",mapItem.propertyName,key] userInfo:nil];
                    @throw exp;
                }
                id propertyValue = [obj valueForKey:mapItem.propertyName];
                if(propertyValue == nil){
                    propertyValue = [[[DBNullTypeConvertor alloc] init] convertToDBType:propertyValue];
                }else{
                    if(mapItem.typeConvertor == nil){
                        propertyValue = [[[DBDefaultTypeConvertor alloc] init] convertToDBType:propertyValue];
                    }else{
                        Class convClass = mapItem.typeConvertor;
                        id<DBPTypeConvertorProtocol> convertor = [[convClass alloc] init];
                        propertyValue = [convertor convertToDBType:propertyValue];
                    }
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
    NSDictionary<NSString*,NSDictionary<NSString*,DBPConvertorMapItem*>*> *supportedClassMap = [self.child supportedClassMap];
    [supportedClassMap enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSDictionary<NSString *,DBPConvertorMapItem *> * _Nonnull map, BOOL * _Nonnull stop) {
        if ([[destClass description] isEqualToString:key]) {
            *stop=YES;
            [map enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull coloumnName, DBPConvertorMapItem * _Nonnull mapItem, BOOL * _Nonnull stop) {
                if([dic[coloumnName] isKindOfClass:[NSNull class]])
                {
                    [[[DBNullTypeConvertor alloc] init] convertToObjType:obj propertyName:mapItem.propertyName propertyDBValue:dic[coloumnName]];
                }
                else
                {
                    if(mapItem.typeConvertor == nil){
                        [[[DBDefaultTypeConvertor alloc] init] convertToObjType:obj propertyName:mapItem.propertyName propertyDBValue:dic[coloumnName]];
                    }else{
                        Class convClass = mapItem.typeConvertor;
                        id<DBPTypeConvertorProtocol> convertor = [[convClass alloc] init];
                        [convertor convertToObjType:obj propertyName:mapItem.propertyName propertyDBValue:dic[coloumnName]];
                    }
                }
            }];
        }
    }];
    return obj;
}
@end
