//
//  UserConvertor.m
//  DBPersistance
//
//  Created by YNKJMACMINI2 on 15/12/17.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import "UserConvertor.h"
#import "DBContant.h"
#import "User.h"

@implementation UserConvertor

-(NSDictionary<NSString*,NSDictionary<NSString*,NSString*>*> *)supportedClassMap
{
    return @{[[User class] description]:@{User_Id:@"userId",
                                             User_Name:@"name",
                                             User_PortraitUri:@"portraitUri",
                                             User_Tel:@"tel",
                                             User_Email:@"email",
                                             User_Address:@"address",
                                             }
             };
}
@end
