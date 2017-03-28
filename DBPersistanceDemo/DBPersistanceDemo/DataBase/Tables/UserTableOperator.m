//
//  UserTableOperator.m
//  DBPersistance
//
//  Created by WLSFMACKKL on 15/12/11.
//  Copyright © 2015年 WLSFMACKKL. All rights reserved.
//

#import "UserTableOperator.h"
#import "DBContant.h"
#import "UserConvertor.h"

@implementation UserTableOperator

-(NSString*)tableName
{
    return Table_User;
}

-(NSDictionary*)columns
{
    return @{User_Id:@"TEXT PRIMARY KEY",
             User_Age:@"INTEGER",
             User_Birthday:@"TEXT",
             User_Height:@"REAL",
             User_Married:@"INTEGER",
             User_Address:@"BLOB",
             };
}

-(NSArray*)primaryKeys
{
    return @[User_Id];
}

-(Class)convertorClass
{
    return [UserConvertor class];
}

@end
