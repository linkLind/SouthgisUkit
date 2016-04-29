//
//  NSArray+SGS.m
//  ARKKit
//
//  Created by Lee on 16/4/20.
//  Copyright © 2016年 ARK. All rights reserved.
//

#import "NSArray+SGS.h"

#define ErrorLog(msg, error) if (error != nil) { \
    NSLog((@"%s [Line %d] " msg @" {Error: %@}"), __PRETTY_FUNCTION__, __LINE__, [error localizedDescription]); \
}

#pragma mark - NSArray
@implementation NSArray (SGS)
// 通过 plist 数据实例化 NSArray
+ (nullable instancetype)arrayWithPlistData:(nonnull NSData *)plist {
    if (plist == nil || plist.length == 0) return nil;
    NSError *error;
    NSArray *array = [NSPropertyListSerialization propertyListWithData:plist options:NSPropertyListImmutable format:nil error:&error];
#if DEBUG
    ErrorLog(@"plist数据转Array失败", error)
#endif
    return ([array isKindOfClass:[NSArray class]]) ? array : nil;
}

// 通过 plist 字符串实例化 NSArray
+ (nullable instancetype)arrayWithPlistString:(nonnull NSString *)plist {
    if (plist == nil || plist.length == 0) return nil;
    NSData* data = [plist dataUsingEncoding:NSUTF8StringEncoding];
    return [self arrayWithPlistData:data];
}

// 将数组转为 plist data
- (nullable NSData *)plistData {
    NSError *error;
    NSData *data = [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListBinaryFormat_v1_0 options:kNilOptions error:&error];
#if DEBUG
    ErrorLog(@"Array转plist data失败", error)
#endif
    return data;
}

// 将数组转为 plist string（XML格式）
- (nullable NSString *)plistString {
    NSError *error;
    NSData *xmlData = [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListXMLFormat_v1_0 options:kNilOptions error:&error];
#if DEBUG
    ErrorLog(@"Array转plist string失败", error)
#endif
    return ((xmlData != nil) ? [[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding] : nil);
}

// 将JSON数组转为 json string
- (nullable NSString *)jsonStringEncoded {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
#if DEBUG
        ErrorLog(@"JSON Array转JSON String失败", error)
#endif
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
    return nil;
}

@end


#pragma mark - NSMutableArray

@implementation NSMutableArray (SGS)

// 根据plist数据初始化NSMutableArray
+ (nullable instancetype)arrayWithPlistData:(nonnull NSData *)plist {
    if (plist == nil || plist.length == 0) return nil;
    
    NSError *error;
    NSMutableArray *array = [NSPropertyListSerialization propertyListWithData:plist options:NSPropertyListMutableContainersAndLeaves format:nil error:&error];
    
#if DEBUG
    ErrorLog(@"plist数据转NSMutableArray失败", error)
#endif
    
    return ([array isKindOfClass:[NSMutableArray class]]) ? array : nil;
}

// 根据plist字符串初始化NSMutableArray
+ (nullable instancetype)arrayWithPlistString:(nonnull NSString *)plist {
    if (plist == nil || plist.length == 0) return nil;
    
    NSData* data = [plist dataUsingEncoding:NSUTF8StringEncoding];
    return [self arrayWithPlistData:data];
}

// 弹出数组首元素
- (nullable id)popFirstObject {
    id obj = nil;
    if (self.count > 0) {
        obj = self.firstObject;
        [self removeObjectAtIndex:0];
    }
    return obj;
}

// 弹出数组末尾元素
- (nullable id)popLastObject {
    id obj = nil;
    if (self.count > 0) {
        obj = self.lastObject;
        [self removeLastObject];
    }
    return obj;
}

// 倒转数组
- (void)reverse {
    NSUInteger count = self.count;
    int mid = floor(count / 2.0);
    for (NSUInteger i = 0; i < mid; i++) {
        [self exchangeObjectAtIndex:i withObjectAtIndex:(count - (i + 1))];
    }
}

// 打乱数组顺序
- (void)shuffle {
    for (NSUInteger i = self.count; i > 1; i--) {
        [self exchangeObjectAtIndex:(i - 1) withObjectAtIndex:arc4random_uniform((u_int32_t)i)];
    }
}


@end
