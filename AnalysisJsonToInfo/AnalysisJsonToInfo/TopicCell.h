//
//  TopicCell.h
//  zhixue
//
//  Created by iflytek on 15/4/21.
//  Copyright (c) 2015年 iflytek. All rights reserved.
//
#import <DTCoreText.h>
#import <DTAttributedTextCell.h>
#import "TopicInfo.h"

@interface TopicCell : DTAttributedTextCell

@property (strong, nonatomic) SubTopic *accessory;

@end