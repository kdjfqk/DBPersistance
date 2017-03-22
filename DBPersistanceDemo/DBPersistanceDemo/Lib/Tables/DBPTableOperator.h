//
//  TableOperator.h
//  DBPersistance
//
//  Created by YNKJMACMINI2 on 15/12/11.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBPConvertor.h"

@class DBPSqlCriterion;
@class DBPWhereCondition;

/**
 *	@brief 数据库表的操作类，可进行对表进行增删改查操作
 *
 *	该类不可以直接使用，应该创建继承与该类的子类，并实现DBPTableOperatorProtocol协议
 *
 *  由于SQLite对NSDate类型的数据，在存储时会自动转换为一个类似与"14567865455.53456465"的字符串。所以DBPersistance在将NSDate类型数据存入数据库之前，统一转换为NSString类型，如值为"2015-12-18 08:02:53 +0000"的NSDate类型将被转换为"2015-12-18 08:02:53"的NSString类型。
 *
 *  DBPersistance对NSDate的转换对用户几乎是透明的，只有一处例外：
 *
 *  DBPTableOperator类的selectWithWhereCondition:方法 和 selectWithCriterion:方法，返回的NSArray<NSDictionary*>字典中，NSDate类型的数据将以NSString类型存在，用户可以使用NSString的扩展方法toDate,将NSString转换为NSDate
 */
@interface DBPTableOperator : NSObject

/**
 *	@brief 是否开启数据库加密
 *
 *	@param enable YES or NO
 *
 */
+(void)setEncrypt:(BOOL)enable;

@property (nonatomic,strong,readonly)DBPConvertor *convertor;

/**
 *	@brief 获取满足指定条件的记录条数
 *
 *	@param condition	where条件
 *
 *	@return 满足条件的记录条数
 */
-(NSUInteger)countWithWhereCondition:(DBPWhereCondition*)condition;
/**
 *	@brief 根据主键判断记录是否存在
 *
 *	@param pKeyValues	包含主键信息的字典，其中key为主键字段名称，value为主键的值
 *
 *	@return 存在则返回YES，否则返回NO
 */
-(BOOL)existWithPrimayKeyValues:(NSDictionary *)pKeyValues;
@end

@interface DBPTableOperator (Insert)
/**
 *	@brief 使用具体对象实例作为数据源，插入一条记录
 *
 *	@param obj		对象实例，该对象实例的类型必须是该表的DBPConvertor所支持转换的类型
 *	@param update	当检测到记录已经存在时，是否更新数据，YES则更新，NO则不更新
 *
 *	@return 插入成功返回YES，否则返回NO
 */
-(BOOL)insertWithObject:(id)obj updateIfExist:(BOOL)update;
/**
 *	@brief 使用具体对象实例作为数据源，插入多条记录
 *
 *	@param obj		对象实例数组，数组中每一个对象实例的类型必须是该表的DBPConvertor所支持转换的类型
 *	@param update	当检测到记录已经存在时，是否更新数据，YES则更新，NO则不更新
 *
 *	@return 插入成功返回YES，否则返回NO
 */
-(BOOL)insertWithObjects:(NSArray*)objs updateIfExist:(BOOL)update;
/**
 *	@brief 插入一条记录
 *
 *	@param keyValue	要插入的记录的字典表示形式，key为列名称，value为该列的值
 *	@param update 当检测到记录已经存在时，是否更新数据，YES则更新，NO则不更新
 *
 *	@return 插入成功返回YES，否则返回NO
 */
-(BOOL)insertWithKeyValue:(NSDictionary*)keyValue updateIfExist:(BOOL)update;
/**
 *	@brief 插入多条记录
 *
 *	@param keyValueArray 数组中每一条为要插入的记录的字典表示形式，key为列名称，value为该列的值
 *	@param update 当检测到记录已经存在时，是否更新数据，YES则更新，NO则不更新
 *
 *	@return 插入成功返回YES，否则返回NO
 */
-(BOOL)insertWithKeyValueArray:(NSArray<NSDictionary*>*)keyValueArray updateIfExist:(BOOL)update;
@end

@interface DBPTableOperator (Delete)
/**
 *	@brief 删除记录,使用主键作为匹配条件
 *
 *	@param pKeyValues	包含主键信息的字典，其中key为主键字段名称，value为主键的值
 *
 *	@return 删除成功返回YES，否则返回NO
 */
-(BOOL)deleteWithPrimayKeyValues:(NSDictionary *)pKeyValues;
/**
 *	@brief 删除记录
 *
 *	@param condition	where条件，删除所有记录则传nil
 *
 *	@return 删除成功返回YES，否则返回NO
 */
-(BOOL)deleteWithWhereCondition:(DBPWhereCondition*)condition;
@end

@interface DBPTableOperator (Update)
/**
 *	@brief 使用具体对象实例作为数据源，更新记录
 *
 *	@param obj				对象实例，该对象实例的类型必须是该表的DBPConvertor所支持转换的类型
 *	@param pKeyValues	包含主键信息的字典，其中key为主键字段名称，value为主键的值
 *
 *	@return 更新成功返回YES，否则返回NO
 */
-(BOOL)updateWithObject:(id)obj primayKeyValues:(NSDictionary *)pKeyValues;
/**
 *	@brief 使用具体对象实例作为数据源，更新记录
 *
 *	@param obj			对象实例，该对象实例的类型必须是该表的DBPConvertor所支持转换的类型
 *	@param conditon	更新的where条件
 *
 *	@return 更新成功返回YES，否则返回NO
 */
-(BOOL)updateWithObject:(id)obj whereCondition:(DBPWhereCondition*)conditon;
/**
 *	@brief 更新记录
 *
 *	@param keyValue		要更新的列信息，key为列名称，value为该列的值
 *	@param pKeyValues	包含主键信息的字典，其中key为主键字段名称，value为主键的值
 *
 *	@return 更新成功返回YES，否则返回NO
 */
-(BOOL)updateWithKeyValue:(NSDictionary *)keyValue primayKeyValues:(NSDictionary *)pKeyValues;
/**
 *	@brief 更新记录
 *
 *	@param keyValue	要更新的列信息，key为列名称，value为该列的值
 *	@param conditon	where条件
 *
 *	@return 更新成功返回YES，否则返回NO
 */
-(BOOL)updateWithKeyValue:(NSDictionary*)keyValue whereCondition:(DBPWhereCondition*)conditon;
@end

@interface DBPTableOperator (Select)
/**
 *	@brief 查询记录，以指定的类型返回查询结果
 *
 *	@param pKeyValues	包含主键信息的字典，其中key为主键字段名称，value为主键的值
 *	@param resultClass	返回的数组中所存数据的类型
 *
 *	@return 满足where条件的所有记录组成的数组，每一条均为resultClass类型
 */
-(NSArray*)selectObjectWithPrimayKeyValues:(NSDictionary *)pKeyValues resultClass:(Class)resultClass;
/**
 *	@brief 查询记录，以指定的类型返回查询结果
 *
 *	@param condition		查询的where条件
 *	@param resultClass	返回的数组中所存数据的类型
 *
 *	@return 满足where条件的所有记录组成的数组，每一条均为resultClass类型
 */
-(NSArray*)selectObjectWithWhereCondition:(DBPWhereCondition*)condition resultClass:(Class)resultClass;

/**
 *	@brief 查询记录，以指定的类型返回查询结果
 *
 *	@param criterion		select sql语句构造标准
 *	@param resultClass	返回的数组中所存数据的类型
 *
 *	@return 满足where条件的所有记录组成的数组，每一条均为resultClass类型
 */
-(NSArray*)selectObjectWithCriterion:(DBPSqlCriterion*)criterion resultClass:(Class)resultClass;
/**
 *	@brief 查询记录，以字典数组的形式返回查询结果
 *
 *	@param pKeyValues	包含主键信息的字典，其中key为主键字段名称，value为主键的值
 *
 *	@return  满足where条件的所有记录组成的数组，每一条记录以字典的形式表示，key为列名称，value为该列的值
 */
-(NSArray<NSDictionary*>*)selectWithPrimayKeyValues:(NSDictionary *)pKeyValues;
/**
 *	@brief 查询记录，以字典数组的形式返回查询结果
 *
 *	@param condition	where条件
 *
 *	@return 满足where条件的所有记录组成的数组，每一条记录以字典的形式表示，key为列名称，value为该列的值
 */
-(NSArray<NSDictionary*>*)selectWithWhereCondition:(DBPWhereCondition*)condition;
/**
 *	@brief 查询记录，以字典数组的形式返回查询结果
 *
 *	@param criterion	select sql语句构造标准
 *
 *	@return 满足criterion参数的所有记录组成的数组，每一条记录以字典的形式表示，key为列名称，value为该列的值
 */
-(NSArray<NSDictionary*>*)selectWithCriterion:(DBPSqlCriterion*)criterion;
@end
