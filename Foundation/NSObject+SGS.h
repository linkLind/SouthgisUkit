//
//  NSObject+SGS.h
//  ARK_Objective-C
//
//  Created by Lee on 16/4/25.
//  Copyright © 2016年 ARK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SGS)
/**
 *  将某个对象转为plist数据存到指定目录中
 *
 *  @param object    要保存的对象
 *  @param directory 目录，如：NSDocumentDirectory（输入0默认为这个目录）
 *  @param fileName  保存的名称
 *
 *  @return 保存成功返回'YES'，保存失败返回'NO'
 */
- (BOOL)writeToDirectory:(NSSearchPathDirectory)directory withName:(nonnull NSString *)fileName;

/**
 *  从指定目录中读取数据
 *
 *  @param fileName  文件名
 *  @param directory 目录，如：NSDocumentDirectory（输入0默认为这个目录）
 *
 *  @return NSData or nil
 */
+ (nullable instancetype)objectWithFile:(nonnull NSString *)fileName fromDirectory:(NSSearchPathDirectory)directory;
@end
