//
//  NSFileManager+SGS.h
//  ARK_Objective-C
//
//  Created by Lee on 16/4/24.
//  Copyright © 2016年 ARK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (SGS)
/**
 *  在Document目录中创建文件夹
 *
 *  @param folderName 文件夹名称
 *
 *  @return 已存在或创建成功返回'YES'，创建失败返回'NO'
 */
+ (BOOL)createFolderInDocumentDirectoryWithName:(nonnull NSString *)folderName;

+ (BOOL)deleteFileForPath:(nonnull NSString *)path;

+ (BOOL)fileExistsAtPath:(nonnull NSString *)path;
@end
