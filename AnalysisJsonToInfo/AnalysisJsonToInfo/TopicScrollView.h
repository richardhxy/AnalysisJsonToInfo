//
//  TopicScrollView.h
//  zhixue
//
//  Created by iflytek on 15/4/24.
//  Copyright (c) 2015年 iflytek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TopicScrollView;
@protocol TopicScrollViewDelegate <NSObject>

- (void)topicScrollView:(TopicScrollView *)topicScrollView endSelected:(NSInteger)index;
- (void)topicScrollView:(TopicScrollView *)topicScrollView clickImage:(UIImageView *)imageView;
- (void)topicScrollView:(TopicScrollView *)topicScrollView topicCount:(NSInteger)count currentIndex:(NSInteger)index;

@end

@interface TopicScrollView : UIScrollView

@property (nonatomic) BOOL showRightAnswer;
@property (nonatomic) BOOL showAnalysis;
@property (strong, nonatomic) NSArray *dataSource;

@property (nonatomic) NSInteger currentIndex;

@property (weak, nonatomic) id<TopicScrollViewDelegate> topicScrollViewDelegate;

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource;
- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource showAnalysis:(BOOL)showAnalysis showRightAnswer:(BOOL)showRightAnswer;

- (void)showTopicAtIndex:(NSInteger)index;

@end
