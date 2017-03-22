//
//  SqlBuilderResult.m
//  DBPersistance
//
//  Created by YNKJMACMINI2 on 15/12/15.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import "DBPSqlBuilderResult.h"
#import "NSDate+DBPExtension.h"
#import "DBPConfiguration.h"

@implementation DBPSqlBuilderResult
-(instancetype)init
{
    self=[super init];
    if(self)
    {
        self.sql=nil;
        self.params = [[NSMutableArray alloc] init];
    }
    return self;
}
-(BOOL)isMatched
{
    //比较string中『?』和 params中元素个数 是否匹配
    //当sql为nil或为空串，且params为nil或有0个元素时，视为匹配成功
    if ((!self.sql || self.sql.length==0) && (!self.params || self.params.count==0)) {
        return YES;
    }
    if (self.sql) {
        __block NSInteger sqlQuestionMarkCount=0;
        [self.sql enumerateSubstringsInRange:NSMakeRange(0, self.sql.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
            if ([substring isEqualToString:@"?"]) {
                sqlQuestionMarkCount++;
            }
        }];
        if ((sqlQuestionMarkCount==0 && !self.params) || (self.params && sqlQuestionMarkCount==self.params.count)) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - get methods
-(NSMutableArray *)params
{
    if (_params!=nil && _params.count>0) {
        [_params enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSDate class]]) {
                //将NSDate类型数据转换为NSString类型
                [_params replaceObjectAtIndex:idx withObject:[((NSDate *)obj) toString:DBDateFormatString]];
            }
        }];
    }
    return _params;
}
@end
