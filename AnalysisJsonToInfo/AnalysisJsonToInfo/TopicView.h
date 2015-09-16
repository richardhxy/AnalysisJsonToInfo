//
//  TopicView.h
//  zhixue
//
//  Created by iflytek on 15/4/23.
//  Copyright (c) 2015年 iflytek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicInfo.h"
#import <DTCoreText.h>

@class TopicView;
@protocol TopicViewDelegate <NSObject>

- (void)topicView:(TopicView *)topicView didSelecetedOption:(NSInteger)index;
- (void)topicView:(TopicView *)topicView clickImage:(UIImageView *)imageView;
- (void)topicView:(TopicView *)topicView topicCount:(NSInteger)count currentIndex:(NSInteger)index;

- (void)topicView:(TopicView *)topicView swipeGestureRecognizer:(UISwipeGestureRecognizer *)sender;

@end

@interface TopicView : UIView<DTLazyImageViewDelegate>

@property (nonatomic) BOOL showRightAnswer;
@property (nonatomic) BOOL showAnalysis;
@property (strong, nonatomic) NSString *material;
@property (strong, nonatomic) TopicInfo *topic;

@property (weak, nonatomic) id<TopicViewDelegate, UIGestureRecognizerDelegate> delegate;

- (BOOL)showPreviousTopic:(BOOL)animated;
- (BOOL)showNextTopic:(BOOL)animated;
- (void)showTopicAtIndex:(NSInteger)index;

@end
