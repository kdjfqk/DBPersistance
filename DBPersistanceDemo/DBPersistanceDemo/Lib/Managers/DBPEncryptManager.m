//
//  DBPEncryptManager.m
//  DBPersistance
//
//  Created by YNKJMACMINI2 on 16/4/14.
//  Copyright © 2016年 YNKJMACMINI2. All rights reserved.
//

#import "DBPEncryptManager.h"
#import "FMEncryptDatabase.h"
#import "FMEncryptDatabaseQueue.h"
#import "FMEncryptHelper.h"
#import "DBPConfiguration.h"

@implementation DBPEncryptManager

//override
-(void)createDBQueue{
    if (self.dbQueue != nil) {
        [self.dbQueue close];
    }
    
    [FMEncryptDatabase setEncryptKey:password];
    self.dbQueue = [FMEncryptDatabaseQueue databaseQueueWithPath:self.dbPath];
}

@end
