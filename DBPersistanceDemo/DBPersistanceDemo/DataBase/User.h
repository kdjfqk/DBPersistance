//
//  User.h
//  DBPersistanceDemo
//
//  Created by ldy on 17/3/21.
//  Copyright © 2017年 BJYN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (strong,nonatomic) NSString *userId;
@property (strong,nonatomic) NSString *userPrimaryID;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *portraitUri;
@property (strong,nonatomic) NSString *tel;
@property (strong,nonatomic) NSString *email;
@property (strong,nonatomic) NSString *address;
@end
