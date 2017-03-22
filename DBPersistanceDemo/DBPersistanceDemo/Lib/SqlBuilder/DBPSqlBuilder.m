//
//  SqlCommand.m
//  DBPersistance
//
//  Created by YNKJMACMINI2 on 15/12/11.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import "DBPSqlBuilder.h"
#import "DBPConfiguration.h"
#import "DBPSqlBuilderResult.h"
#import "DBPWhereCondition.h"
#import "DBPSqlCriterion.h"
#import "DBPOrderByItem.h"

@interface DBPSqlBuilder()
@property (strong,nonatomic)NSDictionary *columns;
@property (strong,nonatomic)NSDictionary *constraints;
@property (strong,nonatomic)NSString *tableName;
@property (strong,nonatomic)NSArray *primaryKeys;
@end

@implementation DBPSqlBuilder
-(instancetype)initWithColumns:(NSDictionary*)columns constraints:(NSDictionary*)constraints tableName:(NSString*)tableName primaryKeys:(NSArray*)primaryKeys
{
    self=[super init];
    if(self)
    {
        self.columns = columns;
        self.constraints = constraints;
        self.tableName = tableName;
        self.primaryKeys = primaryKeys;
    }
    return self;
}

-(DBPWhereCondition *)primaryKeyConditionWithKeyValue:(NSDictionary*)keyValue
{
    DBPWhereCondition *condition = [[DBPWhereCondition alloc] init];
    NSMutableString *conditionString = [[NSMutableString alloc] init];
    NSMutableArray *params = [[NSMutableArray alloc] init];
    for (NSString *key in self.primaryKeys) {
        //检测keyValue中是否提供了该primary key的信息，不包含则抛异常
        if (![[keyValue allKeys] containsObject:key]) {
            NSException *exception = [[NSException alloc] initWithName:@"primary key condition error" reason:[NSString stringWithFormat:@"keyValue dictionary hasn't the primary key of %@",key] userInfo:nil];
            @throw exception;
        }
        if (conditionString.length!=0) {
            [conditionString appendString:@" and "];
        }
        [conditionString appendFormat:@"%@=?",key];
        [params addObject:keyValue[key]];
    }
    condition.conditionString = conditionString;
    condition.conditionParams = params;
    return condition;
}

-(DBPSqlBuilderResult *)createSql
{
    DBPSqlBuilderResult *result = [[DBPSqlBuilderResult alloc] init];
    NSMutableString *columnStr = [[NSMutableString alloc] init];
    //列
    [self.columns enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (columnStr.length!=0) {
            [columnStr appendString:@","];
        }
        [columnStr appendFormat:@"%@ %@",key,obj];
    }];
    //约束
    if (self.constraints!=nil) {
        [self.constraints enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if (columnStr.length!=0) {
                [columnStr appendString:@","];
            }
            [columnStr appendFormat:@"%@ %@",key,obj];
        }];
    }
    result.sql =[NSString stringWithFormat:@"CREATE TABLE %@ (%@)",self.tableName,columnStr];
    return result;
}
-(DBPSqlBuilderResult *)insertSqlWithKeyValue:(NSDictionary*)keyValue
{
    DBPSqlBuilderResult *result = [[DBPSqlBuilderResult alloc] init];
    NSMutableString *keyStr=[[NSMutableString alloc] init];
    NSMutableString *valueStr=[[NSMutableString alloc] init];
    [keyValue enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (keyStr.length!=0) {
            [keyStr appendString:@","];
        }
        [keyStr appendString:key];
        if (valueStr.length!=0) {
            [valueStr appendString:@","];
        }
        [valueStr appendFormat:@"?"];
        [result.params addObject:obj];
    }];
    result.sql = [NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES(%@)",self.tableName,keyStr,valueStr];
    return result;
}
-(DBPSqlBuilderResult *)deleteSqlWithWhereCondition:(DBPWhereCondition *)condition
{
    DBPSqlBuilderResult *result = [[DBPSqlBuilderResult alloc] init];
    NSMutableString *sql = [NSMutableString stringWithFormat:@"DELETE FROM %@",self.tableName];
    if (condition && [condition isNotEmpty]) {
        if (![condition isMatched]) {
            NSException *exception = [NSException exceptionWithName:@"whereCondition error" reason:@" whereCondition isn't matched" userInfo:nil];
            @throw exception;
        }
        [sql appendFormat:@" WHERE %@",condition.conditionString];
        [result.params addObjectsFromArray:condition.conditionParams];
    }
    result.sql = sql;
    return result;
}
-(DBPSqlBuilderResult *)updateSqlWithKeyValue:(NSDictionary*)keyValue whereCondition:(DBPWhereCondition *)condition
{
    if (!condition || ![condition isNotEmptyAndMatched]) {
        NSException *exception = [NSException exceptionWithName:@"whereCondition error" reason:@"whereCondition can't be nil or whereCondition isn't matched" userInfo:nil];
        @throw exception;
    }
    DBPSqlBuilderResult *result = [[DBPSqlBuilderResult alloc] init];
    NSMutableString *setStr=[[NSMutableString alloc] init];
    [keyValue enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (setStr.length!=0) {
            [setStr appendString:@","];
        }
        [setStr appendFormat:@"%@=?",key];
        [result.params addObject:obj];
    }];
    result.sql = [NSMutableString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@",self.tableName,setStr,condition.conditionString];
    [result.params addObjectsFromArray:condition.conditionParams];
    return result;
}
-(DBPSqlBuilderResult *)selectSqlWithCriterion:(DBPSqlCriterion*)criterion
{
    DBPSqlBuilderResult *result = [[DBPSqlBuilderResult alloc] init];
    NSMutableString *sql = [NSMutableString stringWithFormat:@"SELECT %@ * FROM %@",criterion.isDistinct?@"DISTINCT":@"",self.tableName];
    if (criterion.whereCondition && [criterion.whereCondition isNotEmpty]) {
        if (![criterion.whereCondition isMatched]) {
            NSException *exception = [NSException exceptionWithName:@"whereCondition error" reason:@" whereCondition isn't matched" userInfo:nil];
            @throw exception;
        }
        [sql appendFormat:@" WHERE %@",criterion.whereCondition.conditionString];
        [result.params addObjectsFromArray:criterion.whereCondition.conditionParams];
    }
    if (criterion.orderBy!=nil) {
        NSMutableString *orderBy = [NSMutableString stringWithString:@" order by"];
        [criterion.orderBy enumerateObjectsUsingBlock:^(DBPOrderByItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [orderBy appendFormat:@" %@%@",idx==0?@"":@",",[obj toString]];
        }];
        [sql appendString:orderBy];
    }
    if (criterion.limit!=SqlCriterionNoLimit) {
        [sql appendFormat:@" limit %ld",criterion.limit];
    }
    if (criterion.offset!=SqlCriterionNoOffset) {
        [sql appendFormat:@" offset %ld",criterion.offset];
    }
    result.sql = sql;
    return result;
}
-(DBPSqlBuilderResult *)countSqlWithWhereCondition:(DBPWhereCondition *)condition
{
    DBPSqlBuilderResult *result = [[DBPSqlBuilderResult alloc] init];
    NSMutableString *sql = [NSMutableString stringWithFormat:@"SELECT count(*) FROM %@",[self tableName]];
    if (condition && [condition isNotEmpty]) {
        if (![condition isMatched]) {
            NSException *exception = [NSException exceptionWithName:@"whereCondition error" reason:@" whereCondition isn't matched" userInfo:nil];
            @throw exception;
        }
        [sql appendFormat:@" WHERE %@",condition.conditionString];
        [result.params addObjectsFromArray:condition.conditionParams];
    }
    result.sql = sql;
    return result;
}
@end
