//
//  DBTypeConvertor.m
//  DBPersistanceDemo
//
//  Created by ldy on 17/3/27.
//  Copyright © 2017年 BJYN. All rights reserved.
//

#import "DBTypeConvertor.h"
#import "NSDate+DBPExtension.h"
#import "DBPConfiguration.h"
#import "NSString+DBPExtension.h"

@implementation DBDefaultTypeConvertor
-(id)convertToDBType:(id)value{
    return value;
}
-(void)convertToObjType:(NSObject*)obj propertyName:(NSString*)name  propertyDBValue:(id)value{
    [obj setValue:value forKey:name];
}
@end

@implementation DBFloatTypeConvertor
-(id)convertToDBType:(id)value{
    return (NSString*)value;
}
-(void)convertToObjType:(NSObject*)obj propertyName:(NSString*)name  propertyDBValue:(id)value{
    NSDecimalNumber *number =[[NSDecimalNumber alloc] initWithFloat:[(NSString*)value floatValue]];
    [obj setValue:number forKey:name];
}
@end


@implementation DBDateTypeConvertor
-(id)convertToDBType:(id)value{
    return [(NSDate*)value toString:DBDateFormatString];
}
-(void)convertToObjType:(NSObject*)obj propertyName:(NSString*)name  propertyDBValue:(id)value{
    NSDate *date = [(NSString*)value toDate];
    [obj setValue:date forKey:name];
}
@end


@implementation DBCustomObjTypeConvertor
-(id)convertToDBType:(id)value{
    return [NSKeyedArchiver archivedDataWithRootObject:value];
}
-(void)convertToObjType:(NSObject*)obj propertyName:(NSString*)name  propertyDBValue:(id)value{
    id d = [NSKeyedUnarchiver unarchiveObjectWithData:(NSData *)value];
    [obj setValue:d forKey:name];
}
@end


@implementation DBNullTypeConvertor
-(id)convertToDBType:(id)value{
    return NULL;
}
-(void)convertToObjType:(NSObject*)obj propertyName:(NSString*)name  propertyDBValue:(id)value{
    [obj setValue:nil forKey:name];
}
@end
