//
//  NSString+TopicHtml.m
//  zhixue
//
//  Created by iflytek on 15/4/21.
//  Copyright (c) 2015年 iflytek. All rights reserved.
//

#import "NSString+TopicHtml.h"

@implementation NSString (TopicHtml)

+ (NSString *)topicHtmlWithString:(NSString *)string
{
    NSMutableArray *array = [NSMutableArray array];
    if (string.length > 14) {
        for (NSInteger i = 0; i < string.length - 6; i ++) {
            NSString *rangeString = [string substringWithRange:NSMakeRange(i, 6)];
            if ([rangeString isEqualToString:@" align"]) {
                NSInteger count = 0;
                for (NSInteger j = i + 7; j < string.length - 1; j ++) {
                    char c = [string characterAtIndex:j];
                    if (c == '\"') {
                        count ++;
                        if (count == 2) {
                            [array addObject:[NSValue valueWithRange:NSMakeRange(i + 1, j - i)]];
                            break;
                        }
                    }
                }
            }
        }
    }
    NSMutableString *mutableString = [NSMutableString stringWithString:string];
    for (NSInteger i = array.count - 1; i >= 0; i --) {
        [mutableString replaceCharactersInRange:[array[i] rangeValue] withString:@"style=\"vertical-align:middle\""];
    }
    return [NSString stringWithFormat:@"<div style=\"font-size:15px; padding: 8px; vertical-align: middle\">%@</div>", mutableString];
}


+ (NSString *)picArrayToString:(NSArray *)picArray {
    NSMutableString *mutableStr = [[NSMutableString alloc]init];
    if ([picArray count] == 0) {
        return [NSString stringWithString:mutableStr];
    }
    for (Pic *pic in picArray) {
        [mutableStr appendFormat:@"<img src=\"%@\">",pic.url];
    }
    return [NSString stringWithString:mutableStr];
}

@end
