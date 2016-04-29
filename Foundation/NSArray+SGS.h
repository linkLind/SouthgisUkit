//
//  NSArray+SGS.h
//  ARKKit
//
//  Created by Lee on 16/4/20.
//  Copyright © 2016年 ARK. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - NSArray
@interface NSArray (SGS)
/**
 *  通过 plist 数据实例化 NSArray
 *
 *  @param plist 属性列表数据
 *
 *  @return NSArray or nil
 */
+ (nullable instancetype)arrayWithPlistData:(nonnull NSData *)plist;

/**
 *  通过 plist 字符串实例化 NSArray
 *
 *  @param plist 属性列表字符串
 *
 *  @return NSArray or nil
 */
+ (nullable instancetype)arrayWithPlistString:(nonnull NSString *)plist;

/**
 *  将数组转为 plist data
 */
- (nullable NSData *)plistData;

/**
 *  将数组转为 plist string（XML格式）
 */
- (nullable NSString *)plistString;

/**
 *  将JSON数组转为 json string，如果是非JSON数组将返回 nil
 */
- (nullable NSString *)jsonStringEncoded;

@end


#pragma mark - NSMutableArray
@interface NSMutableArray (SGS)

/**
 *  根据plist数据初始化NSMutableArray
 *
 *  @param plist 属性列表数据
 *
 *  @return NSMutableArray or nil
 */
+ (nullable instancetype)arrayWithPlistData:(nonnull NSData *)plist;

/**
 *  根据plist字符串初始化NSMutableArray
 *
 *  @param plist 属性列表字符串
 *
 *  @return NSMutableArray or nil
 */
+ (nullable instancetype)arrayWithPlistString:(nonnull NSString *)plist;

/**
 *  弹出数组首元素
 *
 *  @return id or nil
 */
- (nullable id)popFirstObject;

/**
 *  弹出数组末尾元素
 *
 *  @return id or nil
 */
- (nullable id)popLastObject;


/**
 *  倒转数组
 */
- (void)reverse;

/**
 *  打乱数组顺序
 */
- (void)shuffle;
@end
