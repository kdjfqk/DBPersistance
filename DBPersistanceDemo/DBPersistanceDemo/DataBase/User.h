//
//  User.h
//  DBPersistanceDemo
//
//  Created by ldy on 17/3/21.
//  Copyright © 2017年 BJYN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Address : NSObject<NSCoding>
@property (strong,nonatomic) NSString *province;
@property (strong,nonatomic) NSString *city;
@property (strong,nonatomic) NSString *area;
@end

@interface User : NSObject
@property (strong,nonatomic) NSString *userId;
@property (assign,nonatomic) NSInteger age;
@property (strong,nonatomic) NSDate *birthday;
@property (assign,nonatomic) CGFloat height;
@property (assign,nonatomic) BOOL married;
@property (strong,nonatomic) Address *address;
@end

