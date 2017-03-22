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
             User_Name:@"TEXT",
             User_PortraitUri:@"TEXT",
             User_Tel:@"TEXT",
             User_Email:@"TEXT",
             User_Address:@"TEXT",
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
