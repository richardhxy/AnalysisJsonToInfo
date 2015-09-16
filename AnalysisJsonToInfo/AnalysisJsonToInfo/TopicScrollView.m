//
//  TopicScrollView.m
//  zhixue
//
//  Created by iflytek on 15/4/24.
//  Copyright (c) 2015年 iflytek. All rights reserved.
//
#import "TopicScrollView.h"
#import "TopicView.h"
#import "TopicTableView.h"
#import "TopicInfo.h"

@interface TopicScrollView () <UIScrollViewDelegate, TopicViewDelegate, TopicTableViewDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) NSMutableArray *topicCounts;
@property (strong, nonatomic) NSMutableArray *selectedTopicIndexs;

@property (nonatomic) BOOL leftScrollEnabled;
@property (nonatomic) BOOL rightScrollEnanbled;

@end

@implementation TopicScrollView

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource
{
    self = [self initWithFrame:frame dataSource:dataSource showAnalysis:NO showRightAnswer:NO];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource showAnalysis:(BOOL)showAnalysis showRightAnswer:(BOOL)showRightAnswer
{
    self = [super initWithFrame:frame];
    if (self) {
        _dataSource = dataSource;
        _showAnalysis = showAnalysis;
        _showRightAnswer = showRightAnswer;
        _currentIndex = 0;
        _leftScrollEnabled = YES;
        _rightScrollEnanbled = YES;
        _topicCounts = [[NSMutableArray alloc] initWithCapacity:20];
        _selectedTopicIndexs = [[NSMutableArray alloc] init];
        
//        self.scrollEnabled = NO;
        self.pagingEnabled = YES;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        for (NSInteger i = 0; i < dataSource.count; i ++) {
            [_selectedTopicIndexs addObject:@0];
            TopicInfo *topic = dataSource[i];
            if ([topic.topicDetail.material isEqualToString:@"<p></p>"]) {
                topic.topicDetail.material = nil;
            }
            if (topic.topicDetail.material) {
                [_topicCounts addObject:[NSNumber numberWithInteger:topic.topicDetail.subTopics.count]];
                TopicView *topicView = [[TopicView alloc] initWithFrame:CGRectMake(frame.size.width * i, 0, frame.size.width, frame.size.height)];
                topicView.tag = 666 + i;
                topicView.delegate = self;
                topicView.showAnalysis = showAnalysis;
                topicView.showRightAnswer = showRightAnswer;
                topicView.topic = topic;
                [self addSubview:topicView];
            }
            else
            {
                [_topicCounts addObject:[NSNumber numberWithInteger:topic.topicDetail.subTopics.count]];
                TopicTableView *topicTableView = [[TopicTableView alloc] initWithFrame:CGRectMake(frame.size.width * i, 0, frame.size.width, frame.size.height)];
                topicTableView.topicInfo = topic;
                topicTableView.tag = 666 + i;
                topicTableView.topicTableViewDelegate = self;
                if (showAnalysis) {
                    topicTableView.showAnalysis = YES;
                    topicTableView.analysisHtml = topic.topicDetail.analysisHtml;
                    if (topic.topicDetail.optionAnswer.count > 0) {
//                        topicTableView.optionAnswer = topic.topicDetail.optionAnswer[0];
                    }
                }
                topicTableView.showRightAnswer = showRightAnswer;
                topicTableView.subTopic = topic.topicDetail.subTopics[0];
                
                [self addSubview:topicTableView];
            }
        }
        self.contentSize = CGSizeMake(frame.size.width * dataSource.count, frame.size.height);
    }
    return self;
}

- (void)showNextTopic:(BOOL)animated
{
    int topicIndex = ceil(self.contentOffset.x/self.frame.size.width);
    if (topicIndex == _topicCounts.count - 1) {
        if (self.topicScrollViewDelegate && [self.topicScrollViewDelegate respondsToSelector:@selector(topicScrollView:endSelected:)]) {
            [self.topicScrollViewDelegate topicScrollView:self endSelected:topicIndex];
        }
        return;
    }
    UIView *view = [self viewWithTag:666 + topicIndex];
    if ([view isKindOfClass:[TopicView class]]) {
        TopicView *topicView = (TopicView *)view;
        if (![topicView showNextTopic:animated]) {
            [self setContentOffset:CGPointMake(self.frame.size.width * (topicIndex + 1), 0) animated:animated];
        }
    }
    else if ([view isKindOfClass:[TopicTableView class]]) {
        [self setContentOffset:CGPointMake(self.frame.size.width * (topicIndex + 1), 0) animated:animated];
    }
}

- (void)showTopicAtIndex:(NSInteger)index
{
    NSInteger count = 0;
    for (NSInteger i = 0; i < _topicCounts.count; i ++) {
        count += [_topicCounts[i] integerValue];
        if (index <= count - 1) {
            [self setContentOffset:CGPointMake(self.frame.size.width * i, 0)];
            count -= [_topicCounts[i] integerValue];
            UIView *view = [self viewWithTag:666 + i];
            if ([view isKindOfClass:[TopicView class]]) {
                TopicView *topicView = (TopicView *)view;
                [topicView showTopicAtIndex:index - count];
            }
            break;
        }
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    TopicInfo *topic = _dataSource[_currentIndex];
    if ([topic.topicDetail.material isEqualToString:@"<p></p>"]) {
        topic.topicDetail.material = nil;
    }
    if (topic.topicDetail.material) {
        if (!_leftScrollEnabled) {
            CGFloat xOffset = scrollView.contentOffset.x;
            if (xOffset <= scrollView.frame.size.width * _currentIndex) {
                scrollView.scrollEnabled = YES;
                scrollView.scrollEnabled = YES;
//                if (xOffset != scrollView.frame.size.width * _currentIndex) {
//                    UIView *view = [self viewWithTag:666 + _currentIndex];
//                    if ([view isKindOfClass:[TopicView class]]) {
//                        TopicView *topicView = (TopicView *)view;
//                        [topicView showPreviousTopic:YES];
//                    }
//                }
            }
        }
        if (!_rightScrollEnanbled) {
            CGFloat xOffset = scrollView.contentOffset.x;
            if (xOffset >= scrollView.frame.size.width * _currentIndex) {
                scrollView.scrollEnabled = YES;
                scrollView.scrollEnabled = YES;
//                if (xOffset != scrollView.frame.size.width * _currentIndex) {
//                    UIView *view = [self viewWithTag:666 + _currentIndex];
//                    if ([view isKindOfClass:[TopicView class]]) {
//                        TopicView *topicView = (TopicView *)view;
//                        [topicView showNextTopic:YES];
//                    }
//                }
            }
        }
    }

    CGFloat xOffset = scrollView.contentOffset.x;
    CGFloat width = SCREEN_WIDTH;
    int index = floor((xOffset + width/2)/width);
    if (_currentIndex != index) {
        if ([[self viewWithTag:666 + index] isKindOfClass:[TopicView class]] && [_topicCounts[index] integerValue] > 1) {
            if (_currentIndex < index) {
                _leftScrollEnabled = YES;
                _rightScrollEnanbled = NO;
            }
            else {
                _leftScrollEnabled = NO;
                _rightScrollEnanbled = YES;
            }
        }

        _currentIndex = index;
        if (self.topicScrollViewDelegate && [self.topicScrollViewDelegate respondsToSelector:@selector(topicScrollView:topicCount:currentIndex:)]) {
            NSInteger topicCount = 0;
            NSInteger currentIndex = 0;
            for (NSInteger i = 0; i < _topicCounts.count; i ++) {
                NSInteger count = [_topicCounts[i] integerValue];
                topicCount += count;
                if (i < index) {
                    currentIndex += count;
                }
            }
            currentIndex += [_selectedTopicIndexs[index] integerValue];
            [self.topicScrollViewDelegate topicScrollView:self topicCount:topicCount currentIndex:currentIndex];
        }
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    
}

#pragma mark - TopicViewDelegate
- (void)topicView:(TopicView *)topicView didSelecetedOption:(NSInteger)index
{
    [self showNextTopic:YES];
}

- (void)topicView:(TopicView *)topicView clickImage:(UIImageView *)imageView
{
    if (self.topicScrollViewDelegate && [self.topicScrollViewDelegate respondsToSelector:@selector(topicScrollView:clickImage:)]) {
        [self.topicScrollViewDelegate topicScrollView:self clickImage:imageView];
    }
}

- (void)topicView:(TopicView *)topicView topicCount:(NSInteger)count currentIndex:(NSInteger)index
{
    if (count >= 2) {
        if (index == 0) {
            _leftScrollEnabled = YES;
            _rightScrollEnanbled = NO;
        }
        else if (index == count - 1) {
            _leftScrollEnabled = NO;
            _rightScrollEnanbled = YES;
        }
        else {
            _leftScrollEnabled = NO;
            _rightScrollEnanbled = NO;
        }
    }
    int topicIndex = ceil(topicView.frame.origin.x/self.frame.size.width);
    [_selectedTopicIndexs replaceObjectAtIndex:topicIndex withObject:@(index)];
    if (self.topicScrollViewDelegate && [self.topicScrollViewDelegate respondsToSelector:@selector(topicScrollView:topicCount:currentIndex:)]) {
        NSInteger topicCount = 0;
        NSInteger currentIndex = 0;
        for (NSInteger i = 0; i < _topicCounts.count; i ++) {
            NSInteger count = [_topicCounts[i] integerValue];
            topicCount += count;
            if (i < topicIndex) {
                currentIndex += count;
            }
            if (i == topicIndex) {
                currentIndex += index;
            }
        }
        
        [self.topicScrollViewDelegate topicScrollView:self topicCount:topicCount currentIndex:currentIndex];
    }
}

#pragma mark - TopicTableViewDelegate
- (void)topicTableView:(TopicTableView *)topicTableView didSelecetedOption:(NSInteger)index
{
    [self showNextTopic:YES];
}

- (void)topicTableView:(TopicTableView *)topicTableView clickImage:(UIImageView *)imageView
{
    if (self.topicScrollViewDelegate && [self.topicScrollViewDelegate respondsToSelector:@selector(topicScrollView:clickImage:)]) {
        [self.topicScrollViewDelegate topicScrollView:self clickImage:imageView];
    }
}

- (void)topicView:(TopicView *)topicView swipeGestureRecognizer:(UISwipeGestureRecognizer *)sender
{
//    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
//        if (![topicView showNextTopic:YES]) {
//            [self showNextTopic:YES];
//        }
//    }
//    else {
//        if ([topicView showPreviousTopic:YES]) {
//            
//        }
//    }
}

#pragma mark - UIGestureRecognizerDelegate

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    return YES;
//}

@end
