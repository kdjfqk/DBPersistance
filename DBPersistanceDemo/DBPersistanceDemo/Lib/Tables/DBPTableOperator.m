//
//  TableOperator.m
//  DBPersistance
//
//  Created by YNKJMACMINI2 on 15/12/11.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import "DBPTableOperator.h"
#import "DBPManager.h"
#import "DBPEncryptManager.h"
#import "DBPSqlBuilder.h"
#import "DBPConfiguration.h"
#import "DBPSqlBuilderResult.h"
#import "DBPWhereCondition.h"
#import "DBPSqlCriterion.h"
#import "FMDB.h"
#import "DBPConvertor.h"

@interface DBPTableOperator()
@property (nonatomic, weak) id<DBPTableOperatorProtocol> child;
@property (nonatomic,strong)DBPSqlBuilder *sqlBuilder;
@property (nonatomic,strong)DBPManager *dbManager;
//@property (nonatomic,strong)DBPConvertor *convertor;
@end

@implementation DBPTableOperator

static BOOL enableEncrypt = YES;

+(void)setEncrypt:(BOOL)enable{
    enableEncrypt = enable;
}

- (instancetype)init
{
    self = [super init];
    if (self && [self conformsToProtocol:@protocol(DBPTableOperatorProtocol)]) {
        self.child = (id<DBPTableOperatorProtocol>)self;
        BOOL b = [self.child respondsToSelector:@selector(constraints)];
        self.sqlBuilder = [[DBPSqlBuilder alloc] initWithColumns:[self.child columns] constraints:b?[self.child constraints]:nil tableName:[self.child tableName] primaryKeys:[self.child primaryKeys]];
        if (enableEncrypt == YES) {
            self.dbManager = [DBPEncryptManager sharedInstance];
        }else{
            self.dbManager = [DBPManager sharedInstance];
        }
        //初始化convertor
        if (![[self.child convertorClass] conformsToProtocol:@protocol(DBPConvertorProtocol)] && [[self.child convertorClass] isSubclassOfClass:[DBPConvertor class]]) {
            NSException *exception = [NSException exceptionWithName:@"DBPTableOperator init error" reason:@"convertor isn't conforms to protocol or isn't a subclass of DBPConvertor" userInfo:nil];
            @throw exception;
        }
        _convertor = [[[self.child convertorClass] alloc] init];
        //判断表是否准备就绪
        if (![self hasExistsTable]) {
            if (![self createTable]) {
                NSException *exception = [NSException exceptionWithName:@"DBPTableOperator init error" reason:@"table isn't ready for operator" userInfo:nil];
                @throw exception;
            }
        }
    } else {
        NSException *exception = [NSException exceptionWithName:@"DBPTableOperator init error" reason:@"the child class must conforms to protocol: <DBPTableOperatorProtocol>" userInfo:nil];
        @throw exception;
    }
    return self;
}

-(NSUInteger)countWithWhereCondition:(DBPWhereCondition*)condition
{
    NSUInteger result = 0;
    DBPSqlBuilderResult *sbResult = [self.sqlBuilder countSqlWithWhereCondition:condition];
    NSArray<NSDictionary*> *queryResult = [self executeQueryWithSqlBuilderResult:sbResult];
    if (queryResult.count>0) {
        result = [queryResult[0].allValues[0] unsignedIntegerValue];
    }
    return result;
}

-(BOOL)existWithPrimayKeyValues:(NSDictionary *)pKeyValues
{
    DBPWhereCondition *wc=[self.sqlBuilder primaryKeyConditionWithKeyValue:pKeyValues];
    NSUInteger count = [self countWithWhereCondition:wc];
    return count>0?YES:NO;
}

#pragma mark - private methods
-(BOOL)hasExistsTable{
    __block BOOL result = NO;
    [self.dbManager.dbQueue inDatabase:^(FMDatabase *db) {
        result = [db tableExists:[self.child tableName]];
    }];
    return result;
}

-(BOOL)createTable
{
    DBPSqlBuilderResult *sbResult = [self.sqlBuilder createSql];
    return [self executeUpdateWithSqlBuilderResult:sbResult];
}

-(BOOL) executeUpdateWithSqlBuilderResult:(DBPSqlBuilderResult*)sbResult
{
    NSLog(@"Sql:%@",sbResult.sql);
    NSMutableString *paramString = [[NSMutableString alloc] init];
    [sbResult.params enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [paramString appendFormat:@"%@,",obj];
    }];
    NSLog(@"SqlParam:%@",paramString);
    //检测sql语句和参数个数 是否匹配
    if (![sbResult isMatched]) {
        NSException *exception = [[NSException alloc] initWithName:@"sql error" reason:@"the count of ? in sql isn't matched with the count of item in param array" userInfo:nil];
        @throw exception;
    }
    __block BOOL result = NO;
    [self.dbManager.dbQueue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:sbResult.sql withArgumentsInArray:sbResult.params];
    }];
    return result;
}

-(NSArray<NSDictionary*>*)executeQueryWithSqlBuilderResult:(DBPSqlBuilderResult*)sbResult
{
    NSLog(@"%@",sbResult.sql);
    NSMutableString *paramString = [[NSMutableString alloc] init];
    [sbResult.params enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [paramString appendFormat:@"%@,",obj];
    }];
    NSLog(@"SqlParam:%@",paramString);
    //检测sql语句和参数个数 是否匹配
    if (![sbResult isMatched]) {
        NSException *exception = [[NSException alloc] initWithName:@"sql error" reason:@"the count of ? in sql isn't matched with the count of item in param array" userInfo:nil];
        @throw exception;
    }
    __block NSMutableArray<NSDictionary*> *result = [[NSMutableArray<NSDictionary*> alloc] init];
    [self.dbManager.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:sbResult.sql withArgumentsInArray:sbResult.params];
        while ([rs next]) {
            NSDictionary *recordDic = rs.resultDictionary;
            [result addObject:recordDic];
        }
        [rs close];
    }];
    return result;
}
@end

@implementation DBPTableOperator (Insert)
-(BOOL)insertWithObject:(id)obj updateIfExist:(BOOL)update
{
    return [self insertWithObjects:@[obj] updateIfExist:update];
}
-(BOOL)insertWithObjects:(NSArray*)objs updateIfExist:(BOOL)update
{
    NSMutableArray<NSDictionary*> *keyValueArray = [[NSMutableArray<NSDictionary*> alloc] init];
    for (id item in objs) {
        NSDictionary *keyValue=[self.convertor convertToDictionaryWithObject:item];
        [keyValueArray addObject:keyValue];
    }
    return [self insertWithKeyValueArray:keyValueArray updateIfExist:update];
}
-(BOOL)insertWithKeyValue:(NSDictionary*)keyValue updateIfExist:(BOOL)update
{
    return [self insertWithKeyValueArray:@[keyValue] updateIfExist:update];
}
-(BOOL)insertWithKeyValueArray:(NSArray<NSDictionary*>*)keyValueArray updateIfExist:(BOOL)update
{
    __block BOOL resutl = YES;
    [keyValueArray enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //检测是否缺少主键值
        BOOL contaionAllPrimaryKey=YES;
        NSArray *primarykeys=[self.child primaryKeys];
        for (NSString *key in primarykeys) {
            if (![obj.allKeys containsObject:key]) {
                contaionAllPrimaryKey=NO;
            }
        }
        if (contaionAllPrimaryKey) {
            DBPWhereCondition *whereCondition = [self.sqlBuilder primaryKeyConditionWithKeyValue:obj];
            if ([self countWithWhereCondition:whereCondition]>0) {  //记录已经存在
                //若update为YES则进行更新，否则不插入也不更新，保持原有记录不变
                if (update) {
                    [self updateWithKeyValue:obj whereCondition:whereCondition];
                }
            }
            else  //记录不存在
            {
                //插入记录
                DBPSqlBuilderResult *sbResult = [self.sqlBuilder insertSqlWithKeyValue:obj];
                if (![self executeUpdateWithSqlBuilderResult:sbResult]) {
                    NSLog(@"%@表 插入记录失败",[self.child tableName]);
                    resutl = NO;
                }
            }
        }
        else
        {
            resutl = NO;
            NSException *exception = [NSException exceptionWithName:@"insert error" reason:@"lack of primary key" userInfo:nil];
            @throw exception;
            
        }
    }];
    return resutl;
}
@end

@implementation DBPTableOperator (Delete)
-(BOOL)deleteWithPrimayKeyValues:(NSDictionary *)pKeyValues
{
    DBPWhereCondition *wc = [self.sqlBuilder primaryKeyConditionWithKeyValue:pKeyValues];
    return [self deleteWithWhereCondition:wc];
}
-(BOOL)deleteWithWhereCondition:(DBPWhereCondition*)condition
{
    DBPSqlBuilderResult *sbResult = [self.sqlBuilder deleteSqlWithWhereCondition:condition];
    return [self executeUpdateWithSqlBuilderResult:sbResult];
}
@end

@implementation DBPTableOperator (Update)
-(BOOL)updateWithObject:(id)obj primayKeyValues:(NSDictionary *)pKeyValues
{
    DBPWhereCondition *wc = [self.sqlBuilder primaryKeyConditionWithKeyValue:pKeyValues];
    return [self updateWithObject:obj whereCondition:wc];
}
-(BOOL)updateWithObject:(id)obj whereCondition:(DBPWhereCondition*)conditon
{
    NSDictionary *keyValue = [self.convertor convertToDictionaryWithObject:obj];
    return [self updateWithKeyValue:keyValue whereCondition:conditon];
    
}
-(BOOL)updateWithKeyValue:(NSDictionary *)keyValue primayKeyValues:(NSDictionary *)pKeyValues
{
    DBPWhereCondition *wc = [self.sqlBuilder primaryKeyConditionWithKeyValue:pKeyValues];
    return [self updateWithKeyValue:keyValue whereCondition:wc];
}
-(BOOL)updateWithKeyValue:(NSDictionary*)keyValue whereCondition:(DBPWhereCondition*)conditon
{
    DBPSqlBuilderResult *sbResult = [self.sqlBuilder updateSqlWithKeyValue:keyValue whereCondition:conditon];
    return [self executeUpdateWithSqlBuilderResult:sbResult];
}
@end

@implementation DBPTableOperator (Select)

-(NSArray*)selectObjectWithPrimayKeyValues:(NSDictionary *)pKeyValues resultClass:(Class)resultClass
{
    DBPWhereCondition *wc = [self.sqlBuilder primaryKeyConditionWithKeyValue:pKeyValues];
    return [self selectObjectWithWhereCondition:wc resultClass:resultClass];
}
-(NSArray*)selectObjectWithWhereCondition:(DBPWhereCondition*)condition resultClass:(Class)resultClass
{
    DBPSqlCriterion *criterion=[[DBPSqlCriterion alloc] init];
    criterion.whereCondition = condition;
    return [self selectObjectWithCriterion:criterion resultClass:resultClass];
}
-(NSArray*)selectObjectWithCriterion:(DBPSqlCriterion*)criterion resultClass:(Class)resultClass
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSArray<NSDictionary*> *resultDicArray = [self selectWithCriterion:criterion];
    if (resultDicArray.count>0) {
        //根据resultClass参数，做NSDictionary到Object的转换
        for (NSDictionary *item in resultDicArray) {
            id resultObject=[self.convertor convertToObjectWithDictionary:item destClass:resultClass];
            [result addObject:resultObject];
        }
    }
    return result;
}
-(NSArray<NSDictionary*>*)selectWithPrimayKeyValues:(NSDictionary *)pKeyValues
{
    DBPWhereCondition *wc = [self.sqlBuilder primaryKeyConditionWithKeyValue:pKeyValues];
    return [self selectWithWhereCondition:wc];
}
-(NSArray<NSDictionary*>*)selectWithWhereCondition:(DBPWhereCondition*)condition
{
    DBPSqlCriterion *criterion=[[DBPSqlCriterion alloc] init];
    criterion.whereCondition = condition;
    return [self selectWithCriterion:criterion];
}
-(NSArray<NSDictionary*>*)selectWithCriterion:(DBPSqlCriterion*)criterion
{
    NSMutableArray<NSDictionary*> *result = [[NSMutableArray<NSDictionary*> alloc] init];
    DBPSqlBuilderResult *sbResult = [self.sqlBuilder selectSqlWithCriterion:criterion];
    result = [self executeQueryWithSqlBuilderResult:sbResult];
    return result;
}
@end
