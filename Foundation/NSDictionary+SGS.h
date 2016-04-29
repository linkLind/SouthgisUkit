//
//  NSDictionary+SGS.h
//  ARKKit
//
//  Created by Lee on 16/4/20.
//  Copyright © 2016年 ARK. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - NSDictionary
@interface NSDictionary (SGS)

/**
 *  通过 plist 数据实例化 NSDictionary
 *
 *  @param plist 属性列表数据
 *
 *  @return NSDictionary or nil
 */
+ (nullable instancetype)dictionaryWithPlistData:(nonnull NSData *)plist;

/**
 *  通过 plist 字符串实例化 NSDictionary
 *
 *  @param plist 属性列表字符串
 *
 *  @return NSDictionary or nil
 */
+ (nullable instancetype)dictionaryWithPlistString:(nonnull NSString *)plist;

/**
 *  将字典转为 plist data
 */
- (nullable NSData *)plistData;

/**
 *  将字典转为 plist string（XML格式）
 */
- (nullable NSString *)plistString;

/**
 *  将JSON字典转为JSON字符串，如果是非JSON字典将返回'nil'
 */
- (nullable NSString *)jsonStringEncoded;

/**
 *  返回排序后的所有key
 */
- (nonnull NSArray *)allKeysSorted;

/**
 *  返回按照key排序的所有值
 */
- (nonnull NSArray *)allValuesSortedByKeys;

/**
 *  判断字典是否包含key对应的对象
 *
 *  @param key 查询键
 *
 *  @return 如果字典包含该key对应的对象将返回'YES'，否则返回'NO'
 */
- (BOOL)containsObjectForKey:(nonnull id)key;

/**
 *  获取一组key对应的对象
 *
 *  @param keys 查询键数组
 *
 *  @return 返回key对应的所有对象，当keys数组里的任何一个key都不匹配的时候将返回'nil'
 */
- (nullable NSDictionary *)entriesForKeys:(nonnull NSArray *)keys;


@end



#pragma mark - NSMutableDictionary
@interface NSMutableDictionary (SGS)

/**
 *  根据 plist 数据初始化 NSMutableDictionary
 *
 *  @param plist 属性列表数据
 *
 *  @return NSMutableDictionary or nil
 */
+ (nullable instancetype)dictionaryWithPlistData:(nonnull NSData *)plist;

/**
 *  根据 plist 字符串初始化 NSMutableDictionary
 *
 *  @param plist 属性列表字符串
 *
 *  @return NSMutableDictionary or nil
 */
+ (nullable instancetype)dictionaryWithPlistString:(nonnull NSString *)plist;


/**
 *  弹出key对应的对象
 *
 *  @param aKey 查询键
 *
 *  @return id or nil
 */
- (nullable id)popObjectForKey:(nonnull id)aKey;

/**
 *  弹出keys对应的所有对象
 *
 *  @param keys 查询键数组
 *
 *  @return 返回keys对应的所有对象，当keys数组里的任何一个key都不匹配的时候将返回'nil'
 */
- (nullable NSDictionary *)popEntriesForKeys:(nonnull NSArray *)keys;

@end
