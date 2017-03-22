//
//  DBOperator.h
//  SQLiteTest
//
//  Created by YNKJMACMINI2 on 15/9/24.
//  Copyright (c) 2015年 YNKJMACMINI2. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabase;
@class FMDatabaseQueue;

/**
 *	@brief 数据库管理 单例类
 */
@interface DBPManager : NSObject

//@property (strong,nonatomic)FMDatabase *db;
@property (strong,nonatomic)FMDatabaseQueue *dbQueue;
@property (strong,nonatomic,readonly)NSString *dbPath;

/**
 *	@brief 获取DBManager单例
 *
 *	@return DBManager单例
 */
+(instancetype)sharedInstance;

/**
 *	@brief 改变数据库路径
 *  默认路径为沙盒Document文件夹下，以Project Name命名的.sqlite文件
 *
 */
-(void)setDBPath:(NSString *)path;

/**
 *	@brief 获取沙盒默认路径
 *
 */
-(NSString *)getDefaultPath;

@end
