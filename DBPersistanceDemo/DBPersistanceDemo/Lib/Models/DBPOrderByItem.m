//
//  OrderByItem.m
//  DBPersistance
//
//  Created by YNKJMACMINI2 on 15/12/11.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import "DBPOrderByItem.h"

@implementation DBPOrderByItem
-(instancetype)initWithColumnName:(NSString*)name isDESC:(BOOL)desc
{
    self=[super init];
    if(self)
    {
        self.columnName = name;
        self.isDESC = desc;
    }
    return self;
}
-(NSString*)toString
{
    return [NSString stringWithFormat:@"%@ %@",self.columnName,self.isDESC?@"DESC":@"ASC"];
}
@end
