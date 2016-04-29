//
//  NSData+SGS.h
//  ARKKit
//
//  Created by Lee on 16/4/20.
//  Copyright © 2016年 ARK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (SGS)

///================================================================
///  MARK: 通用
///================================================================

/**
 *  通过资源文件（bundle中查找）实例化NSData
 *
 *  @param fileName 文件名
 *  @param type     文件类型
 *
 *  @return 返回二进制数据，如果在bundle里找不到该文件或者编码失败返回'nil'
 */
+ (nullable instancetype)bundleDataWithFile:(nonnull NSString*)fileName fileType:(nullable NSString*)type;

/**
 *  从指定目录中读取数据
 *
 *  @param fileName  文件名
 *  @param directory 目录，如：NSDocumentDirectory（输入0默认为这个目录）
 *
 *  @return NSData or nil
 */
+ (nullable instancetype)dataWithFile:(nonnull NSString *)fileName fromDirectory:(NSSearchPathDirectory)directory;



///================================================================
///  MARK: 转换与编码
///================================================================

/**
 *  等同于：[[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding]
 */
- (nullable NSString *)UTF8String;


/**
 *  转换为十六进制数值的字符串（小写）
 */
- (nullable NSString *)hexString;


/**
 *  通过十六进制数值的字符串实例化NSData
 *
 *  @param hexString 十六进制数值的字符串
 *
 *  @return NSData or nil
 */
+ (nullable instancetype)dataWithHexString:(nonnull NSString *)hexString;


/**
 *  返回NSDictionary/NSArray/nil
 */
- (nullable id)jsonObject;


/**
 *  通过JSON对象实例化NSData
 *
 *  @param json NSDictionary or NSArray
 *
 *  @return NSData or nil
 */
+ (nullable instancetype)dataWithJSONObject:(nonnull id)json;


/**
 *  MD2字符串
 */
- (nonnull NSString *)md2String;

/**
 *  MD2数据
 */
- (nonnull NSData *)md2Data;

/**
 *  MD4字符串
 */
- (nonnull NSString *)md4String;

/**
 *  MD4数据
 */
- (nonnull NSData *)md4Data;

/**
 *  MD5字符串
 */
- (nonnull NSString *)md5String;

/**
 *  MD5数据
 */
- (nonnull NSData *)md5Data;

/**
 *  SHA1字符串
 */
- (nonnull NSString *)sha1String;

/**
 *  SHA1数据
 */
- (nonnull NSData *)sha1Data;

/**
 *  SHA224字符串
 */
- (nonnull NSString *)sha224String;

/**
 *  SHA224数据
 */
- (nonnull NSData *)sha224Data;

/**
 *  SHA256字符串
 */
- (nonnull NSString *)sha256String;

/**
 *  SHA256数据
 */
- (nonnull NSData *)sha256Data;

/**
 *  SHA384字符串
 */
- (nonnull NSString *)sha384String;

/**
 *  SHA384数据
 */
- (nonnull NSData *)sha384Data;

/**
 *  SHA512字符串
 */
- (nonnull NSString *)sha512String;

/**
 *  SHA512字符串
 */
- (nonnull NSData *)sha512Data;

/**
 *  HMAC-MD5字符串
 *
 *  @param key 密钥
 */
- (nonnull NSString *)hmacMD5StringWithKey:(nonnull NSString *)key;

/**
 *  HMAC-MD5数据
 *
 *  @param key 密钥
 */
- (nonnull NSData *)hmacMD5DataWithKey:(nonnull NSData *)key;

/**
 *  HMAC-SHA1字符串
 *
 *  @param key 密钥
 */
- (nonnull NSString *)hmacSHA1StringWithKey:(nonnull NSString *)key;

/**
 *  HMAC-SHA1数据
 *
 *  @param key 密钥
 */
- (nonnull NSData *)hmacSHA1DataWithKey:(nonnull NSData *)key;

/**
 *  HMAC-SHA224字符串
 *
 *  @param key 密钥
 */
- (nonnull NSString *)hmacSHA224StringWithKey:(nonnull NSString *)key;

/**
 *  HMAC-SHA224数据
 *
 *  @param key 密钥
 */
- (nonnull NSData *)hmacSHA224DataWithKey:(nonnull NSData *)key;

/**
 *  HMAC-SHA256字符串
 *
 *  @param key 密钥
 */
- (nonnull NSString *)hmacSHA256StringWithKey:(nonnull NSString *)key;

/**
 *  HMAC-SHA256数据
 *
 *  @param key 密钥
 */
- (nonnull NSData *)hmacSHA256DataWithKey:(nonnull NSData *)key;

/**
 *  HMAC-SHA384字符串
 *
 *  @param key 密钥
 */
- (nonnull NSString *)hmacSHA384StringWithKey:(nonnull NSString *)key;

/**
 *  HMAC-SHA384数据
 *
 *  @param key 密钥
 */
- (nonnull NSData *)hmacSHA384DataWithKey:(nonnull NSData *)key;

/**
 *  HMAC-SHA512字符串
 *
 *  @param key 密钥
 */
- (nonnull NSString *)hmacSHA512StringWithKey:(nonnull NSString *)key;

/**
 *  HMAC-SHA512数据
 *
 *  @param key 密钥
 */
- (nonnull NSData *)hmacSHA512DataWithKey:(nonnull NSData *)key;

/**
 *  CRC32字符串
 */
- (nonnull NSString *)crc32String;

/**
 *  CRC32
 */
- (uint32_t)crc32;

/**
 *  base64编码字符串
 */
- (nonnull NSString *)base64EncodedString;

/**
 *  base64编码数据
 */
- (nonnull NSData *)base64EncodedData;

/**
 *  解码base64编码字符串
 *
 *  @param base64EncodedString base64编码字符串
 *
 *  @return 解码后的NSData or nil
 */
+ (nullable instancetype)dataWithBase64EncodedString:(nonnull NSString *)base64EncodedString;

/**
 *  解码base64编码数据
 *
 *  @param base64EncodedData base64编码数据
 *
 *  @return 解码后的NSData or nil
 */
+ (nullable instancetype)dataWithBase64EncodedData:(nonnull NSData *)base64EncodedData;

/**
 *  AES加密（非ECB模式）
 *
 *  @param key 密钥（128或192或256位长度）
 *  @param iv  初始化引导（128位）
 *
 *  @return 加密后的NSData or nil
 */
- (nullable NSData *)aes256EncryptWithKey:(nonnull NSData *)key iv:(nullable NSData *)iv;

/**
 *  AES解密（非ECB模式）
 *
 *  @param key 密钥（128或192或256位长度）
 *  @param iv  初始化引导（128位）
 *
 *  @return 解密后的NSData or nil
 */
- (nullable NSData *)aes256DecryptWithkey:(nonnull NSData *)key iv:(nullable NSData *)iv;




///================================================================
///  MARK: 解/压缩
///================================================================

/**
 *  gzip 解压
 */
- (nullable NSData *)gzipInflate;

/**
 *  gzip 压缩
 */
- (nullable NSData *)gzipDeflate;

/**
 *  zlib 解压
 */
- (nullable NSData *)zlibInflate;

/**
 *  zlib 压缩
 */
- (nullable NSData *)zlibDeflate;

@end
