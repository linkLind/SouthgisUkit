//
//  NSDate+SGS.m
//  ARKKit
//
//  Created by Lee on 16/4/20.
//  Copyright © 2016年 ARK. All rights reserved.
//

#import "NSDate+SGS.h"

@implementation NSDate (SGS)
///================================================================
///  MARK: 常用属性
///================================================================

// 年代
- (NSInteger)era {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitEra fromDate:self] era];
}

// 年份
- (NSInteger)year {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self] year];
}

// 月份 (1~12)
- (NSInteger)month {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self] month];
}

// 天 (1~31)
- (NSInteger)day {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self] day];
}

// 小时 (0~23)
- (NSInteger)hour {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self] hour];
}

// 分 (0~59)
- (NSInteger)minute {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self] minute];
}

// 秒 (0~59)
- (NSInteger)second {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] second];
}

// 纳秒
- (NSInteger)nanosecond {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitNanosecond fromDate:self] nanosecond];
}

// 星期
- (NSInteger)weekday {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self] weekday];
}

// 该月中的第几个周x
- (NSInteger)weekdayOrdinal {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekdayOrdinal fromDate:self] weekdayOrdinal];
}

// 该月份的第几周
- (NSInteger)weekOfMonth {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self] weekOfMonth];
}

// 该年的第几周
- (NSInteger)weekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:self] weekOfYear];
}

// 返回该日期的周的所在年份
- (NSInteger)yearForWeekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYearForWeekOfYear fromDate:self] yearForWeekOfYear];
}

// 当前年中的第几个季度
- (NSInteger)quarter {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] quarter];
}

// 是否是闰月
- (BOOL)isLeapMonth {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] isLeapMonth];
}

// 是否是闰年
- (BOOL)isLeapYear {
    NSUInteger year = self.year;
    return ((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0)));
}

// 判断日期是否是昨天
- (BOOL)isYesterday {
    NSDate *yesterday = [NSDate yesterday];
    if (yesterday == nil) return NO;
    
    return [self isEqualToDateIgnoringTime:yesterday];
}

// 判断日期是否是今天
- (BOOL)isToday {
    return [self isEqualToDateIgnoringTime:[NSDate date]];
}


// 判断日期是否是明天
- (BOOL)isTomorrow {
    NSDate *tomorrow = [NSDate tomorrow];
    if (tomorrow == nil) return NO;
    
    return [self isEqualToDateIgnoringTime:tomorrow];
}

// 判断日期是否是今年
- (BOOL)isThisYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    NSInteger thisYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    return selfYear == thisYear;
}


///================================================================
///  MARK: 日期比较与增减
///================================================================

// 获取当前时间戳
+ (NSTimeInterval)currentTimeStamp {
    return [NSDate dateWithTimeIntervalSinceNow:0.0].timeIntervalSince1970;
}

// 返回昨天此刻的日期
+ (nullable instancetype)yesterday {
    return [[NSDate date] dateByAddingDays:-1];
}

// 返回明天此刻的日期
+ (nullable instancetype)tomorrow {
    return [[NSDate date] dateByAddingDays:1];
}

// 在参照日期的基础上增加多少秒（使用负数来减少）
- (nullable NSDate*)dateByAddingSeconds:(NSTimeInterval)seconds {
    return [NSDate dateWithTimeInterval:seconds sinceDate:self];
}

// 在参照日期的基础上增加多少分钟（使用负数来减少）
- (nullable NSDate*)dateByAddingMinutes:(NSInteger)minutes {
    return [NSDate dateWithTimeInterval:(60 * minutes) sinceDate:self];
}

// 在参照日期的基础上增加多少小时（使用负数来减少）
- (nullable NSDate*)dateByAddingHours:(NSInteger)hours {
    return [NSDate dateWithTimeInterval:(3600 * hours) sinceDate:self];
}

// 在参照日期的基础上增加多少天（使用负数来减少天数）
- (nullable NSDate*)dateByAddingDays:(NSInteger)days {
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.day = days;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

// 在参照日期的基础上增加多少周（使用负数来减少周数）
- (nullable NSDate *)dateByAddingWeeks:(NSInteger)weeks {
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.weekOfYear = weeks;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

// 在参照日期的基础上增加多少月（用负数来减少月数）
- (nullable NSDate*)dateByAddingMonths:(NSInteger)months {
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.month = months;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

// 在参照日期的基础上增加多少年（用负数来减少年数）
- (nullable NSDate*)dateByAddingYears:(NSInteger)years {
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.year = years;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

// 与另一个日期判断是否是同一天
- (BOOL)isEqualToDateIgnoringTime:(nonnull NSDate *)date {
    NSCalendarUnit unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *selfComponents = [[NSCalendar currentCalendar] components:unitFlags fromDate:self];
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:unitFlags fromDate:date];
    return ((selfComponents.year == dateComponents.year) && (selfComponents.month == dateComponents.month) && (selfComponents.day == dateComponents.day));
}

// 比较两个日期之间的差值
+ (nonnull NSDateComponents *)deltaFromDate:(nonnull NSDate *)fromDate toDate:(nonnull NSDate *)toDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unitFlags fromDate:fromDate toDate:toDate options:NSCalendarWrapComponents];
}




///================================================================
///  MARK: 日期格式化
///================================================================

// 获取标准格式的日期字符串，格式为：2016-01-01T00:00:00+0800
- (nonnull NSString *)stringWithISOFormat {
    return [[NSDateFormatter isoFormatter] stringFromDate:self];
}

// 获取常用的日期字符串，格式为：2016-01-01 00:00:00
- (nonnull NSString *)stringWithRoutineFormat {
    return [[NSDateFormatter routineFormatter] stringFromDate:self];
}

// 获取常用的日期字符串，格式为：2016年1月1日
- (nonnull NSString *)stringWithYearMonthAndDayFormat {
    return [[NSDateFormatter yearMonthAndDayFormat] stringFromDate:self];
}

// 获取常用的日期字符串，格式为：1月1日
- (nonnull NSString *)stringWithMonthAndDayFormat {
    return [[NSDateFormatter monthAndDayFormat] stringFromDate:self];
}

// 获取常用的日期字符串，格式为：上午 9:30
- (nonnull NSString *)stringWithHourAndMinuteFormat {
    return [[NSDateFormatter hourAndMinuteFormat] stringFromDate:self];
}

/**
 * 将日期转为指定格式的字符串
 * 格式如下:
 *  今年
 *    今天
 *      1分钟内
 *          刚刚
 *      1小时内
 *          xx分钟前
 *      大于1小时
 *          xx小时前
 *    昨天
 *      昨天 18:56:34
 *    早于昨天, 根据参数 showThisYear 是否显示年份
 *      1月23日 19:56:23 或 2016年1月23日 19:56:23
 * 非今年
 *    2015年2月8日 18:45:30
 */
- (nonnull NSString *)StringWithCommonFormatAndShowThisYear:(BOOL)showThisYear {
    // 今天
    if (self.isToday) {
        NSDateComponents *cmps = [NSDate deltaFromDate:self toDate:[NSDate  date]];
        if (cmps.hour >= 1) {
            return [NSString stringWithFormat:@"%ld小时前", cmps.hour];
        } else if (cmps.minute >= 1) {
            return [NSString stringWithFormat:@"%ld分钟前", cmps.minute];
        } else if (cmps.second >= 0) {
            return @"刚刚";
        }
    }
    
    NSString *formatStr;
    if (self.isYesterday) {
        formatStr = @"昨天 HH:mm";
    } else if (self.isThisYear && (showThisYear == NO)) {
        formatStr = @"M月d日 HH:mm";
    } else {
        formatStr = @"yyyy年M月d日 HH:mm:ss";
    }
    return [self stringWithFormat:formatStr];
}

// 根据参数返回指定格式的日期字符串
- (nonnull NSString *)stringWithFormat:(nonnull NSString *)formatStr
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = formatStr;
    formatter.locale = [NSLocale currentLocale];
    return [formatter stringFromDate:self];
}

// 根据参数返回指定格式的日期字符串
- (nonnull NSString *)stringWithFormat:(nonnull NSString *)formatStr
                              timeZone:(nullable NSTimeZone *)timeZone
                                 locale:(nullable NSLocale *)locale
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = formatStr;
    [formatter setTimeZone:timeZone];
    [formatter setLocale:locale];
    return [formatter stringFromDate:self];
}

// 根据参数返回指定格式的日期
+ (nullable instancetype)dateWithString:(nonnull NSString *)dateString
                                 format:(nonnull NSString *)formatStr
{
    if (dateString == nil || dateString.length == 0) return nil;
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = formatStr;
    formatter.locale = [NSLocale currentLocale];
    return [formatter dateFromString:dateString];
}

// 根据参数返回指定格式的日期
+ (nullable instancetype)dateWithString:(nonnull NSString *)dateString
                                 format:(nonnull NSString *)formatStr
                               timeZone:(nullable NSTimeZone *)timeZone
                                 locale:(nullable NSLocale *)locale
{
    if (dateString == nil || dateString.length == 0) return nil;
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = formatStr;
    [formatter setTimeZone:timeZone];
    [formatter setLocale:locale];
    return [formatter dateFromString:dateString];
}

@end

@implementation NSDateFormatter (SGS)
// 获取标准日期格式的NSDateFormatter，格式为：2016-01-01T00:00:00+0800
+ (nonnull instancetype)isoFormatter {
    return [NSDateFormatter routineFormatByShowTSeparator:YES showTimeZone:YES];
}

// 获取常用日期格式的NSDateFormatter，格式为：2016-01-01 00:00:00
+ (nonnull instancetype)routineFormatter {
    return [NSDateFormatter routineFormatByShowTSeparator:NO showTimeZone:NO];
}

// 获取常用日期格式的NSDateFormatter，格式为：2016年1月1日
+ (nonnull instancetype)yearMonthAndDayFormat {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        formatter.locale = [NSLocale currentLocale];
        formatter.dateFormat = @"yyyy年M月d日";
    });
    return formatter;
}

// 获取常用日期格式的NSDateFormatter，格式为：1月1日
+ (nonnull instancetype)monthAndDayFormat {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        formatter.locale = [NSLocale currentLocale];
        formatter.dateFormat = @"M月d日";
    });
    return formatter;
}

// 获取常用日期格式的NSDateFormatter，格式为：上午 9:30
+ (nonnull instancetype)hourAndMinuteFormat {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        formatter.locale = [NSLocale currentLocale];
        formatter.AMSymbol = @"上午";
        formatter.PMSymbol = @"下午";
        formatter.dateFormat = @"a h:mm";
    });
    return formatter;
}

// 获取通用格式的NSDateFormatter
+ (nonnull instancetype)routineFormatByShowTSeparator:(BOOL)showTSeparator showTimeZone:(BOOL)showTimeZone {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        formatter.locale = [NSLocale currentLocale];
    });
    
    NSString *formatStr = @"yyyy-MM-dd";
    formatStr = (showTSeparator) ? [formatStr stringByAppendingString:@"'T'"] : [formatStr stringByAppendingString:@" "];
    formatStr = [formatStr stringByAppendingString:@"HH:mm:ss"];
    if (showTimeZone) formatStr = [formatStr stringByAppendingString:@"Z"];
    
    formatter.dateFormat = formatStr;
    return formatter;
}




@end
