//
//  DBTypeConvertor.h
//  DBPersistanceDemo
//
//  Created by ldy on 17/3/27.
//  Copyright © 2017年 BJYN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBPConvertor.h"


@interface DBDefaultTypeConvertor : NSObject<DBPTypeConvertorProtocol>

@end

@interface DBFloatTypeConvertor : NSObject<DBPTypeConvertorProtocol>

@end

@interface DBDateTypeConvertor : NSObject<DBPTypeConvertorProtocol>

@end

@interface DBCustomObjTypeConvertor : NSObject<DBPTypeConvertorProtocol>

@end

@interface DBNullTypeConvertor : NSObject<DBPTypeConvertorProtocol>

@end
