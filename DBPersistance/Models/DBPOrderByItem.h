//
//  OrderByItem.h
//  DBPersistance
//
//  Created by YNKJMACMINI2 on 15/12/11.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *	@brief 表示一条orderBy条件的类
 */
@interface DBPOrderByItem : NSObject
/**
 *	@brief 列名称
 */
@property (strong,nonatomic)NSString *columnName;
/**
 *	@brief 是否降序
 */
@property (assign,nonatomic)BOOL isDESC;

/**
 *	@brief 初始化方法
 *
 *	@param name	列名称
 *	@param desc	是否降序
 *
 *	@return OrderByItem实例
 */
-(instancetype)initWithColumnName:(NSString*)name isDESC:(BOOL)desc;
/**
 *	@brief 获取字符串表示形式，格式："列名称 ASC|DESC"
 *
 *	@return 格式化后的字符串
 */
-(NSString*)toString;
@end
