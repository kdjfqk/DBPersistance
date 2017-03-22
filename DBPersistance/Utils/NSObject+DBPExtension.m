//
//  NSObject+Extension.m
//  DBPersistance
//
//  Created by YNKJMACMINI2 on 15/12/17.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import "NSObject+DBPExtension.h"
#import "objc/runtime.h"

@implementation NSObject (DBPExtension)
-(BOOL)hasProperty:(NSString*)propertyName
{
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    while (count--) {
        NSString *pName = [NSString stringWithUTF8String:property_getName(properties[count])];
        if ([pName isEqualToString:propertyName]) {
            return YES;
        }
    }
    return NO;
}

-(NSString *)propertyAttributesWithName:(NSString *)propertyName
{
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    while (count--) {
        NSString *pName = [NSString stringWithUTF8String:property_getName(properties[count])];
        if ([pName isEqualToString:propertyName]) {
            return [NSString stringWithUTF8String:property_getAttributes(properties[count])];
        }
    }
    return nil;
}
@end
