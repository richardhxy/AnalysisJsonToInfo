//
//  TopicAnswerCell.h
//  zhixue
//
//  Created by iflytek on 15/4/28.
//  Copyright (c) 2015年 iflytek. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface TopicAnswerCell : BaseTableViewCell

- (void)setRightAnswer:(NSString *)right;
- (void)setRightAnswer:(NSString *)right selectedAnswer:(NSString *)selected showRightAnswer:(BOOL)showRightAnswer;

- (CGFloat)requiredRowHeightInTableView:(UITableView *)tableView;

@end
