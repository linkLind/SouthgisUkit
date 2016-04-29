//
//  NSObject+SGS.m
//  ARK_Objective-C
//
//  Created by Lee on 16/4/25.
//  Copyright © 2016年 ARK. All rights reserved.
//

#import "NSObject+SGS.h"

@implementation NSObject (SGS)
// 将某个对象转为plist数据存到指定目录中
- (BOOL)writeToDirectory:(NSSearchPathDirectory)directory withName:(nonnull NSString *)fileName {
    NSSearchPathDirectory dir = (directory == 0) ? NSDocumentDirectory : directory;
    NSString *path = NSSearchPathForDirectoriesInDomains(dir, NSUserDomainMask, YES).firstObject;
    if (path == nil || path.length == 0)  return NO;
    
    path = [path stringByAppendingPathComponent:fileName];
    NSError *error;
    NSData *plistData = [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListBinaryFormat_v1_0 options:kNilOptions error:&error];
    if (plistData == nil || plistData.length == 0) return NO;
    
    return [plistData writeToFile:path atomically:YES];
}

// 从指定目录中读取数据
+ (nullable instancetype)objectWithFile:(nonnull NSString *)fileName fromDirectory:(NSSearchPathDirectory)directory {
    NSSearchPathDirectory dir = (directory == 0) ? NSDocumentDirectory : directory;
    NSString *path = NSSearchPathForDirectoriesInDomains(dir, NSUserDomainMask, YES).firstObject;
    if (path == nil || path.length == 0)  return nil;
    
    path = [path stringByAppendingPathComponent:fileName];
    NSData *plistData = [NSData dataWithContentsOfFile:path];
    if (plistData == nil || plistData.length == 0) return nil;
    
    NSError *error = nil;
    id plist = [NSPropertyListSerialization propertyListWithData:plistData options:NSPropertyListImmutable format:nil error:&error];
    if (error) return nil;
#if DEBUG
    NSLog((@"%s [Line %d] >>转换plist<%@>失败, Error: %@}"), __PRETTY_FUNCTION__, __LINE__, fileName, error.localizedDescription);
#endif
    
    return plist;
}
@end
