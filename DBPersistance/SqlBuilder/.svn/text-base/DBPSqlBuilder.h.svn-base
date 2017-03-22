//
//  SqlCommand.h
//  DBPersistance
//
//  Created by YNKJMACMINI2 on 15/12/11.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DBPSqlCriterion;
@class DBPSqlBuilderResult;
@class DBPWhereCondition;

/**
 * @brief sql 语句构造器
 */
@interface DBPSqlBuilder : NSObject

/**
 *	@brief 初始化方法
 *
 *	@param columnInfo	列信息
 *	@param tableName	表名称
 *
 *	@return SqlBuilder实例
 */
-(instancetype)initWithColumns:(NSDictionary*)columns constraints:(NSDictionary*)constraints tableName:(NSString*)tableName primaryKeys:(NSArray*)primaryKeys;
/**
 *	@brief 根据主键构造where条件
 *
 *	@param keyValue	主键键值对字典
 *
 *	@return DBPWhereCondition类型表示的where条件
 */
-(DBPWhereCondition *)primaryKeyConditionWithKeyValue:(NSDictionary*)keyValue;
/**
 *	@brief 构造 CREATE TABLE 语句
 *
 *	@return 返回包含 sql语句 和 sql语句的参数 的SqlBuilderResult实例
 */
-(DBPSqlBuilderResult *)createSql;
/**
 *	@brief 构造 INSERT 语句
 *
 *	@param keyValue	要插入的记录的字典表示形式，key为列名称，value为该列的值
 *
 *	@return 返回包含 sql语句 和 sql语句的参数 的SqlBuilderResult实例
 */
-(DBPSqlBuilderResult *)insertSqlWithKeyValue:(NSDictionary*)keyValue;
/**
 *	@brief 构造 DELETE 语句
 *
 *	@param condition	where条件
 *
 *	@return 返回包含 sql语句 和 sql语句的参数 的SqlBuilderResult实例
 */
-(DBPSqlBuilderResult *)deleteSqlWithWhereCondition:(DBPWhereCondition *)condition;
/**
 *	@brief 构造 UPDATE 语句
 *
 *	@param keyValue	要更新的记录的字典表示形式，key为列名称，value为该列的值
 *	@param condition	where条件
 *
 *	@return 返回包含 sql语句 和 sql语句的参数 的SqlBuilderResult实例
 */
-(DBPSqlBuilderResult *)updateSqlWithKeyValue:(NSDictionary*)keyValue whereCondition:(DBPWhereCondition *)condition;
/**
 *	@brief 构造 SELECT 语句
 *
 *	@param criterion	select sql语句构造标准
 *
 *	@return 返回包含 sql语句 和 sql语句的参数 的SqlBuilderResult实例
 */
-(DBPSqlBuilderResult *)selectSqlWithCriterion:(DBPSqlCriterion*)criterion;
/**
 *	@brief 构造 SELECT count(*) 语句
 *
 *	@param condition	where条件
 *
 *	@return 返回包含 sql语句 和 sql语句的参数 的SqlBuilderResult实例
 */
-(DBPSqlBuilderResult *)countSqlWithWhereCondition:(DBPWhereCondition *)condition;
@end
