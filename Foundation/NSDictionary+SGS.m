//
//  NSDictionary+SGS.m
//  ARKKit
//
//  Created by Lee on 16/4/20.
//  Copyright © 2016年 ARK. All rights reserved.
//

#import "NSDictionary+SGS.h"

#define ErrorLog(msg, error) if (error != nil) { \
NSLog((@"%s [Line %d] "  msg @" {Error: %@}"), __PRETTY_FUNCTION__, __LINE__, [error localizedDescription]); \
}


#pragma mark - NSDictionary

@implementation NSDictionary (SGS)

// 通过 plist 数据实例化 NSDictionary
+ (nullable instancetype)dictionaryWithPlistData:(nonnull NSData *)plist {
    if (plist == nil || plist.length == 0) return nil;
    NSError *error;
    NSDictionary *dictionary = [NSPropertyListSerialization propertyListWithData:plist options:NSPropertyListImmutable format:nil error:&error];
#if DEBUG
    ErrorLog(@"plist转NSDictionary失败", error)
#endif
    return ([dictionary isKindOfClass:[NSDictionary class]]) ? dictionary : nil;
}

// 通过 plist 字符串实例化 NSDictionary
+ (nullable instancetype)dictionaryWithPlistString:(nonnull NSString *)plist {
    if (plist == nil || plist.length == 0) return nil;
    NSData* data = [plist dataUsingEncoding:NSUTF8StringEncoding];
    return [self dictionaryWithPlistData:data];
}

// 将字典转为 plist data
- (nullable NSData *)plistData {
    NSError *error;
    NSData *data = [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListBinaryFormat_v1_0 options:kNilOptions error:&error];
#if DEBUG
    ErrorLog(@"字典转 plist data 失败", error)
#endif
    return data;
}

// 将字典转为 plist string（XML格式）
- (nullable NSString *)plistString {
    NSError *error;
    NSData *xmlData = [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListXMLFormat_v1_0 options:kNilOptions error:&error];
#if DEBUG
    ErrorLog(@"字典转 plist string 失败", error)
#endif
    return ((xmlData != nil) ? [[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding] : nil);
}

// 将JSON字典转为JSON字符串
- (nullable NSString *)jsonStringEncoded {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
#if DEBUG
        ErrorLog(@"JSON字典转JSON字符串失败", error)
#endif
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
    return nil;
}

// 返回排序后的所有key
- (nonnull NSArray *)allKeysSorted {
    return [self.allKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

// 返回按照key排序的所有值
- (nonnull NSArray *)allValuesSortedByKeys {
    NSArray *sortedKeys = [self allKeysSorted];
    NSMutableArray *arr = @[].mutableCopy;
    for (id key in sortedKeys) {
        [arr addObject:self[key]];
    }
    return arr.copy;
}

// 判断字典是否包含key对应的对象
- (BOOL)containsObjectForKey:(nonnull id)key {
    if (key == nil) return NO;
    return self[key] != nil;
}

// 获取一组key对应的对象
- (nullable NSDictionary *)entriesForKeys:(nonnull NSArray *)keys {
    if (keys == nil || keys.count == 0) return nil;
    
    NSMutableDictionary *dict = @{}.mutableCopy;
    for (id key in keys) {
        id value = self[key];
        if (value) dict[key] = value;
    }
    return dict.copy;
}

@end



#pragma mark - NSMutableDictionary

@implementation NSMutableDictionary (SGS)

// 根据 plist 数据初始化 NSMutableDictionary
+ (nullable instancetype)dictionaryWithPlistData:(nonnull NSData *)plist {
    if (plist == nil || plist.length == 0) return nil;
    
    NSError *error;
    NSMutableDictionary *dictionary = [NSPropertyListSerialization propertyListWithData:plist options:NSPropertyListMutableContainersAndLeaves format:nil error:&error];
    
#if DEBUG
    ErrorLog(@"plist转NSMutableDictionary失败", error)
#endif
    
    return ([dictionary isKindOfClass:[NSMutableDictionary class]]) ? dictionary : nil;
}

// 根据 plist 字符串初始化 NSMutableDictionary
+ (nullable instancetype)dictionaryWithPlistString:(nonnull NSString *)plist {
    if (plist == nil || plist.length == 0) return nil;
    NSData* data = [plist dataUsingEncoding:NSUTF8StringEncoding];
    return [self dictionaryWithPlistData:data];
}

// 弹出key对应的对象
- (nullable id)popObjectForKey:(nonnull id)aKey {
    if (!aKey) return nil;
    id value = self[aKey];
    [self removeObjectForKey:aKey];
    return value;
}

// 弹出keys对应的所有对象
- (nullable NSDictionary *)popEntriesForKeys:(nonnull NSArray *)keys {
    NSMutableDictionary *dict = @{}.mutableCopy;
    for (id key in keys) {
        id value = self[key];
        if (value) {
            [self removeObjectForKey:key];
            dict[key] = value;
        }
    }
    return dict.copy;
}

@end