//
//  NSString+SGS.m
//  ARKKit
//
//  Created by Lee on 16/4/20.
//  Copyright © 2016年 ARK. All rights reserved.
//

#import "NSString+SGS.h"
#import "NSData+SGS.h"
#import "NSNumber+SGS.h"

#define ErrorLog(msg, error) if (error != nil) { \
    NSLog((@"%s [Line %d] "  msg @" {Error: %@}"), __PRETTY_FUNCTION__, __LINE__, [error localizedDescription]); \
}



@implementation NSString (SGS)

///================================================================
///  MARK: 通用
///================================================================

// 去除首尾空字符（包括换行符）
- (nonnull NSString *)trim {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

// 判断字符串是否包含空字符
- (BOOL)hasBlank {
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if ([blank characterIsMember:c] == YES) {
            return YES;
        }
    }
    return NO;
}

// 判断字符串是否包含特定字符
- (BOOL)containsCharacterSet:(nonnull NSCharacterSet *)set {
    if (set == nil) return NO;
    
    return [self rangeOfCharacterFromSet:set].location != NSNotFound;
}

// 返回字符串范围
- (NSRange)rangeOfAll {
    return NSMakeRange(0, self.length);
}

// 通过资源文件（bundle中查找）实例化NSString
+ (nullable NSString *)stringWithFile:(nonnull NSString *)fileName
                             fileType:(nullable NSString *)type
                             encoding:(NSStringEncoding)encoding {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:type];
    if (path == nil) return nil;
    
    NSError *error;
    NSStringEncoding encode = (encoding == 0) ? NSUTF8StringEncoding : encoding;
    NSString *str = [NSString stringWithContentsOfFile:path encoding:encode error:&error];
    
#if DEBUG
    ErrorLog(@"从文件中读取字符串失败", error);
#endif
    
    return str;
}




///================================================================
///  MARK: 字符串转换与编码
///================================================================

// 将字符串转换为NSNumber类型
- (nullable NSNumber *)numberValue {
    return [NSNumber numberWithString:self];
}

// 返回UTF8编码的NSData
- (nullable NSData *)UTF8Data {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

// 将字符串转为JSON对象（NSArray or NSDictionary or nil）
- (nullable id)jsonObject {
    return [[self UTF8Data] jsonObject];
}

// 通过JSON对象实例化NSString
+ (nullable instancetype)stringWithJSONObject:(nonnull id)json {
    return [[NSData dataWithJSONObject:json] UTF8String];
}

// 将字符串进行编码令其符合URL规范
- (nullable NSString *)stringByURLQueryEncode {
#ifdef __IPHONE_7_0
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
#else
    // iOS7.0 之前使用下面的方法
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CFStringEncoding cfEncoding = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
    NSString *encoded = (__bridge_transfer NSString *)
    CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (__bridge CFStringRef)self,
                                            NULL,
                                            CFSTR("!#$&'()*+,/:;=?@[]"),
                                            cfEncoding);
    return encoded;
#pragma clang diagnostic pop
#endif
}

// 去除编码格式
- (nullable NSString *)stringByURLQueryDecode {
#ifdef __IPHONE_7_0
    return [self stringByRemovingPercentEncoding];
    
#else
    // iOS7.0 之前使用下面的方法
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CFStringEncoding en = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
    NSString *decoded = [self stringByReplacingOccurrencesOfString:@"+"
                                                        withString:@" "];
    decoded = (__bridge_transfer NSString *)
    CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                            (__bridge CFStringRef)decoded,
                                                            CFSTR(""),
                                                            en);
    return decoded;
#pragma clang diagnostic pop
#endif
}

// 将HTML格式字符串进行转换
- (nullable NSString *)stringByEscapingHTML {
    NSUInteger len = self.length;
    if (!len) return self;
    
    unichar *buf = malloc(sizeof(unichar) * len);
    if (!buf) return nil;
    [self getCharacters:buf range:NSMakeRange(0, len)];
    
    NSMutableString *result = [NSMutableString string];
    for (int i = 0; i < len; i++) {
        unichar c = buf[i];
        NSString *esc = nil;
        switch (c) {
            case 34: esc = @"&quot;"; break;
            case 38: esc = @"&amp;"; break;
            case 39: esc = @"&apos;"; break;
            case 60: esc = @"&lt;"; break;
            case 62: esc = @"&gt;"; break;
            default: break;
        }
        if (esc) {
            [result appendString:esc];
        } else {
            CFStringAppendCharacters((CFMutableStringRef)result, &c, 1);
        }
    }
    free(buf);
    return result.copy;
}

// CRC32字符串
- (nullable NSString *)crc32String {
    return [[self UTF8Data] crc32String];
}

// MD2字符串
- (nullable NSString *)md2String {
    return [[self UTF8Data] md2String];
}

// MD4字符串
- (nullable NSString *)md4String {
    return [[self UTF8Data] md4String];
}

// MD5字符串
- (nullable NSString *)md5String {
    return [[self UTF8Data] md5String];
}

// SHA1字符串
- (nullable NSString *)sha1String {
    return [[self UTF8Data] sha1String];
}

// SHA224字符串
- (nullable NSString *)sha224String {
    return [[self UTF8Data] sha224String];
}

// SHA256字符串
- (nullable NSString *)sha256String {
    return [[self UTF8Data] sha256String];
}

// SHA384字符串
- (nullable NSString *)sha384String {
    return [[self UTF8Data] sha384String];
}

// SHA512字符串
- (nullable NSString *)sha512String {
    return [[self UTF8Data] sha512String];
}

// HMAC-MD5字符串
- (nullable NSString *)hmacMD5StringWithKey:(nonnull NSString *)key {
    return [[self UTF8Data] hmacMD5StringWithKey:key];
}

// HMAC-SHA1字符串
- (nullable NSString *)hmacSHA1StringWithKey:(nonnull NSString *)key {
    return [[self UTF8Data] hmacSHA1StringWithKey:key];
}

// HMAC-SHA224字符串
- (nullable NSString *)hmacSHA224StringWithKey:(nonnull NSString *)key {
    return [[self UTF8Data] hmacSHA224StringWithKey:key];
}

// HMAC-SHA256字符串
- (nullable NSString *)hmacSHA256StringWithKey:(nonnull NSString *)key {
    return [[self UTF8Data] hmacSHA256StringWithKey:key];
}

// HMAC-SHA384字符串
- (nullable NSString *)hmacSHA384StringWithKey:(nonnull NSString *)key {
    return [[self UTF8Data] hmacSHA384StringWithKey:key];
}

// HMAC-SHA512字符串
- (nullable NSString *)hmacSHA512StringWithKey:(nonnull NSString *)key {
    return [[self UTF8Data] hmacSHA512StringWithKey:key];
}

// base64编码字符串
- (nullable NSString *)base64EncodedString {
    return [[self UTF8Data] base64EncodedString];
}

// 解码base64字符串
+ (nullable instancetype)stringWithBase64EncodedString:(nonnull NSString *)base64EncodedString {
    NSData *data = [NSData dataWithBase64EncodedString:base64EncodedString];
    return [data UTF8String];
}


///================================================================
///  MARK: 正则表达式
///================================================================

// 通过正则表达式替换部分字符串
- (nonnull NSString *)stringByReplacingRegex:(nonnull NSString *)regex
                                     options:(NSRegularExpressionOptions)options
                                  withString:(nonnull NSString *)replacement {
    NSError *error;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regex options:options error:&error];
    if (error != nil || (regular == nil)) {
#if DEBUG
        ErrorLog(@"字符串替换失败", error)
#endif
        return self;
    }
    
    NSRange range = {0, self.length};
    return [regular stringByReplacingMatchesInString:self options:0 range:range withTemplate:replacement];
}

// 使用正则表达式验证字符串是否匹配
- (BOOL)validateByRegex:(nonnull NSString *)regex {
    NSPredicate *regular = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [regular evaluateWithObject:self];
}

// 身份证验证（15位或18位）
- (BOOL)validIdentificationCard {
    BOOL regularPass = [self validateByRegex:@"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$"];
    
    // 如果身份证长度为15位或者不通过验证直接返回结果
    if ((self.length < 18) || (regularPass == NO)) {
        return regularPass;
    }
    
    // 对18位身份证号码的最后一位进行校验
    int idCardWi[17] = {7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2};  // 前17位加权因子
    
    // 计算前17位各自乘以加权因子后的总和
    int idCardWiSum = 0;
    for (int i = 0; i < 17; i++) {
        NSRange range = {i, 1};
        idCardWiSum += [self substringWithRange:range].integerValue * idCardWi[i];
    }
    
    int idCardMod = idCardWiSum % 11; //计算出校验码所在数组的位置
    NSString *idCardLast = [self substringFromIndex:17]; //得到最后一位身份证号码
    NSArray *idCardY = @[@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];  // 除以11后可能产生的11位余数、验证码
    
    // 如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if (idCardMod == 2) {
        return ([idCardLast isEqualToString:@"X"] || [idCardLast isEqualToString:@"x"]);
    }
    
    // 用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
    return [idCardLast isEqualToString:idCardY[idCardMod]];
}

//  手机号码验证（1开头的11位号码）
- (BOOL)validMobilePhoneNumber {
    return [self validateByRegex:@"^1\\d{10}$"];
}

// 中国座机电话号码验证（010-12345678 或 0123-1234567）
- (BOOL)validChinesePhoneNumber {
    return [self validateByRegex:@"^\\d{3}-\\d{8}|\\d{4}-\\d{7}$"];
}

// 电子邮箱验证
- (BOOL)validEmail {
    return [self validateByRegex:@"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"];
}

// 中国邮政编码验证
- (BOOL)validPostcode {
    return [self validateByRegex:@"^[1-9]\\d{5}(?!\\d)$"];
}

// QQ号验证（不以0开头的5-12位数字）
- (BOOL)validQQ {
    return [self validateByRegex:@"^[1-9]\\d{4,11}$"];
}

// 账户验证（5-20位 字母、数字或下划线）
- (BOOL)validAccount {
    return [self validateByRegex:@"^[A-Za-z0-9_]{5,20}+$"];
}

// 密码验证（6-18位 大小写字母、数字、以及特殊字符: 空格!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~）
- (BOOL)validPassword {
    return [self validateByRegex:@"^[\\u0020-\\u007f & ^]{6,18}$"];
}

// IP地址验证（IPv4）
- (BOOL)validIPv4 {
    return [self validateByRegex:@"^((([1-9]\\d?)|(1\\d{2})|(2[0-4]\\d)|(25[0-5]))\\.){3}(([1-9]\\d?)|(1\\d{2})|(2[0-4]\\d)|(25[0-5]))$"];
}

// 判断是否是空白行
- (BOOL)isAfterSpace {
    return [self validateByRegex:@"\\n\\s*\\r"];
}


///================================================================
///  MARK: 数字属性
///================================================================

- (char)charValue {
    return self.numberValue.charValue;
}

- (unsigned char) unsignedCharValue {
    return self.numberValue.unsignedCharValue;
}

- (short) shortValue {
    return self.numberValue.shortValue;
}

- (unsigned short) unsignedShortValue {
    return self.numberValue.unsignedShortValue;
}

- (unsigned int) unsignedIntValue {
    return self.numberValue.unsignedIntValue;
}

- (long) longValue {
    return self.numberValue.longValue;
}

- (unsigned long) unsignedLongValue {
    return self.numberValue.unsignedLongValue;
}

- (unsigned long long) unsignedLongLongValue {
    return self.numberValue.unsignedLongLongValue;
}

- (NSUInteger) unsignedIntegerValue {
    return self.numberValue.unsignedIntegerValue;
}


@end