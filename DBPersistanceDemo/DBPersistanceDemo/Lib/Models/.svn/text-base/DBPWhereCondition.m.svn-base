//
//  WhereCondition.m
//  DBPersistance
//
//  Created by YNKJMACMINI2 on 15/12/16.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import "DBPWhereCondition.h"

@implementation DBPWhereCondition

-(instancetype)initWithString:(NSString*)conditionString params:(NSArray*)conditionParams
{
    self=[super init];
    if(self)
    {
        self.conditionString = conditionString;
        self.conditionParams = conditionParams;
    }
    return self;
}

-(BOOL)isMatched
{
    //比较string中『?』和 params中元素个数 是否匹配
    //当conditionString为nil或为空串，且conditionParams为nil或有0个元素时，视为匹配成功
    if ((!self.conditionString || self.conditionString.length==0) && (!self.conditionParams || self.conditionParams.count==0)) {
        return YES;
    }
    if (self.conditionString) {
        __block NSInteger conditionQuestionMarkCount=0;
        [self.conditionString enumerateSubstringsInRange:NSMakeRange(0, self.conditionString.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
            if ([substring isEqualToString:@"?"]) {
                conditionQuestionMarkCount++;
            }
        }];
        if ((conditionQuestionMarkCount==0 && !self.conditionParams) || (self.conditionParams && conditionQuestionMarkCount==self.conditionParams.count)) {
            return YES;
        }
    }
    return NO;
}

-(BOOL)isNotEmpty
{
    if (self.conditionString && self.conditionString.length!=0) {
        return YES;
    }
    return NO;
}

-(BOOL)isNotEmptyAndMatched
{
    return [self isNotEmpty] && [self isMatched];
}

@end
