//
//  NSData+SGS.m
//  ARKKit
//
//  Created by Lee on 16/4/20.
//  Copyright © 2016年 ARK. All rights reserved.
//
//  需要导入 libz.tbd 才能使用 crc32 校验
//

#import "NSData+SGS.h"
#import "NSString+SGS.h"
#include <CommonCrypto/CommonCrypto.h>
#include <zlib.h>
#import "GTMBase64.h"

#define ErrorLog(mgs, error) if (error != nil) { \
NSLog((@"%s [Line %d] " mgs @" {Error: %@}"), __PRETTY_FUNCTION__, __LINE__, [error localizedDescription]); \
}





@implementation NSData (SGS)

///================================================================
///  MARK: 通用
///================================================================

//  通过资源文件（bundle中查找）实例化NSData
+ (nullable instancetype)bundleDataWithFile:(nonnull NSString*)fileName
                             fileType:(nullable NSString*)type {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:type];
    return [NSData dataWithContentsOfFile:path];
}

// 从指定目录中读取数据
+ (nullable instancetype)dataWithFile:(nonnull NSString *)fileName fromDirectory:(NSSearchPathDirectory)directory {
    NSSearchPathDirectory dir = (directory == 0) ? NSDocumentDirectory : directory;
    NSString *path = NSSearchPathForDirectoriesInDomains(dir, NSUserDomainMask, YES).firstObject;
    if (path == nil || path.length == 0)  return nil;
    
    path = [path stringByAppendingPathComponent:fileName];
    return [NSData dataWithContentsOfFile:path];
}



///================================================================
///  MARK: 转换与编码
///================================================================

// 返回UTF8字符串
- (nullable NSString *)UTF8String {
    if (self == nil) return nil;
    return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}

// 返回十六进制数值字符串
- (nullable NSString *)hexString {
    NSUInteger length = self.length;
    NSMutableString *result = [NSMutableString stringWithCapacity:length * 2];
    const unsigned char *byte = self.bytes;
    for (int i = 0; i < length; i++, byte++) {
        [result appendFormat:@"%02x", *byte];
    }
    return result.copy;
}

// 通过十六进制数值的字符串实例化NSData
+ (nullable instancetype)dataWithHexString:(nonnull NSString *)hexString {
    hexString = [hexString stringByReplacingOccurrencesOfString:@" " withString:@""];
    hexString = [hexString lowercaseString];
    NSUInteger length = hexString.length;
    const char *cHexStr = [hexString UTF8String];
    if (cHexStr == 0) return nil;
    
    NSMutableData *result = [NSMutableData dataWithCapacity:(length / 2)];
    unsigned char byte;
    char tempStr[3] = {'\0', '\0', '\0'};
    for (int i = 0; i < length / 2; i++) {
        tempStr[0] = cHexStr[i * 2];
        tempStr[1] = cHexStr[i * 2 + 1];
        byte = strtol(tempStr, NULL, 16);
        [result appendBytes:&byte length:1];
    }
    return result.copy;
}

// 返回JSON对象，
- (nullable id)jsonObject {
    NSError *error;
    id json = [NSJSONSerialization JSONObjectWithData:self options:kNilOptions error:&error];
#if DEBUG
    ErrorLog(@"JSON序列化失败", error)
#endif
    return json;
}

// 通过JSON对象实例化NSData
+ (nullable instancetype)dataWithJSONObject:(nonnull id)json {
    NSError *error;
    NSData *result = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:&error];
#if DEBUG
    ErrorLog(@"通过JSON对象实例化NSData失败", error)
#endif
    return result;
}

// 私有方法，将加密的C String按照特定格式返回NSString
- (nonnull NSString *)p_encryptionStringFromBytes:(unsigned char*)bytes length:(size_t)length {
    if (strlen((char*)bytes) < length) return @"";
    
    NSMutableString *result = [NSMutableString stringWithCapacity:length * 2];
    for (int i = 0; i < length; i++) {
        [result appendFormat:@"%02x", bytes[i]];
    }
    return result;
}

// MD2字符串
- (nonnull NSString *)md2String {
    unsigned char result[CC_MD2_DIGEST_LENGTH] = "";
    CC_MD2(self.bytes, (CC_LONG)self.length, result);
    return [self p_encryptionStringFromBytes:result length:CC_MD2_DIGEST_LENGTH];
}

// MD2数据
- (nonnull NSData *)md2Data {
    unsigned char result[CC_MD2_DIGEST_LENGTH];
    CC_MD2(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_MD2_DIGEST_LENGTH];
}

// MD4字符串
- (nonnull NSString *)md4String {
    unsigned char result[CC_MD4_DIGEST_LENGTH];
    CC_MD4(self.bytes, (CC_LONG)self.length, result);
    return [self p_encryptionStringFromBytes:result length:CC_MD4_DIGEST_LENGTH];
}

// MD4数据
- (nonnull NSData *)md4Data {
    unsigned char result[CC_MD4_DIGEST_LENGTH];
    CC_MD4(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_MD4_DIGEST_LENGTH];
}

// MD5字符串
- (nonnull NSString *)md5String {
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, (CC_LONG)self.length, result);
    return [self p_encryptionStringFromBytes:result length:CC_MD5_DIGEST_LENGTH];
}

// MD5数据
- (nonnull NSData *)md5Data {
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_MD5_DIGEST_LENGTH];
}

// SHA1字符串
- (nonnull NSString *)sha1String {
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(self.bytes, (CC_LONG)self.length, result);
    return [self p_encryptionStringFromBytes:result length:CC_SHA1_DIGEST_LENGTH];
}

// SHA1数据
- (nonnull NSData *)sha1Data {
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_SHA1_DIGEST_LENGTH];
}

// SHA224字符串
- (nonnull NSString *)sha224String {
    unsigned char result[CC_SHA224_DIGEST_LENGTH];
    CC_SHA224(self.bytes, (CC_LONG)self.length, result);
    return [self p_encryptionStringFromBytes:result length:CC_SHA224_DIGEST_LENGTH];
}

// SHA224数据
- (nonnull NSData *)sha224Data {
    unsigned char result[CC_SHA224_DIGEST_LENGTH];
    CC_SHA224(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_SHA224_DIGEST_LENGTH];
}

// SHA256字符串
- (nonnull NSString *)sha256String {
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(self.bytes, (CC_LONG)self.length, result);
    return [self p_encryptionStringFromBytes:result length:CC_SHA256_DIGEST_LENGTH];
}

// SHA256数据
- (nonnull NSData *)sha256Data {
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_SHA256_DIGEST_LENGTH];
}

// SHA384字符串
- (nonnull NSString *)sha384String {
    unsigned char result[CC_SHA384_DIGEST_LENGTH];
    CC_SHA384(self.bytes, (CC_LONG)self.length, result);
    return [self p_encryptionStringFromBytes:result length:CC_SHA384_DIGEST_LENGTH];
}

// SHA384数据
- (nonnull NSData *)sha384Data {
    unsigned char result[CC_SHA384_DIGEST_LENGTH];
    CC_SHA384(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_SHA384_DIGEST_LENGTH];
}

// SHA512字符串
- (nonnull NSString *)sha512String {
    unsigned char result[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(self.bytes, (CC_LONG)self.length, result);
    return [self p_encryptionStringFromBytes:result length:CC_SHA512_DIGEST_LENGTH];
}

// SHA512数据
- (nonnull NSData *)sha512Data {
    unsigned char result[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_SHA512_DIGEST_LENGTH];
}

// 私有方法，返回指定HMAC加密算法的大小
- (size_t)p_sizeOfHMACEncriptWithAlgorithm:(CCHmacAlgorithm)alg {
    size_t size;
    switch (alg) {
        case kCCHmacAlgMD5: size = CC_MD5_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA1: size = CC_SHA1_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA224: size = CC_SHA224_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA256: size = CC_SHA256_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA384: size = CC_SHA384_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA512: size = CC_SHA512_DIGEST_LENGTH; break;
        default: size = 0; break;
    }
    return size;
}

// 私有方法，返回按照指定的HMAC算法进行数据加密的字符串
- (nonnull NSString *)p_HMACStringUsingAlg:(CCHmacAlgorithm)alg withKey:(nonnull NSString *)key {
    size_t size = [self p_sizeOfHMACEncriptWithAlgorithm:alg];
    unsigned char result[size];
    const char *cKey = [key UTF8String];
    CCHmac(alg, cKey, strlen(cKey), self.bytes, self.length, result);
    return [self p_encryptionStringFromBytes:result length:size];
}

// 私有方法，返回按照指定的HMAC算法进行加密的数据
- (nonnull NSData *)p_HMACDataUsingAlg:(CCHmacAlgorithm)alg withKey:(nonnull NSData *)key {
    size_t size = [self p_sizeOfHMACEncriptWithAlgorithm:alg];
    unsigned char result[size];
    CCHmac(alg, [key bytes], key.length, self.bytes, self.length, result);
    return [NSData dataWithBytes:result length:size];
}

// HMAC-MD5字符串
- (nonnull NSString *)hmacMD5StringWithKey:(nonnull NSString *)key {
    return [self p_HMACStringUsingAlg:kCCHmacAlgMD5 withKey:key];
}

// HMAC-MD5数据
- (nonnull NSData *)hmacMD5DataWithKey:(nonnull NSData *)key {
    return [self p_HMACDataUsingAlg:kCCHmacAlgMD5 withKey:key];
}

// HMAC-SHA1字符串
- (nonnull NSString *)hmacSHA1StringWithKey:(nonnull NSString *)key {
    return [self p_HMACStringUsingAlg:kCCHmacAlgSHA1 withKey:key];
}

// HMAC-SHA1数据
- (nonnull NSData *)hmacSHA1DataWithKey:(nonnull NSData *)key {
    return [self p_HMACDataUsingAlg:kCCHmacAlgSHA1 withKey:key];
}

// HMAC-SHA224字符串
- (nonnull NSString *)hmacSHA224StringWithKey:(nonnull NSString *)key {
    return [self p_HMACStringUsingAlg:kCCHmacAlgSHA224 withKey:key];
}

// HMAC-SHA224数据
- (nonnull NSData *)hmacSHA224DataWithKey:(nonnull NSData *)key {
    return [self p_HMACDataUsingAlg:kCCHmacAlgSHA224 withKey:key];
}

// HMAC-SHA256字符串
- (nonnull NSString *)hmacSHA256StringWithKey:(nonnull NSString *)key {
    return [self p_HMACStringUsingAlg:kCCHmacAlgSHA256 withKey:key];
}

// HMAC-SHA256数据
- (nonnull NSData *)hmacSHA256DataWithKey:(nonnull NSData *)key {
    return [self p_HMACDataUsingAlg:kCCHmacAlgSHA256 withKey:key];
}

// HMAC-SHA384字符串
- (nonnull NSString *)hmacSHA384StringWithKey:(nonnull NSString *)key {
    return [self p_HMACStringUsingAlg:kCCHmacAlgSHA384 withKey:key];
}

// HMAC-SHA384数据
- (nonnull NSData *)hmacSHA384DataWithKey:(nonnull NSData *)key {
    return [self p_HMACDataUsingAlg:kCCHmacAlgSHA384 withKey:key];
}

// HMAC-SHA512字符串
- (nonnull NSString *)hmacSHA512StringWithKey:(nonnull NSString *)key {
    return [self p_HMACStringUsingAlg:kCCHmacAlgSHA512 withKey:key];
}

// HMAC-SHA512数据
- (nonnull NSData *)hmacSHA512DataWithKey:(nonnull NSData *)key {
    return [self p_HMACDataUsingAlg:kCCHmacAlgSHA512 withKey:key];
}

// CRC32字符串
- (nonnull NSString *)crc32String {
    uLong result = crc32(0, self.bytes, (uInt)self.length);
    return [NSString stringWithFormat:@"%08x", (uint32_t)result];
}

// CRC32
- (uint32_t)crc32 {
    uLong result = crc32(0, self.bytes, (uInt)self.length);
    return (uint32_t)result;
}

// base64字符串
- (nonnull NSString *)base64EncodedString {
#ifdef __IPHONE_7_0
    return [self base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
#else
    return [[self base64EncodedData] UTF8String];
#endif
}

// base64数据
- (nonnull NSData *)base64EncodedData {
#ifdef __IPHONE_7_0
    return [self base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
#else
    return [GTMBase64 encodeData:self];
#endif
}

// 解码base64编码字符串
+ (nullable instancetype)dataWithBase64EncodedString:(nonnull NSString *)base64EncodedString {
#ifdef __IPHONE_7_0
    return [[NSData alloc] initWithBase64EncodedString:base64EncodedString options:NSDataBase64DecodingIgnoreUnknownCharacters];
#else
    return [GTMBase64 decodeData:[base64EncodedString UTF8Data]];
#endif
}

// 解码base64编码数据
+ (nullable instancetype)dataWithBase64EncodedData:(nonnull NSData *)base64EncodedData {
#ifdef __IPHONE_7_0
    return [[NSData alloc] initWithBase64EncodedData:base64EncodedData options:
            NSDataBase64DecodingIgnoreUnknownCharacters];
#else
    return [GTMBase64 decodeData:base64EncodedData];
#endif
}

// AES加密（非ECB模式）
- (nullable NSData *)aes256EncryptWithKey:(nonnull NSData *)key iv:(nullable NSData *)iv {
    if (key.length != 16 && key.length != 24 && key.length != 32) {
        return nil;
    }
    
    // 如果存在初始化引导，并且长度不等于16则返回空
    if (iv != nil && iv.length != 16) {
        return nil;
    }
    
    size_t bufferSize = self.length + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    if (buffer == 0) return nil;
    size_t encryptedSize = 0;
    CCCryptorStatus cryptorStatus = CCCrypt(kCCEncrypt,
                                            kCCAlgorithmAES128,
                                            kCCOptionPKCS7Padding,
                                            key.bytes, key.length,
                                            iv.bytes,
                                            self.bytes, self.length,
                                            buffer, bufferSize,
                                            &encryptedSize);
    NSData *result = nil;
    if (cryptorStatus == kCCSuccess) {
        result = [NSData dataWithBytesNoCopy:buffer length:encryptedSize];
    }
    free(buffer);
    return result;
}

// AES解密（非ECB模式）
- (nullable NSData *)aes256DecryptWithkey:(nonnull NSData *)key iv:(nullable NSData *)iv {
    if (key.length != 16 && key.length != 24 && key.length != 32) {
        return nil;
    }
    
    // 如果存在初始化引导，并且长度不等于16则返回空
    if (iv.length != 16 && iv.length != 0) {
        return nil;
    }
    
    size_t bufferSize = self.length + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    if (buffer == 0) return nil;
    size_t encryptedSize = 0;
    CCCryptorStatus cryptorStatus = CCCrypt(kCCDecrypt,
                                            kCCAlgorithmAES128,
                                            kCCOptionPKCS7Padding,
                                            key.bytes, key.length,
                                            iv.bytes,
                                            self.bytes, self.length,
                                            buffer, bufferSize,
                                            &encryptedSize);
    NSData *result = nil;
    if (cryptorStatus == kCCSuccess) {
        result = [NSData dataWithBytesNoCopy:buffer length:encryptedSize];
    }
    free(buffer);
    return result;
}


///================================================================
///  MARK: 解/压缩
///================================================================

// gzip 解压
- (nullable NSData *)gzipInflate {
    if ([self length] == 0) return self;
    
    unsigned full_length = (unsigned)[self length];
    unsigned half_length = (unsigned)[self length] / 2;
    
    NSMutableData *decompressed = [NSMutableData dataWithLength:full_length + half_length];
    BOOL done = NO;
    int status;
    
    z_stream strm;
    strm.next_in = (Bytef *)[self bytes];
    strm.avail_in = (unsigned)[self length];
    strm.total_out = 0;
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    
    if (inflateInit2(&strm, (15 + 32)) != Z_OK) return nil;
    while (!done) {
        // Make sure we have enough room and reset the lengths.
        if (strm.total_out >= [decompressed length])
            [decompressed increaseLengthBy:half_length];
        strm.next_out = [decompressed mutableBytes] + strm.total_out;
        strm.avail_out = (uInt)([decompressed length] - strm.total_out);
        
        // Inflate another chunk.
        status = inflate(&strm, Z_SYNC_FLUSH);
        if (status == Z_STREAM_END) done = YES;
        else if (status != Z_OK) break;
    }
    if (inflateEnd(&strm) != Z_OK) return nil;
    
    // Set real length.
    if (done) {
        [decompressed setLength:strm.total_out];
        return [NSData dataWithData:decompressed];
    }
    
    return nil;
}

// gzip 压缩
- (nullable NSData *)gzipDeflate {
    if ([self length] == 0) return self;
    
    z_stream strm;
    
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    strm.opaque = Z_NULL;
    strm.total_out = 0;
    strm.next_in = (Bytef *)[self bytes];
    strm.avail_in = (uInt)[self length];
    
    // Compresssion Levels:
    //   Z_NO_COMPRESSION
    //   Z_BEST_SPEED
    //   Z_BEST_COMPRESSION
    //   Z_DEFAULT_COMPRESSION
    
    if (deflateInit2(&strm, Z_DEFAULT_COMPRESSION, Z_DEFLATED, (15 + 16),
                     8, Z_DEFAULT_STRATEGY) != Z_OK)
        return nil;
    
    // 16K chunks for expansion
    NSMutableData *compressed = [NSMutableData dataWithLength:16384];
    
    do {
        if (strm.total_out >= [compressed length])
            [compressed increaseLengthBy:16384];
        
        strm.next_out = [compressed mutableBytes] + strm.total_out;
        strm.avail_out = (uInt)([compressed length] - strm.total_out);
        
        deflate(&strm, Z_FINISH);
    }
    while (strm.avail_out == 0);
    
    deflateEnd(&strm);
    
    [compressed setLength:strm.total_out];
    return [NSData dataWithData:compressed];
}

// zlib 解压
- (nullable NSData *)zlibInflate {
    if ([self length] == 0) return self;
    
    NSUInteger full_length = [self length];
    NSUInteger half_length = [self length] / 2;
    
    NSMutableData *decompressed = [NSMutableData dataWithLength:full_length + half_length];
    BOOL done = NO;
    int status;
    
    z_stream strm;
    strm.next_in = (Bytef *)[self bytes];
    strm.avail_in = (uInt)full_length;
    strm.total_out = 0;
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    
    if (inflateInit(&strm) != Z_OK) return nil;
    
    while (!done) {
        // Make sure we have enough room and reset the lengths.
        if (strm.total_out >= [decompressed length])
            [decompressed increaseLengthBy:half_length];
        strm.next_out = [decompressed mutableBytes] + strm.total_out;
        strm.avail_out = (uInt)([decompressed length] - strm.total_out);
        
        // Inflate another chunk.
        status = inflate(&strm, Z_SYNC_FLUSH);
        if (status == Z_STREAM_END) done = YES;
        else if (status != Z_OK) break;
    }
    if (inflateEnd(&strm) != Z_OK) return nil;
    
    // Set real length.
    if (done) {
        [decompressed setLength:strm.total_out];
        return [NSData dataWithData:decompressed];
    }
    
    return nil;
}

// zlib 压缩
- (nullable NSData *)zlibDeflate {
    if ([self length] == 0) return self;
    
    z_stream strm;
    
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    strm.opaque = Z_NULL;
    strm.total_out = 0;
    strm.next_in = (Bytef *)[self bytes];
    strm.avail_in = (uInt)[self length];
    
    // Compresssion Levels:
    //   Z_NO_COMPRESSION
    //   Z_BEST_SPEED
    //   Z_BEST_COMPRESSION
    //   Z_DEFAULT_COMPRESSION
    
    if (deflateInit(&strm, Z_DEFAULT_COMPRESSION) != Z_OK) return nil;
    
    // 16K chuncks for expansion
    NSMutableData *compressed = [NSMutableData dataWithLength:16384];
    
    do {
        if (strm.total_out >= [compressed length])
            [compressed increaseLengthBy:16384];
        
        strm.next_out = [compressed mutableBytes] + strm.total_out;
        strm.avail_out = (uInt)([compressed length] - strm.total_out);
        
        deflate(&strm, Z_FINISH);
    }
    while (strm.avail_out == 0);
    
    deflateEnd(&strm);
    
    [compressed setLength:strm.total_out];
    return [NSData dataWithData:compressed];
}


@end
