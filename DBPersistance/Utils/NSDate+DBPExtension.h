//
//  NSDate+Extension.h
//  DBPersistance
//
//  Created by YNKJMACMINI2 on 15/12/17.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DBPExtension)
/**
 *	@brief 获取本地时间
 *
 *	@return 本地时间
 */
+(NSDate *)getLocaleCurrentTime;
/**
 *	@brief 将日期转换为字符串
 *
 *	@param format	转换格式，如 "yyyy-MM-dd HH:mm:ss"
 *
 *	@return 表示日期的字符串
 */
-(NSString *)toString:(NSString *)format;
@end
