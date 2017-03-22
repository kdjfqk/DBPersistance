//
//  SqlCriterion.h
//  DBPersistance
//
//  Created by YNKJMACMINI2 on 15/12/11.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DBPOrderByItem;
@class DBPWhereCondition;

/**
 *	@brief select sql语句构造标准
 */
@interface DBPSqlCriterion : NSObject
/**
 *	@brief sql语句中是否设置DISTINCT
 */
@property (nonatomic, assign) BOOL isDistinct;
/**
 *	@brief where条件
 */
@property (nonatomic, strong) DBPWhereCondition *whereCondition;
/**
 *	@brief orderBy条件
 */
@property (nonatomic, strong) NSArray<DBPOrderByItem*> *orderBy;
/**
 *	@brief limit条件，默认值为SqlCriterionNoLimit，表示不设置limit条件
 */
@property (nonatomic, assign) NSInteger limit;
/**
 *	@brief offset条件，默认值为SqlCriterionNoOffset，表示不设置offset条件
 */
@property (nonatomic, assign) NSInteger offset;
@end
