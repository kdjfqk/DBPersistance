//
//  DBPConvertor.h
//  DBPersistance
//
//  Created by YNKJMACMINI2 on 15/12/17.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import <Foundation/Foundation.h>

/*DB类型 与 iOS类型 对应关系
INTEGER <-> NSInteger
INTEGER <-> BOOL
TEXT <-> NSString
TEXT <-> NSDate
BLOB <-> NSData
*/

#pragma DBPTypeConvertorProtocol
/**
 *	@brief DBPTypeConvertorProtocol协议
 *
 *  自定义DB类型和iOS类型之间进行转换的类时，必须实现该协议
 */
@protocol DBPTypeConvertorProtocol <NSObject>
/**
 *	@brief iOS类型转换为DB类型
 *
 *	@param value iOS类型值
 *
 *	@return DB类型值
 */
-(id)convertToDBType:(id)value;
/**
 *	@brief DB类型转换为iOS类型
 *
 *	@param obj 对象实例
 *	@param name 对象属性名称
 *	@param value DB类型值
 */
-(void)convertToObjType:(NSObject*)obj propertyName:(NSString*)name  propertyDBValue:(NSData*)value;

@end


#pragma DBPConvertorMapItem
/**
 *	@brief DBPConvertorMapItem模型
 *
 *  包含了表字段到对象属性之间进行转换的类信息
 */
@interface DBPConvertorMapItem : NSObject
/**
 *	@brief 对象属性名
 */
@property (strong,nonatomic) NSString *propertyName;
/**
 *	@brief 转换器类型
 */
@property (strong,nonatomic) Class typeConvertor;
/**
 *	@brief 初始化方法
 *
 *	@param name 对象属性名
 *	@param convertor 转换器类型
 *
 *	@return DBPConvertorMapItem对象
 */
-(instancetype)initWithPropertyName:(NSString*)name typeConvertor:(Class)convertor;
@end


#pragma DBPConvertorProtocol
/**
 *	@brief DBPConvertor协议
 *
 *  继承与DBPConvertor的子类必须实现该协议
 */
@protocol DBPConvertorProtocol <NSObject>
/**
 *	@brief 提供 该Convertor支持转换的类，以及表字段与类属性之间的对应关系 信息
 *
 *	@return 返回 NSDictionary<NSString*,NSDictionary<NSString*,DBPConvertorMapItem*>*> 类型的字典
 *
 *  @return 键 NSString：支持转换的类的名称
 *
 *  @return 值 NSDictionary<NSString*,NSString*>：表字段与Class类型属性之间的对应关系字典，其中key为表字段名称，value为DBPConvertorMapItem类型
 */
-(NSDictionary<NSString*,NSDictionary<NSString*,DBPConvertorMapItem*>*> *)supportedClassMap;
@end



#pragma DBPConvertor
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
