//
//  TableOperatorProtocol.h
//  DBPersistance
//
//  Created by YNKJMACMINI2 on 15/12/11.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBPConvertor.h"
#import "DBPConvertorProtocol.h"
/**
 *	@brief DBPTableOperator 协议
 *
 *  继承与DBPTableOperator的子类，必须要实现该协议
 */
@protocol DBPTableOperatorProtocol <NSObject>

@required
/**
 *	@brief 设置表名称
 *
 *	@return 表名称字符串
 */
-(NSString*)tableName;
/**
 *	@brief 设置表的每一列的列名和数据类型。创建表时会将key和value以"key value"的形式进行组合
 *
 *	@return 包含 列 信息的字典
 *
 *  其中，key为列名，value为数据类型（需要的话，数据类型后面可以有约束，也可以将约束信息放在-(NSDictionary*)constraints方法中），数据类型可设置为TEXT、INTEGER、BLOB
 */
-(NSDictionary*)columns;
/**
 *	@brief 设置表的主键，应该和 -(NSDictionary*)columnInfo方法返回的信息中对主键的设置保持一致
 *
 *	@return 表的主键，以数组的形式返回
 */
-(NSArray*)primaryKeys;
/**
 *	@brief 设置表使用的convertor
 *
 *	@return Class类型必须继承于DBPConvertor，并实现DBPConvertorProtocol协议
 */
-(Class)convertorClass;

@optional
/**
 *	@brief 设置表的约束。创建表时会将key和value以"key value"的形式进行组合
 *
 *	@return 包含 约束 信息的字典
 *
 *  其中，key为PRIMARY KEY、FOREIGN KEY、CHECK、UNIQUE等，value按照写CREATE TABLE sql语句时的写法进行设置
 *
 *  示例：@{@"PRIMARY KEY":@(userId,orderId)}
 */
-(NSDictionary*)constraints;
@end
