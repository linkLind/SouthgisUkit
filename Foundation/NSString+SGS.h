//
//  NSString+SGS.h
//  ARKKit
//
//  Created by Lee on 16/4/20.
//  Copyright © 2016年 ARK. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSString (SGS)

///================================================================
///  MARK: 通用
///================================================================

/**
 *  去除首尾空字符（包括换行符）
 */
- (nonnull NSString *)trim;

/**
 *  判断字符串是否包含空字符
 */
- (BOOL)hasBlank;

/**
 *  判断字符串是否包含特定字符
 *
 *  @param set 需要判断的字符集
 *
 *  @return 'YES' or 'NO'
 */
- (BOOL)containsCharacterSet:(nonnull NSCharacterSet *)set;

/**
 *  返回字符串范围
 */
- (NSRange)rangeOfAll;


/**
 *  通过资源文件（bundle中查找）实例化NSString
 *
 *  @param fileName 文件名
 *  @param type     文件类型
 *  @param encoding 字符编码形式（传入0则使用UTF8编码）
 *
 *  @return 返回编码后的字符串，如果在bundle里找不到该文件或者编码失败返回'nil'
 */
+ (nullable NSString *)stringWithFile:(nonnull NSString *)fileName
                             fileType:(nullable NSString *)type
                             encoding:(NSStringEncoding)encoding;




///================================================================
///  MARK: 字符串转换与编码
///================================================================

/**
 *  将字符串转换为NSNumber类型，如果是非NSNumber类型（如：@"abc"）则返回'nil'
 */
- (nullable NSNumber *)numberValue;


/**
 *  返回UTF8编码的NSData，如果编码转换失败则返回'nil'
 *  等同于：[self dataUsingEncoding:NSUTF8StringEncoding]
 */
- (nullable NSData *)UTF8Data;

/**
 *  将字符串（如：@"{\"name":\"a\",\"count\":2}"）转为json对象（@{@"name":@"a",@"count":@2}）
 *  当字符串不符合JSON格式将返回'nil'
 */
- (nullable id)jsonObject;

/**
 *  通过JSON对象实例化NSString
 *
 *  @param json JSON格式的 NSArray 或 NSDictionary
 *
 *  @return NSString or nil
 */
+ (nullable instancetype)stringWithJSONObject:(nonnull id)json;

/**
 *  将字符串进行编码令其符合URL规范
 *  iOS7以后等同于：[self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]
 */
- (nullable NSString *)stringByURLQueryEncode;

/**
 *  去除编码格式
 *  iOS7以后等同于：[self stringByRemovingPercentEncoding]
 */
- (nullable NSString *)stringByURLQueryDecode;

/**
 *  将HTML格式字符串进行转换
 *
 *  1.["] 转义为 [&quot;]
 *  2.[&] 转义为 [&amp;]
 *  3.['] 转义为 [&apos;]
 *  4.[<] 转义为 [&lt;]
 *  5.[>] 转义为 [&gt;]
 */
- (nullable NSString *)stringByEscapingHTML;

/**
 *  CRC32字符串
 */
- (nullable NSString *)crc32String;

/**
 *  MD2字符串
 */
- (nullable NSString *)md2String;

/**
 *  MD4字符串
 */
- (nullable NSString *)md4String;

/**
 *  MD5字符串
 */
- (nullable NSString *)md5String;

/**
 *  SHA1字符串
 */
- (nullable NSString *)sha1String;

/**
 *  SHA224字符串
 */
- (nullable NSString *)sha224String;

/**
 *  SHA256字符串
 */
- (nullable NSString *)sha256String;

/**
 *  SHA384字符串
 */
- (nullable NSString *)sha384String;

/**
 *  SHA512字符串
 */
- (nullable NSString *)sha512String;

/**
 *  HMAC-MD5字符串
 *
 *  @param key 密钥
 */
- (nullable NSString *)hmacMD5StringWithKey:(nonnull NSString *)key;

/**
 *  HMAC-SHA1字符串
 *
 *  @param key 密钥
 */
- (nullable NSString *)hmacSHA1StringWithKey:(nonnull NSString *)key;

/**
 *  HMAC-SHA224字符串
 *
 *  @param key 密钥
 */
- (nullable NSString *)hmacSHA224StringWithKey:(nonnull NSString *)key;

/**
 *  HMAC-SHA256字符串
 *
 *  @param key 密钥
 */
- (nullable NSString *)hmacSHA256StringWithKey:(nonnull NSString *)key;

/**
 *  HMAC-SHA384字符串
 *
 *  @param key 密钥
 */
- (nullable NSString *)hmacSHA384StringWithKey:(nonnull NSString *)key;

/**
 *  HMAC-SHA512字符串
 *
 *  @param key 密钥
 */
- (nullable NSString *)hmacSHA512StringWithKey:(nonnull NSString *)key;

/**
 *  base64编码字符串
 */
- (nullable NSString *)base64EncodedString;

/**
 *  解码base64字符串
 *
 *  @param base64EncodedString base64编码的字符串
 *
 *  @return 解码后的字符串 or nil
 */
+ (nullable instancetype)stringWithBase64EncodedString:(nonnull NSString *)base64EncodedString;



///================================================================
///  MARK: 正则表达式
///================================================================

/**
 *  通过正则表达式替换部分字符串
 *
 *  @param regex       正则表达式
 *  @param options     匹配规则
 *  @param replacement 替换的字符串
 *
 *  @return 替换后的字符串 or 原始字符串
 */
- (nonnull NSString *)stringByReplacingRegex:(nonnull NSString *)regex
                                     options:(NSRegularExpressionOptions)options
                                  withString:(nonnull NSString *)replacement;

/**
 *  使用正则表达式验证字符串是否匹配
 *
 *  @param regex 正则表达式
 *
 *  @return 是否匹配
 */
- (BOOL)validateByRegex:(nonnull NSString *)regex;

/**
 *  身份证验证（15位或18位）
 *
 *  身份证15位编码规则：dddddd yymmdd xx p
 *      dddddd：6位地区编码
 *      yymmdd: 出生年(两位年)月日，如：910215
 *      xx: 顺序编码，系统产生，无法确定
 *      p: 性别，奇数为男，偶数为女
 *  只使用正则表达式验证
 *
 *  身份证18位编码规则：dddddd yyyymmdd xxx y
 *      dddddd：6位地区编码
 *      yyyymmdd: 出生年(四位年)月日，如：19910215
 *      xxx：顺序编码，系统产生，无法确定，奇数为男，偶数为女
 *      y: 校验码，该位数值可通过前17位计算获得
 *  除了使用正则表达式验证外，还对最后一位进行校验
 *
 *  regex: ^(^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$)|(^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|\d{3}[Xx])$)$
 */
- (BOOL)validIdentificationCard;

/**
 *  手机号码验证（1开头的11位号码）
 *
 *  regex: ^1\d{10}$
 */
- (BOOL)validMobilePhoneNumber;

/**
 *  中国座机电话号码验证（010-12345678 或 0123-1234567）
 *
 *  regex: ^\d{3}-\d{8}|\d{4}-\d{7}$
 */
- (BOOL)validChinesePhoneNumber;

/**
 *  电子邮箱验证
 *
 *  regex: ^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$
 */
- (BOOL)validEmail;

/**
 *  中国邮政编码验证
 *
 *  regex: ^[1-9]\d{5}(?!\d)$
 */
- (BOOL)validPostcode;

/**
 *  QQ号验证（不以0开头的5-12位数字）
 *
 *  regex: ^[1-9]\d{4,11}$
 */
- (BOOL)validQQ;

/**
 *  账户验证（5-20位 字母、数字或下划线）
 *
 *  regex: ^[A-Za-z0-9_]{5,20}+$
 */
- (BOOL)validAccount;

/**
 *  密码验证（6-18位 大小写字母、数字、以及特殊字符: 空格!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~）
 *
 *  regex: ^[\u0020-\u007f]{6,18}$
 */
- (BOOL)validPassword;

/**
 *  IP地址验证（IPv4）
 *
 *  regex: ^((([1-9]\d?)|(1\d{2})|(2[0-4]\d)|(25[0-5]))\.){3}(([1-9]\d?)|(1\d{2})|(2[0-4]\d)|(25[0-5]))$
 */
- (BOOL)validIPv4;

/**
 *  判断是否是空白行
 *
 *  regex: \n\s*\r
 */
- (BOOL)isAfterSpace;



///================================================================
///  MARK: 数字属性
///================================================================

@property (nonatomic, assign, readonly) char charValue;
@property (nonatomic, assign, readonly) unsigned char unsignedCharValue;
@property (nonatomic, assign, readonly) short shortValue;
@property (nonatomic, assign, readonly) unsigned short unsignedShortValue;
@property (nonatomic, assign, readonly) unsigned int unsignedIntValue;
@property (nonatomic, assign, readonly) long longValue;
@property (nonatomic, assign, readonly) unsigned long unsignedLongValue;
@property (nonatomic, assign, readonly) unsigned long long unsignedLongLongValue;
@property (nonatomic, assign, readonly) NSUInteger unsignedIntegerValue;

@end
