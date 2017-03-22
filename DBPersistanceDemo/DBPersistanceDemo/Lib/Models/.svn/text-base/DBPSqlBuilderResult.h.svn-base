//
//  SqlBuilderResult.h
//  DBPersistance
//
//  Created by YNKJMACMINI2 on 15/12/15.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBPSqlBuilderResult : NSObject
/**
 *	@brief sql字符串
 *
 *  例如：INSERT INTO UserTable (userId,userName,age) VALUES(?,?,?)
 */
@property (strong,nonatomic)NSString *sql;
/**
 *	@brief sql字符串中"?"需要绑定的参数的数组
 *
 *  NSDate类型的元素会被转换为NSSring类型
 */
@property (strong,nonatomic)NSMutableArray *params;

/**
 *	@brief 判断sql中的"?"个数 是否与params中的元素个数匹配
 *
 *  当sql为nil或为空串，且params为nil或有0个元素时，视为匹配成功
 *
 *	@return 匹配则返回YES，否则返回NO
 */
-(BOOL)isMatched;
@end
