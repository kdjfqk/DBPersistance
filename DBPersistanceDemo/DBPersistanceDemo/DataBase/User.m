//
//  User.m
//  DBPersistanceDemo
//
//  Created by ldy on 17/3/21.
//  Copyright © 2017年 BJYN. All rights reserved.
//

#import "User.h"

@implementation Address
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.province forKey:@"Province"];
    [aCoder encodeObject:self.city forKey:@"City"];
    [aCoder encodeObject:self.area forKey:@"Area"];
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    _province=[aDecoder decodeObjectForKey:@"Province"];
    _city=[aDecoder decodeObjectForKey:@"City"];
    _area=[aDecoder decodeObjectForKey:@"Area"];
    return self;
}
@end


@implementation User

@end


