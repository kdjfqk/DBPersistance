//
//  NSString+Extension.m
//  LYFaultDiagnosis
//
//  Created by YNKJMACMINI2 on 15/11/20.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import "NSString+DBPExtension.h"
#import "DBPConfiguration.h"

@implementation NSString (DBPExtension)
-(NSDate *)toDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[[NSTimeZone alloc] initWithName:@"GMT"]];
    [formatter setDateFormat:DBDateFormatString];
    NSDate *date = [formatter dateFromString:self];
    return date;
}
@end
