//
//  NSObject+Extension.h
//  DBPersistance
//
//  Created by YNKJMACMINI2 on 15/12/17.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DBPExtension)
/**
 *	@brief 检测NSObject是否有该属性
 *
 *	@param propertyName	属性名
 *
 *	@return 有该属性返回YES，否则返回NO
 */
-(BOOL)hasProperty:(NSString*)propertyName;
/**
 *	@brief 获取属性的Attributes字符串
 *
 *	@param propertyName	属性名
 *
 *	@return Attributes字符串
 *
 *  当NSObject没有该属性时，返回nil
 */
-(NSString *)propertyAttributesWithName:(NSString *)propertyName;
@end
