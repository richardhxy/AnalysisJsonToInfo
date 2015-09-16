//
//  TopicAnswerCell.m
//  zhixue
//
//  Created by iflytek on 15/4/28.
//  Copyright (c) 2015年 iflytek. All rights reserved.
//

#import "TopicAnswerCell.h"

#define TOPIC_ANSWER_CELL_HEIGHT 60

@interface TopicAnswerCell ()

@property (strong, nonatomic) UILabel *answerLabel;

@end

@implementation TopicAnswerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGFloat width = SCREEN_WIDTH;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 6, 16, 16)];
        imageView.image = [UIImage imageNamed:@"topic_answer"];
        [self.contentView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 8, 0, 200, CGRectGetMinY(imageView.frame) * 2 + CGRectGetHeight(imageView.frame))];
        label.font = FontSize(14.0f);
        label.text = @"正确答案";
        [self.contentView addSubview:label];
        
        _answerLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(label.frame), CGRectGetMaxY(label.frame), width - CGRectGetMinX(label.frame), 20)];
        _answerLabel.text = @"略";
        _answerLabel.font = FontSize(14.0f);
        [self.contentView addSubview:_answerLabel];
    }
    return self;
}

- (void)setRightAnswer:(NSString *)right
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"正确答案是"];
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:right attributes:@{NSForegroundColorAttributeName: RGB(62, 195, 165)}]];
        [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"。" attributes:@{}]];
    _answerLabel.attributedText = string;
}

- (void)setRightAnswer:(NSString *)right selectedAnswer:(NSString *)selected showRightAnswer:(BOOL)showRightAnswer
{
    if ([selected isEqualToString:@"X"]) {
        selected = nil;
    }
    if ([selected isEqualToString:@"O"]) {
        selected = @"多选";
    }
    if (!showRightAnswer) {
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
        if (selected.length == 0) {
            [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"您未作答。"]];
        }
        else if ([right isEqualToString:selected]) {
            [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"回答正确。"]];
        }
        else {
            [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"您的答案是"]];
            [string appendAttributedString:[[NSAttributedString alloc] initWithString:selected attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}]];
            [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"，回答错误。"]];
        }
        _answerLabel.attributedText = string;
    }
    
    else {
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"正确答案是"];
        if (selected.length == 0) {
            [string appendAttributedString:[[NSAttributedString alloc] initWithString:right attributes:@{NSForegroundColorAttributeName: RGB(62, 195, 165)}]];
            [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"，您未作答。"]];
        }
        else if ([right isEqualToString:selected]) {
            [string appendAttributedString:[[NSAttributedString alloc] initWithString:right attributes:@{NSForegroundColorAttributeName: RGB(62, 195, 165)}]];
            [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"，回答正确。"]];
        }
        else {
            [string appendAttributedString:[[NSAttributedString alloc] initWithString:right attributes:@{NSForegroundColorAttributeName: RGB(62, 195, 165)}]];
            [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"，您的答案是"]];
            [string appendAttributedString:[[NSAttributedString alloc] initWithString:selected attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}]];
            [string appendAttributedString:[[NSAttributedString alloc] initWithString:@"，回答错误。"]];
        }
        _answerLabel.attributedText = string;
    }
}

- (CGFloat)requiredRowHeightInTableView:(UITableView *)tableView
{
    return TOPIC_ANSWER_CELL_HEIGHT;
}

@end
