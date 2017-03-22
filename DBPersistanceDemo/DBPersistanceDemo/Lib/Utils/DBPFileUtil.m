//
//  FileUtil.m
//  AFNetworkingDownloadTest
//
//  Created by YNKJMACMINI2 on 15/10/22.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import "DBPFileUtil.h"

@implementation DBPFileUtil

+(NSString *)documentsPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

+(BOOL)createFolder:(NSString *)folderPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 创建目录
    BOOL res=[fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    if (res)
    {
        NSLog(@"文件夹创建成功：%@",folderPath);
    }else
    {
        NSLog(@"文件夹创建失败：%@",folderPath);
    }
    return res;
}

+(BOOL)createFileWithPath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL res=[fileManager createFileAtPath:filePath contents:nil attributes:nil];
    if (res) {
        NSLog(@"文件创建成功: %@" ,filePath);
    }else
        NSLog(@"文件创建失败: %@" ,filePath);
    return res;
}

+(BOOL)deleteFileWithPath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL res=[fileManager removeItemAtPath:filePath error:nil];
    if (res) {
        NSLog(@"文件删除成功");
    }else
        NSLog(@"文件删除失败");
    return res;
}

+(BOOL)existFileAtPath:(NSString *)filePath
{
    NSFileManager * fileManager=[NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filePath];
}

@end
