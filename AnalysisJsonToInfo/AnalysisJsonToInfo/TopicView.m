//
//  TopicView.m
//  zhixue
//
//  Created by iflytek on 15/4/23.
//  Copyright (c) 2015年 iflytek. All rights reserved.
//

#import "TopicView.h"
#import "TopicTableView.h"
#import <DTCoreText.h>
#import "NSString+TopicHtml.h"
#import "DTLazyImageView+AttributedTextContentView.h"

@interface TopicView () <DTAttributedTextContentViewDelegate, UIScrollViewDelegate, TopicTableViewDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) DTAttributedTextView *textView;
@property (strong, nonatomic) UIView *topicView;
@property (strong, nonatomic) UIImageView *tapImageView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) TopicTableView *leftTableView;
@property (strong, nonatomic) TopicTableView *centerTableView;
@property (strong, nonatomic) TopicTableView *rightTableView;

@property (nonatomic) NSInteger topicCount;
@property (nonatomic) NSInteger currentIndex;
@property (strong, nonatomic) NSMutableArray *yOffsets;

@property (strong, nonatomic) UISwipeGestureRecognizer *leftSwipe;
@property (strong, nonatomic) UISwipeGestureRecognizer *rightSwipe;

@end

@implementation TopicView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGB(240, 240, 240);
        
        _currentIndex = 0;
        _topicCount = 0;
        
        _textView = [[DTAttributedTextView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height/2)];
        _textView.attributedTextContentView.edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        _textView.backgroundColor = [UIColor clearColor];
        _textView.tag = 11111;
        _textView.textDelegate = self;
        [self addSubview:_textView];
        
        _leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
        _leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
        [_textView addGestureRecognizer:_leftSwipe];
        
        _rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
        _rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
        [_textView addGestureRecognizer:_rightSwipe];
        
        UIImage *image = [UIImage imageNamed:@"topic_pan"];
        
        _topicView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_textView.frame) - image.size.height, frame.size.width, frame.size.height/2 + image.size.height)];
        _topicView.backgroundColor = [UIColor clearColor];
        [self addSubview:_topicView];
        
        _tapImageView = [[UIImageView alloc] initWithImage:image];
        _tapImageView.frame = CGRectMake((frame.size.width - image.size.width)/2, 0, image.size.width, image.size.height);
        _tapImageView.userInteractionEnabled = YES;
        [_topicView addSubview:_tapImageView];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        [_tapImageView addGestureRecognizer:pan];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_tapImageView.frame), frame.size.width, CGRectGetHeight(_topicView.frame) - CGRectGetHeight(_tapImageView.frame))];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
//        _scrollView.scrollEnabled = NO;
        [_topicView addSubview:_scrollView];
        
    }
    return self;
}

#pragma mark - setter
- (void)setTopic:(TopicInfo *)topic
{
    _topic = topic;
    
    _topicCount = topic.topicDetail.subTopics.count;
    _yOffsets = [[NSMutableArray alloc] initWithCapacity:_topicCount];
    for (NSInteger i = 0; i < _topicCount; i ++) {
        [_yOffsets addObject:@0.0f];
    }
    if (_topicCount == 1) {
        if (_showAnalysis) {
            if (_topic.topicDetail.optionAnswer.count >= 1) {
//                self.leftTableView.optionAnswer = _topic.topicDetail.optionAnswer[0];
            }
            self.leftTableView.analysisHtml = _topic.topicDetail.analysisHtml;
            self.leftTableView.showAnalysis = YES;
        }
        self.leftTableView.showRightAnswer = _showRightAnswer;
        self.leftTableView.subTopic = _topic.topicDetail.subTopics[0];
        self.leftTableView.topicInfo = topic;
        _scrollView.contentSize = CGSizeMake(self.frame.size.width, _scrollView.frame.size.height);
    }
    else if (_topicCount == 2) {
        if (_showAnalysis) {
            if (_topic.topicDetail.optionAnswer.count >= 2) {
//                self.leftTableView.optionAnswer = _topic.topicDetail.optionAnswer[0];
//                self.centerTableView.optionAnswer = _topic.topicDetail.optionAnswer[1];
            }
            self.leftTableView.analysisHtml = _topic.topicDetail.analysisHtml;
            self.leftTableView.showAnalysis = YES;
            self.centerTableView.analysisHtml = _topic.topicDetail.analysisHtml;
            self.centerTableView.showAnalysis = YES;
        }
        self.leftTableView.showRightAnswer = _showRightAnswer;
        self.centerTableView.showRightAnswer = _showRightAnswer;
        self.leftTableView.subTopic = _topic.topicDetail.subTopics[0];
        self.centerTableView.subTopic = _topic.topicDetail.subTopics[1];
        self.leftTableView.topicInfo = topic;
        self.centerTableView.topicInfo = topic;
        _scrollView.contentSize = CGSizeMake(self.frame.size.width * 2, _scrollView.frame.size.height);
    }
    else {
        if (_showAnalysis) {
            if (_topic.topicDetail.optionAnswer.count >= 3) {
//                self.leftTableView.optionAnswer = _topic.topicDetail.optionAnswer[0];
//                self.centerTableView.optionAnswer = _topic.topicDetail.optionAnswer[1];
//                self.rightTableView.optionAnswer = _topic.topicDetail.optionAnswer[2];
            }
            self.leftTableView.analysisHtml = _topic.topicDetail.analysisHtml;
            self.leftTableView.showAnalysis = YES;
            self.centerTableView.analysisHtml = _topic.topicDetail.analysisHtml;
            self.centerTableView.showAnalysis = YES;
            self.rightTableView.analysisHtml = _topic.topicDetail.analysisHtml;
            self.rightTableView.showAnalysis = YES;
        }
        self.leftTableView.showRightAnswer = _showRightAnswer;
        self.centerTableView.showRightAnswer = _showRightAnswer;
        self.rightTableView.showRightAnswer = _showRightAnswer;
        self.leftTableView.subTopic = _topic.topicDetail.subTopics[0];
        self.centerTableView.subTopic = _topic.topicDetail.subTopics[1];
        self.rightTableView.subTopic = _topic.topicDetail.subTopics[2];
        
        _scrollView.contentSize = CGSizeMake(self.frame.size.width * 3, _scrollView.frame.size.height);
    }
    self.material = topic.topicDetail.material;
}

- (void)setMaterial:(NSString *)material
{
    NSString *html = [NSString topicHtmlWithString:material];
    NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:nil documentAttributes:NULL];
    _textView.attributedString = string;
}

- (void)setDelegate:(id<TopicViewDelegate,UIGestureRecognizerDelegate>)delegate
{
    _delegate = delegate;
    _leftSwipe.delegate = self;
    _rightSwipe.delegate = self;
}

#pragma mark - getter

- (TopicTableView *)leftTableView
{
    if (!_leftTableView) {
        _leftTableView = [[TopicTableView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
        _leftTableView.topicTableViewDelegate = self;
        _leftTableView.topicInfo = _topic;
        [_scrollView addSubview:_leftTableView];
    }
    return _leftTableView;
}

- (TopicTableView *)centerTableView
{
    if (!_centerTableView) {
        _centerTableView = [[TopicTableView alloc] initWithFrame:CGRectMake(_scrollView.bounds.size.width, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
        _centerTableView.topicTableViewDelegate = self;
        _centerTableView.topicInfo = _topic;
        [_scrollView addSubview:_centerTableView];
    }
    return _centerTableView;
}

- (TopicTableView *)rightTableView
{
    if (!_rightTableView) {
        _rightTableView = [[TopicTableView alloc] initWithFrame:CGRectMake(_scrollView.bounds.size.width * 2, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
        _rightTableView.topicTableViewDelegate = self;
        _rightTableView.topicInfo = _topic;
        [_scrollView addSubview:_rightTableView];
    }
    return _rightTableView;
}

#pragma mark - action

- (void)panAction:(UIPanGestureRecognizer *)sender
{
    CGPoint point = [sender translationInView:_topicView];
    CGRect frame = _textView.frame;
    CGFloat height = frame.size.height + point.y;
    if (height > self.frame.size.height) {
        frame.size.height = self.frame.size.height;
        _textView.frame = frame;
        
    }
    else if (height < 60) {
        frame.size.height = 60;
        _textView.frame = frame;
    }
    else {
        frame.size.height = frame.size.height + point.y;
        _textView.frame = frame;
    }
    [sender setTranslation:CGPointZero inView:self];
    [self textViewChangeToFrameChange:_textView.frame];
    
}

- (void)swipeAction:(UISwipeGestureRecognizer *)sender
{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(topicView:swipeGestureRecognizer:)]) {
//        [self.delegate topicView:self swipeGestureRecognizer:sender];
//    }
//    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
//        [self showNextTopic:YES];
//    }
//    else {
//        [self showPreviousTopic:YES];
//    }
}

#pragma mark - private

- (void)textViewChangeToFrameChange:(CGRect)frame
{
    _topicView.frame = CGRectMake(0, CGRectGetMaxY(_textView.frame) - CGRectGetHeight(_tapImageView.frame), frame.size.width, CGRectGetHeight(self.frame) - CGRectGetHeight(_textView.frame) + CGRectGetHeight(_tapImageView.frame));
    _tapImageView.center = CGPointMake(_topicView.frame.size.width/2, _tapImageView.frame.size.height/2);
    _scrollView.frame = CGRectMake(0, CGRectGetMaxY(_tapImageView.frame), frame.size.width, CGRectGetHeight(_topicView.frame) - CGRectGetHeight(_tapImageView.frame));
    [self scrollViewChangeToFrameChange:_scrollView.frame];
}

- (void)scrollViewChangeToFrameChange:(CGRect)frame
{
    _scrollView.contentSize = CGSizeMake(frame.size.width * (_topicCount > 3 ? 3 : _topicCount), frame.size.height);
    _leftTableView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    _centerTableView.frame = CGRectMake(frame.size.width, 0, frame.size.width, frame.size.height);
    _rightTableView.frame = CGRectMake(frame.size.width * 2, 0, frame.size.width, frame.size.height);
}

#pragma mark - public

- (BOOL)showPreviousTopic:(BOOL)animated
{
    if (_currentIndex == 0) {
        return NO;
    }
    else {
        if (_topicCount == 2) {
            [UIView animateWithDuration:0.25 animations:^{
                _scrollView.contentOffset = CGPointMake(0, 0);
            } completion:^(BOOL finished) {
                [self scrollViewDidEndDecelerating:_scrollView];
            }];
        }
        else {
            [UIView animateWithDuration:0.25 animations:^{
                _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width * (_currentIndex == _topicCount - 1 ? 1 : 0), 0);
            } completion:^(BOOL finished) {
                [self scrollViewDidEndDecelerating:_scrollView];
            }];
        }
        return YES;
    }
}

- (BOOL)showNextTopic:(BOOL)animated
{
    if (_currentIndex == _topicCount - 1) {
        return NO;
    }
    else {
        [UIView animateWithDuration:0.25 animations:^{
            _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width * (_currentIndex == 0 ? 1 : 2), 0);
        } completion:^(BOOL finished) {
            [self scrollViewDidEndDecelerating:_scrollView];
        }];
        return YES;
    }
}

- (void)showTopicAtIndex:(NSInteger)index
{
    _currentIndex = index;
    if (_topicCount <= 3) {
        _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width * index, 0);
    }
    else {
        if (index == 0) {
//            if (_showAnalysis) {
//                self.leftTableView.optionAnswer = _topic.topicDetail.optionAnswer[0];
//                self.centerTableView.optionAnswer = _topic.topicDetail.optionAnswer[1];
//                self.rightTableView.optionAnswer = _topic.topicDetail.optionAnswer[2];
//            }
            _leftTableView.subTopic = _topic.topicDetail.subTopics[0];
            _centerTableView.subTopic = _topic.topicDetail.subTopics[1];
            _rightTableView.subTopic = _topic.topicDetail.subTopics[2];
        }
        else if (index == _topicCount - 1) {
//            if (_showAnalysis) {
//                self.leftTableView.optionAnswer = _topic.topicDetail.optionAnswer[index - 2];
//                self.centerTableView.optionAnswer = _topic.topicDetail.optionAnswer[index - 1];
//                self.rightTableView.optionAnswer = _topic.topicDetail.optionAnswer[index];
//            }
            _leftTableView.subTopic = _topic.topicDetail.subTopics[index - 2];
            _centerTableView.subTopic = _topic.topicDetail.subTopics[index - 1];
            _rightTableView.subTopic = _topic.topicDetail.subTopics[index];
        }
        else {
//            if (_showAnalysis) {
//                self.leftTableView.optionAnswer = _topic.topicDetail.optionAnswer[index - 1];
//                self.centerTableView.optionAnswer = _topic.topicDetail.optionAnswer[index];
//                self.rightTableView.optionAnswer = _topic.topicDetail.optionAnswer[index - 1];
//            }
            _leftTableView.subTopic = _topic.topicDetail.subTopics[index - 1];
            _centerTableView.subTopic = _topic.topicDetail.subTopics[index];
            _rightTableView.subTopic = _topic.topicDetail.subTopics[index - 1];
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(topicView:topicCount:currentIndex:)]) {
        [self.delegate topicView:self topicCount:_topicCount currentIndex:_currentIndex];
    }
}

#pragma mark - delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat xOffset = scrollView.contentOffset.x;
    if (xOffset <= 0 || xOffset >= scrollView.frame.size.width * 2) {
        scrollView.scrollEnabled = NO;
        scrollView.scrollEnabled = YES;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_topicCount > 3) {
        
        if (scrollView.contentOffset.x == 0 && _currentIndex != 0) {
            [_yOffsets replaceObjectAtIndex:_currentIndex withObject:[NSNumber numberWithFloat:_centerTableView.contentOffset.y]];
            _currentIndex = (_currentIndex - 1)%_topicCount;
        }
        else if (scrollView.contentOffset.x == scrollView.frame.size.width * 2 && _currentIndex != _topicCount - 1) {
            [_yOffsets replaceObjectAtIndex:_currentIndex withObject:[NSNumber numberWithFloat:_centerTableView.contentOffset.y]];
            _currentIndex = (_currentIndex + 1)%_topicCount;
        }
        else if (scrollView.contentOffset.x == scrollView.frame.size.width) {
            if (_currentIndex == 0) {
                [_yOffsets replaceObjectAtIndex:_currentIndex withObject:[NSNumber numberWithFloat:_leftTableView.contentOffset.y]];
                _currentIndex ++;
            }
            else if (_currentIndex == _topicCount -1) {
                [_yOffsets replaceObjectAtIndex:_currentIndex withObject:[NSNumber numberWithFloat:_rightTableView.contentOffset.y]];
                _currentIndex --;
            }
            if (self.delegate && [self.delegate respondsToSelector:@selector(topicView:topicCount:currentIndex:)]) {
                [self.delegate topicView:self topicCount:_topicCount currentIndex:_currentIndex];
            }
            return;
        }
        else {
            return;
        }
        
        if (_currentIndex > 0 && _currentIndex < _topicCount - 1) {
            if (_showAnalysis) {
//                self.leftTableView.optionAnswer = _topic.topicDetail.optionAnswer[(_currentIndex - 1)%_topicCount];
//                self.centerTableView.optionAnswer = _topic.topicDetail.optionAnswer[_currentIndex%_topicCount];
//                self.rightTableView.optionAnswer = _topic.topicDetail.optionAnswer[(_currentIndex + 1)%_topicCount];
            }
            _leftTableView.subTopic = _topic.topicDetail.subTopics[(_currentIndex - 1)%_topicCount];
            _centerTableView.subTopic = _topic.topicDetail.subTopics[_currentIndex%_topicCount];
            _rightTableView.subTopic = _topic.topicDetail.subTopics[(_currentIndex + 1)%_topicCount];
            
            _leftTableView.contentOffset = CGPointMake(0, [[_yOffsets objectAtIndex:_currentIndex - 1] floatValue]);
            _centerTableView.contentOffset = CGPointMake(0, [[_yOffsets objectAtIndex:_currentIndex] floatValue]);
            _rightTableView.contentOffset = CGPointMake(0, [[_yOffsets objectAtIndex:_currentIndex + 1] floatValue]);
            
            scrollView.contentOffset = CGPointMake(scrollView.frame.size.width, 0);
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(topicView:topicCount:currentIndex:)]) {
            [self.delegate topicView:self topicCount:_topicCount currentIndex:_currentIndex];
        }
    }
    else {
        if (scrollView.contentOffset.x == 0) {
            _currentIndex = 0;
        }
        else if (scrollView.contentOffset.x == scrollView.frame.size.width) {
            _currentIndex = 1;
        }
        else if (scrollView.contentOffset.x == scrollView.frame.size.width * 2) {
            _currentIndex = 2;
        }
        else {
            return;
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(topicView:topicCount:currentIndex:)]) {
            [self.delegate topicView:self topicCount:_topicCount currentIndex:_currentIndex];
        }
    }

}

#pragma mark - TopicTableViewDelegate
- (void)topicTableView:(TopicTableView *)topicTableView didSelecetedOption:(NSInteger)index
{
    if (_currentIndex == _topicCount - 1) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(topicView:didSelecetedOption:)]) {
            [self.delegate topicView:self didSelecetedOption:index];
        }
    }
    else {
        [self showNextTopic:YES];
    }
}

- (void)topicTableView:(TopicTableView *)topicTableView clickImage:(UIImageView *)imageView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(topicView:clickImage:)]) {
        [self.delegate topicView:self clickImage:imageView];
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma mark - DTAttributedTextContentViewDelegate
- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttachment:(DTTextAttachment *)attachment frame:(CGRect)frame
{
    if ([attachment isKindOfClass:[DTImageTextAttachment class]]) {
        if (CGRectGetWidth(frame) > CGRectGetWidth(attributedTextContentView.frame) - 20) {
            
            CGFloat scale = CGRectGetWidth(frame)/(CGRectGetWidth(attributedTextContentView.frame) - 20);
            CGFloat height = CGRectGetHeight(frame)/scale;
            
            DTLazyImageView *imageView = [[DTLazyImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(attributedTextContentView.frame) - 20, height)];
            imageView.delegate = self;
            imageView.attributedTextContentView = attributedTextContentView;
            imageView.image = [(DTImageTextAttachment *)attachment image];
            //            imageView.contentMode = UIViewContentModeScaleToFill;
            imageView.url = attachment.contentURL;
            imageView.userInteractionEnabled = YES;
            DTLinkButton *button = [[DTLinkButton alloc] initWithFrame:imageView.bounds];
            button.URL = attachment.hyperLinkURL;
            button.minimumHitSize = CGSizeMake(25, 25);
            button.GUID = attachment.hyperLinkGUID;
            [button addTarget:self action:@selector(clickImageAction:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
            
            return imageView;
        }
        else {
            DTLazyImageView *imageView = [[DTLazyImageView alloc] initWithFrame:frame];
            imageView.image = [(DTImageTextAttachment *)attachment image];
            imageView.delegate = self;
            imageView.attributedTextContentView = attributedTextContentView;
            imageView.url = attachment.contentURL;
            imageView.userInteractionEnabled = YES;
            DTLinkButton *button = [[DTLinkButton alloc] initWithFrame:imageView.bounds];
            button.URL = attachment.hyperLinkURL;
            button.minimumHitSize = CGSizeMake(25, 25);
            button.GUID = attachment.hyperLinkGUID;
            [button addTarget:self action:@selector(clickImageAction:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
            return imageView;
        }
        
    }
    return nil;
}

#pragma mark - DTAttributedTextContentViewDelegate
- (void)lazyImageView:(DTLazyImageView *)lazyImageView didChangeImageSize:(CGSize)size
{
    NSURL *url = lazyImageView.url;
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"contentURL == %@", url];
    
    CGSize imageSize = size;
    DTAttributedTextContentView *attributedTextContentView = [lazyImageView attributedTextContentView];
    if (size.width > CGRectGetWidth(attributedTextContentView.frame) - 20 && attributedTextContentView) {
        CGFloat scale = size.width/(CGRectGetWidth(attributedTextContentView.frame) - 20);
        CGFloat height = size.height/scale;
        imageSize = CGSizeMake(CGRectGetWidth(attributedTextContentView.frame) - 20, height);
    }
    
    for (DTTextAttachment *oneAttachment in [lazyImageView.attributedTextContentView.layoutFrame textAttachmentsWithPredicate:pred]) {
        oneAttachment.originalSize = imageSize;
        if (!CGSizeEqualToSize(imageSize, oneAttachment.displaySize)) {
            oneAttachment.displaySize = imageSize;
        }
    }
    
    attributedTextContentView.layouter = nil;
    [attributedTextContentView relayoutText];
}


@end

