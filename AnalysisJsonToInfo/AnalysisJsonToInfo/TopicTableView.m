//
//  TopicTableView.m
//  zhixue
//
//  Created by iflytek on 15/4/20.
//  Copyright (c) 2015年 iflytek. All rights reserved.
//

#import "TopicTableView.h"
#import "TopicCell.h"
#import "OptionCell.h"
#import "TopicAnalysisCell.h"
#import "TopicAnswerCell.h"
#import "DTLazyImageView+AttributedTextContentView.h"

/*
#pragma mark - TopicCell
@interface TopicCell : UITableViewCell <DTAttributedTextContentViewDelegate>

@property (strong, nonatomic) Accessory *accessory;

@property (strong, nonatomic) DTAttributedLabel *topicLabel;

+ (CGFloat)heightForRowWithString:(NSString *)string;

@end

@implementation TopicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _topicLabel = [[DTAttributedLabel alloc] initWithFrame:CGRectMake(10, 20, SCREEN_WIDTH - 70, MAXFLOAT)];
        _topicLabel.delegate = self;
        [self.contentView addSubview:_topicLabel];
    }
    return self;
}

- (void)setAccessory:(Accessory *)accessory
{
    _accessory = accessory;
    
    NSData *data = [accessory.desc dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data documentAttributes:nil];
    _topicLabel.attributedString = string;
    
    CGSize size = [_topicLabel suggestedFrameSizeToFitEntireStringConstraintedToWidth:SCREEN_WIDTH - 02];
    CGRect frame = self.frame;
    _topicLabel.frame = CGRectMake(10, 20, SCREEN_WIDTH - 20, size.height);
    frame.size.height = size.height + 40;
    self.frame = frame;
}

+ (CGFloat)heightForRowWithString:(NSString *)string
{
    return [Util calculateHeightWithText:string width:SCREEN_WIDTH - 32 font:FontSize(14.0f)] + 10;
}

#pragma mark - DTAttributedTextContentViewDelegate
- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttachment:(DTTextAttachment *)attachment frame:(CGRect)frame
{
    DTLazyImageView *imageView = [[DTLazyImageView alloc] initWithFrame:frame];
    imageView.image = [(DTImageTextAttachment *)attachment image];
    imageView.url = attachment.contentURL;
    return imageView;
}

@end


#pragma mark - OptionCell
@interface OptionCell : UITableViewCell <DTAttributedTextContentViewDelegate>

@property (strong, nonatomic) Options *option;

@property (strong, nonatomic) UILabel *optionId;
@property (strong, nonatomic) DTAttributedLabel *optionLabel;

@end

@implementation OptionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _optionId = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
        _optionId.font = FontSize(18.0f);
        _optionId.textAlignment = NSTextAlignmentCenter;
        _optionId.textColor = RGB(62, 195, 165);
        _optionId.backgroundColor = [UIColor clearColor];
        _optionId.layer.cornerRadius = 15;
        _optionId.layer.masksToBounds = YES;
        _optionId.layer.borderWidth = 1.0f;
        _optionId.layer.borderColor = RGB(62, 195, 165).CGColor;
        [self.contentView addSubview:_optionId];
        
        _optionLabel = [[DTAttributedLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_optionId.frame) + 10, 10, SCREEN_WIDTH - 60, MAXFLOAT)];
        _optionLabel.delegate = self;
        [self.contentView addSubview:_optionLabel];
        
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        _optionId.textColor = [UIColor clearColor];
        _optionId.backgroundColor = RGB(62, 195, 165);
        _optionId.layer.borderColor = [UIColor clearColor].CGColor;
    }
    else {
        _optionId.textColor = RGB(62, 195, 165);
        _optionId.backgroundColor = [UIColor clearColor];
        _optionId.layer.borderColor = RGB(62, 195, 165).CGColor;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected) {
        _optionId.textColor = [UIColor whiteColor];
        _optionId.backgroundColor = RGB(62, 195, 165);
        _optionId.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    else {
        _optionId.textColor = RGB(62, 195, 165);
        _optionId.backgroundColor = [UIColor clearColor];
        _optionId.layer.borderColor = RGB(62, 195, 165).CGColor;
    }
}

- (void)setOption:(Options *)option
{
    _option = option;
    
    _optionId.text = _option.objectId;
    
    NSData *data = [_option.desc dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data documentAttributes:nil];
    _optionLabel.attributedString = string;
    
    CGSize size = [_optionLabel suggestedFrameSizeToFitEntireStringConstraintedToWidth:SCREEN_WIDTH - 60];
    CGRect frame = self.frame;
    if (size.height < 30) {
        _optionLabel.frame = CGRectMake(CGRectGetMaxX(_optionId.frame) + 10, (50 - size.height)/2, SCREEN_WIDTH - 60, size.height);
        frame.size.height = 50;
    }
    else {
        frame.size.height = size.height + 20;
        _optionLabel.frame = CGRectMake(CGRectGetMaxX(_optionId.frame) + 10, (frame.size.height - size.height)/2, SCREEN_WIDTH - 70, size.height);
    }
    self.frame = frame;
}

#pragma mark - DTAttributedTextContentViewDelegate
- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttachment:(DTTextAttachment *)attachment frame:(CGRect)frame
{
    DTLazyImageView *imageView = [[DTLazyImageView alloc] initWithFrame:frame];
    imageView.image = [(DTImageTextAttachment *)attachment image];
    imageView.url = attachment.contentURL;
    return imageView;
}

@end
*/

#pragma mark - TopicTableView

NSString * const TopicCellIdentifier = @"TopicCellIdentifier";
NSString * const OptionCellIdentifier = @"OptionCellIdentifier";
NSString * const TopicAnswerCellIdentifier = @"TopicAnswerCellIdentifier";
NSString * const TopicAnalysisCellIdentifier = @"TopicAnalysisCellIdentifier";

@implementation TopicTableView
{
    NSIndexPath *selectedOption;
    NSCache *_cellCache;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        
        _cellCache = [[NSCache alloc] init];
        
    }
    return self;
}

#pragma mark - setter

- (void)setSubTopic:(SubTopic *)subTopic
{
    _subTopic = subTopic;
    
    if (!_showAnalysis) {
        NSIndexPath *indexPath = nil;
        for (NSInteger i = 0; i < [_subTopic.options count]; i ++) {
            Option *option = _subTopic.options[i];
            if (option.optionType == OptionType_Selected) {
                indexPath = [NSIndexPath indexPathForRow:i + 1 inSection:0];
            }
        }
        [self reloadData];
        if (indexPath) {
            [self selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
    }
    else {
        [self reloadData];
    }
}

- (void)clickImageAction:(UIButton *)sender
{
    if (self.topicTableViewDelegate && [self.topicTableViewDelegate respondsToSelector:@selector(topicTableView:clickImage:)]) {
        [self.topicTableViewDelegate topicTableView:self clickImage:(UIImageView *)sender.superview];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_subTopic.options count] + (_showRightAnswer ? 3 : 2);
}

- (void)configureCell:(id)cell forIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        TopicCell *topicCell = (TopicCell *)cell;
        [topicCell setHTMLString:[NSString topicHtmlWithString:_subTopic.desc]];
    }
    else if (indexPath.row <= _subTopic.options.count) {
        Option *options = _subTopic.options[indexPath.row - 1];
        OptionCell *optionCell = (OptionCell *)cell;
        optionCell.option = options;
    }
    else if (indexPath.row == _subTopic.options.count + 1) {
        if (_topicInfo.topicDetail.section.isSubjective) {
            TopicAnalysisCell *analysisCell = (TopicAnalysisCell *)cell;
            [analysisCell setTitleText:@"我的答案"];
            NSMutableString *htmlStr = [NSMutableString stringWithString:[NSString picArrayToString:_subTopic.userAnswer.pic]];
            [htmlStr appendString:_subTopic.answer];
            [analysisCell setHTMLString:htmlStr];
        }
        else {
            TopicAnswerCell *answerCell = (TopicAnswerCell *)cell;
            if (_showRightAnswer) {
                for (NSInteger i = 0; i < _subTopic.options.count; i ++) {
                    Option *option = _subTopic.options[i];
                    if (option.optionType == OptionType_Right) {
                        [answerCell setRightAnswer:_subTopic.answer selectedAnswer:_subTopic.userAnswer.text showRightAnswer:_showRightAnswer];
                        break;
                    }
                }
            }
            else {
                for (NSInteger i = 0; i < _subTopic.options.count; i ++) {
                    Option *option = _subTopic.options[i];
                    if (option.optionType == OptionType_Error || option.optionType == OptionType_Selected || option.optionType == OptionType_Right) {
                        [answerCell setRightAnswer:_subTopic.answer selectedAnswer:_subTopic.userAnswer.text showRightAnswer:_showRightAnswer];
                        break;
                    }
                    if (i == _subTopic.options.count - 1) {
                        [answerCell setRightAnswer:_subTopic.answer selectedAnswer:_subTopic.userAnswer.text showRightAnswer:_showRightAnswer];
                    }
                }
            }
        }
    }
    else if (indexPath.row == _subTopic.options.count + 2) {
        TopicAnalysisCell *analysisCell = (TopicAnalysisCell *)cell;
        [analysisCell setHTMLString:_analysisHtml];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView preparedCellForIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        NSString *key = [NSString stringWithFormat:@"%ld-%ld", (long)indexPath.section, (long)indexPath.row];
        DTAttributedTextCell *cell = [_cellCache objectForKey:key];
        if (!cell) {
            cell = (TopicCell *)[tableView dequeueReusableCellWithIdentifier:TopicCellIdentifier];
            if (!cell) {
                cell = [[TopicCell alloc] initWithReuseIdentifier:TopicCellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textDelegate = self;
            }
            cell.hasFixedRowHeight = NO;
            [_cellCache setObject:cell forKey:key];
        }
        [self configureCell:cell forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.row <= _subTopic.options.count) {
        NSString *key = [NSString stringWithFormat:@"%ld-%ld", (long)indexPath.section, (long)indexPath.row];
        OptionCell *cell = [_cellCache objectForKey:key];
        if (!cell) {
            cell = (OptionCell *)[tableView dequeueReusableCellWithIdentifier:OptionCellIdentifier];
            if (!cell) {
                cell = [[OptionCell alloc] initWithReuseIdentifier:OptionCellIdentifier];
                cell.textDelegate = self;
            }
            [_cellCache setObject:cell forKey:key];
        }
        [self configureCell:cell forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.row == _subTopic.options.count + 1) {
        
        if (_topicInfo.topicDetail.section.isSubjective) {
            NSString *key = [NSString stringWithFormat:@"%ld-%ld", (long)indexPath.section, (long)indexPath.row];
            TopicAnalysisCell *cell = [_cellCache objectForKey:key];
            if (!cell) {
                cell = (TopicAnalysisCell *)[tableView dequeueReusableCellWithIdentifier:TopicAnalysisCellIdentifier];
                if (!cell) {
                    cell = [[TopicAnalysisCell alloc] initWithReuseIdentifier:TopicAnalysisCellIdentifier];
                    cell.textDelegate = self;
                }
                [_cellCache setObject:cell forKey:key];
            }
            [self configureCell:cell forIndexPath:indexPath];
            return cell;
        }
        else {
            NSString *key = [NSString stringWithFormat:@"%ld-%ld", (long)indexPath.section, (long)indexPath.row];
            TopicAnswerCell *cell = [_cellCache objectForKey:key];
            if (!cell) {
                cell = (TopicAnswerCell *)[tableView dequeueReusableCellWithIdentifier:TopicAnswerCellIdentifier];
                if (!cell) {
                    cell = [[TopicAnswerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TopicAnswerCellIdentifier];
                }
                [_cellCache setObject:cell forKey:key];
            }
            [self configureCell:cell forIndexPath:indexPath];
            return cell;
        }
    }
    else if (indexPath.row == _subTopic.options.count + 2) {
        NSString *key = [NSString stringWithFormat:@"%ld-%ld", (long)indexPath.section, (long)indexPath.row];
        TopicAnalysisCell *cell = [_cellCache objectForKey:key];
        if (!cell) {
            cell = (TopicAnalysisCell *)[tableView dequeueReusableCellWithIdentifier:TopicAnalysisCellIdentifier];
            if (!cell) {
                cell = [[TopicAnalysisCell alloc] initWithReuseIdentifier:TopicAnalysisCellIdentifier];
                cell.textDelegate = self;
            }
            [_cellCache setObject:cell forKey:key];
        }
        [self configureCell:cell forIndexPath:indexPath];
        return cell;
    }
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self tableView:tableView preparedCellForIndexPath:indexPath];
}

#pragma mark - UITableViewDelegate

//- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.row > 0 && indexPath.row <= _accessory.optionsSize) {
//        Options *option = _accessory.options[indexPath.row - 1];
//        if (option.selected) {
//            [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
//        }
//    }
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTAttributedTextCell *cell = (DTAttributedTextCell *)[self tableView:tableView preparedCellForIndexPath:indexPath];
    return [cell requiredRowHeightInTableView:tableView];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || _showAnalysis) {
        return nil;
    }
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedOption = indexPath;
    for (NSInteger i = 0; i < _subTopic.options.count; i ++) {
        Option *options = _subTopic.options[i];
        options.optionType = i == indexPath.row - 1 ? OptionType_Selected : OptionType_Normal;
    }
    if (indexPath.row >= 1 && indexPath.row - 1 < _subTopic.options.count && self.topicTableViewDelegate && [self.topicTableViewDelegate respondsToSelector:@selector(topicTableView:didSelecetedOption:)]) {
        [self.topicTableViewDelegate topicTableView:self didSelecetedOption:indexPath.row - 1];
    }
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
//            DTLinkButton *button = [[DTLinkButton alloc] initWithFrame:imageView.bounds];
//            button.URL = attachment.hyperLinkURL;
//            button.minimumHitSize = CGSizeMake(25, 25);
//            button.GUID = attachment.hyperLinkGUID;
//            [button addTarget:self action:@selector(clickImageAction:) forControlEvents:UIControlEventTouchUpInside];
//            [imageView addSubview:button];
            
            return imageView;
        }
        else {
            DTLazyImageView *imageView = [[DTLazyImageView alloc] initWithFrame:frame];
            imageView.image = [(DTImageTextAttachment *)attachment image];
            imageView.delegate = self;
            imageView.attributedTextContentView = attributedTextContentView;
            imageView.url = attachment.contentURL;
            imageView.userInteractionEnabled = YES;
//            DTLinkButton *button = [[DTLinkButton alloc] initWithFrame:imageView.bounds];
//            button.URL = attachment.hyperLinkURL;
//            button.minimumHitSize = CGSizeMake(25, 25);
//            button.GUID = attachment.hyperLinkGUID;
//            [button addTarget:self action:@selector(clickImageAction:) forControlEvents:UIControlEventTouchUpInside];
//            [imageView addSubview:button];
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
    
    DTLinkButton *button = [[DTLinkButton alloc] initWithFrame:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    button.minimumHitSize = CGSizeMake(25, 25);
    [button addTarget:self action:@selector(clickImageAction:) forControlEvents:UIControlEventTouchUpInside];
    [lazyImageView addSubview:button];
    
    
    [self reloadData];
}

@end
