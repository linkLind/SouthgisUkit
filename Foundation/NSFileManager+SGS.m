//
//  NSFileManager+SGS.m
//  ARK_Objective-C
//
//  Created by Lee on 16/4/24.
//  Copyright © 2016年 ARK. All rights reserved.
//

#import "NSFileManager+SGS.h"


@implementation NSFileManager (SGS)
// 在Document目录中创建文件夹
+ (BOOL)createFolderInDocumentDirectoryWithName:(nonnull NSString *)folderName {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    if (path == nil || path.length == 0) return NO;
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    path = [path stringByAppendingPathComponent:folderName];
    BOOL isExist = [manager fileExistsAtPath:path];
    if (isExist) return YES;
    
    NSError *error;
    BOOL success = [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    
    if (error) return NO;
#if DEBUG
    NSLog((@"%s [Line %d] >>创建文件夹<%@>失败, Error: %@}"), __PRETTY_FUNCTION__, __LINE__, folderName, error.localizedDescription);
#endif
    
    return success;
}

+ (BOOL)deleteFileForPath:(nonnull NSString *)path {
    if (path == nil || path.length == 0) return NO;
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
    
#if DEBUG
    NSLog((@"%s [Line %d] >>创建文件失败: %@, Error: %@}"), __PRETTY_FUNCTION__, __LINE__, path, error.localizedDescription);
#endif
    
    return success;
}

+ (BOOL)fileExistsAtPath:(nonnull NSString *)path {
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}
@end
