//
//  FileUtil.h
//  AFNetworkingDownloadTest
//
//  Created by YNKJMACMINI2 on 15/10/22.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *	@brief 文件操作工具类
 */
@interface DBPFileUtil : NSObject

/**
 *	@brief 获取沙盒Documents文件夹路径
 *
 *	@return Documents路径字符串
 */
+(NSString *)documentsPath;
/**
 *	@brief 创建文件夹
 *
 *	@param folderPath 文件夹路径
 *
 *	@return 创建成功返回YES，否则返回NO
 */
+(BOOL)createFolder:(NSString *)folderPath;
/**
 *	@brief 创建文件
 *
 *	@param filePath 文件路径
 *
 *	@return 创建成功返回YES，否则返回NO
 */
+(BOOL)createFileWithPath:(NSString *)filePath;
/**
 *	@brief 文件是否存在
 *
 *	@param filePath	文件路径
 *
 *	@return 文件存在返回YES，否则返回NO
 */
+(BOOL)existFileAtPath:(NSString *)filePath;
@end
