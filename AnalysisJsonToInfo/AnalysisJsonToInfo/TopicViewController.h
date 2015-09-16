//
//  TopicViewController.h
//  zhixue
//
//  Created by iflytek on 15/4/16.
//  Copyright (c) 2015年 iflytek. All rights reserved.
//

#import "BaseViewController.h"

#import <WCAlertView.h>
#import <JTSImageViewController.h>

@interface TopicViewController : BaseViewController

@property (nonatomic) NSInteger topicSetCategory;
@property (nonatomic) BOOL showRightAnswer;
@property (nonatomic) BOOL showAnalysis;

@property (strong, nonatomic) NSString *subjectCode;
@property (strong, nonatomic) NSString *subjectName;
@property (strong, nonatomic) NSString *bookCode;

@property (strong, nonatomic) NSArray *dataSource;

- (void)showTopicAtIndex:(NSInteger)index;

@end
