//
//  DBOperator.m
//  SQLiteTest
//
//  Created by YNKJMACMINI2 on 15/9/24.
//  Copyright (c) 2015年 YNKJMACMINI2. All rights reserved.
//

#import "DBPManager.h"
#import "DBPFileUtil.h"
#import "FMDB.h"
#import "FMEncryptDatabase.h"
#import "FMEncryptDatabaseQueue.h"
#import "FMEncryptHelper.h"

@interface DBPManager()
//@property (strong,nonatomic)NSString *dbPath;
@end

@implementation DBPManager

+ (instancetype)sharedInstance
{
    static  DBPManager *instance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(instancetype)init
{
    self = [super init];
    if(self)
    {
        _dbPath = [self getDefaultPath];
        NSLog(@"数据库路径：%@",self.dbPath);
        [self createDBQueue];
    }
    return self;
}

-(void)setDBPath:(NSString *)path{
    _dbPath = path;
    [self createDBQueue];
}

-(void)createDBQueue{
    if (_dbQueue != nil) {
        [_dbQueue close];
    }
    _dbQueue = [FMDatabaseQueue databaseQueueWithPath:self.dbPath];
}

-(NSString *)getDefaultPath{
    NSString *docDir = [DBPFileUtil documentsPath];
    NSString *dbFileName = @"db";
    NSArray *bundleIDArray = [[[NSBundle mainBundle] bundleIdentifier] componentsSeparatedByString:@"."];
    if (bundleIDArray.count>1) {
        dbFileName = bundleIDArray[1];
    }
    else if (bundleIDArray.count>0){
        dbFileName = bundleIDArray[0];
    }
    return [docDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.db",dbFileName]];
}

@end
