//
//  WhereCondition.h
//  DBPersistance
//
//  Created by YNKJMACMINI2 on 15/12/16.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *	@brief 表示where条件的类
 */
@interface DBPWhereCondition : NSObject
/**
 *	@brief where条件字符串
 *
 *  例如："userId=? and age=?"，其中"userId"和"age"为列名，"?"表示需要绑定的参数值
 */
@property (strong,nonatomic)NSString *conditionString;
/**
 *	@brief where条件字符串中需要绑定的参数值的数组
 *
 *  例如：对于 "userId=? and age=?" where条件字符串，参数值数组可表示为 @[@"111",20]
 */
@property (strong,nonatomic)NSArray *conditionParams;

/**
 *	@brief 初始化方法
 *
 *	@param conditionString	where条件字符串,例如："userId=? and age=?"，其中"userId"和"age"为列名，"?"表示需要绑定的参数值
 *	@param conditionParams	where条件字符串中需要绑定的参数值的数组,例如：对于 "userId=? and age=?" where条件字符串，参数值数组可表示为 @[@"111",20]
 *
 *	@return DBPWhereCondition实例
 */
-(instancetype)initWithString:(NSString*)conditionString params:(NSArray*)conditionParams;

/**
 *	@brief 判断conditionString中的"?"个数 是否与conditionParams中的元素个数匹配
 *
 *  当conditionString为nil或为空串，且conditionParams为nil或有0个元素时，视为匹配成功
 *
 *	@return 匹配则返回YES，否则返回NO
 */
-(BOOL)isMatched;
/**
 *	@brief  判断where条件是否是空条件
 *
 *	@return 条件不为空则返回YES，否则返回NO
 */
-(BOOL)isNotEmpty;
/**
 *	@brief 判断where条件是否不为空条件，且where字符串与参数匹配
 *
 *	@return where条件不为空条件且where字符串与参数匹配则返回YES，否则返回NO
 */
-(BOOL)isNotEmptyAndMatched;
@end
