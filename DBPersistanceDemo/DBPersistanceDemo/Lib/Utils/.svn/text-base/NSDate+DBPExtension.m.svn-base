//
//  NSDate+Extension.m
//  DBPersistance
//
//  Created by YNKJMACMINI2 on 15/12/17.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import "NSDate+DBPExtension.h"
#import "DBPConfiguration.h"

@implementation NSDate (DBPExtension)
+(NSDate *)getLocaleCurrentTime
{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    return localeDate;
}
-(NSString *)toString:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[[NSTimeZone alloc] initWithName:@"GMT"]];
    [formatter setDateFormat:format];
    NSString *strDate = [formatter stringFromDate:self];
    return strDate;
}
@end
