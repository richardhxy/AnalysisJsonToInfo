//
//  TopicTableView.h
//  zhixue
//
//  Created by iflytek on 15/4/20.
//  Copyright (c) 2015年 iflytek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DTCoreText.h>
#import "TopicInfo.h"

@class TopicTableView;
@protocol TopicTableViewDelegate <NSObject>

- (void)topicTableView:(TopicTableView *)topicTableView didSelecetedOption:(NSInteger)index;
- (void)topicTableView:(TopicTableView *)topicTableView clickImage:(UIImageView *)imageView;

@end

@interface TopicTableView : UITableView <UITableViewDataSource, UITableViewDelegate, DTAttributedTextContentViewDelegate, DTLazyImageViewDelegate>

@property (nonatomic) BOOL showRightAnswer;
//@property (strong, nonatomic) OptionAnswer *optionAnswer;
@property (strong, nonatomic) NSString *analysisHtml;
@property (nonatomic) BOOL showAnalysis;
@property (nonatomic,strong) TopicInfo *topicInfo;
@property (strong, nonatomic) SubTopic *subTopic;

@property (weak, nonatomic) id<TopicTableViewDelegate> topicTableViewDelegate;

@end
