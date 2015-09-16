//
//  NSString+TopicHtml.h
//  zhixue
//
//  Created by iflytek on 15/4/21.
//  Copyright (c) 2015年 iflytek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopicInfo.h"

@interface NSString (TopicHtml)

+ (NSString *)topicHtmlWithString:(NSString *)string;

+ (NSString *)picArrayToString:(NSArray *)picArray;

@end
