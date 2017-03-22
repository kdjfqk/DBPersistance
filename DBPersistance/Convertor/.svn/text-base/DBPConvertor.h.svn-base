//
//  DBPConvertor.h
//  DBPersistance
//
//  Created by YNKJMACMINI2 on 15/12/17.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *	@brief Dictionary与Object相互转换的转换器
 *
 *	该类不可以直接使用，应该创建继承与该类的子类，并实现DBPConvertorProtocol协议
 *
 */
@interface DBPConvertor : NSObject
/**
 *	@brief 将Object转换为Dictionary
 *
 *	@param obj	Object对象
 *
 *	@return Dictionary
 */
-(NSDictionary *)convertToDictionaryWithObject:(id)obj;
/**
 *	@brief 将Dictionary转换为指定类型的对象
 *
 *	@param dic				Dictionary
 *	@param destClass	要转换为的对象的类型
 *
 *	@return Object对象
 */
-(id)convertToObjectWithDictionary:(NSDictionary*)dic destClass:(Class)destClass;
@end
