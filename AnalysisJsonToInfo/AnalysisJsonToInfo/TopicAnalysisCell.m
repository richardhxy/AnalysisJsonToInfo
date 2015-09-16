//
//  TopicAnalysisCell.m
//  zhixue
//
//  Created by iflytek on 15/4/28.
//  Copyright (c) 2015年 iflytek. All rights reserved.
//
#import "TopicAnalysisCell.h"
#import "NSString+TopicHtml.h"

#define MIN_CELL_HEIGHT

@interface TopicAnalysisCell ()

@end

@implementation TopicAnalysisCell
{
    DTAttributedTextContentView *_attributedTextContextView;
    
    DT_WEAK_VARIABLE id <DTAttributedTextContentViewDelegate> _textDelegate;
    
    NSUInteger _htmlHash; // preserved hash to avoid relayouting for same HTML
    
    DT_WEAK_VARIABLE UITableView *_containingTableView;
    UILabel *label;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 6, 16, 16)];
        imageView.image = [UIImage imageNamed:@"topic_analysis"];
        [self.contentView addSubview:imageView];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 8, 0, 200, CGRectGetMinY(imageView.frame) * 2 + CGRectGetHeight(imageView.frame))];
        label.font = FontSize(14.0f);
        label.text = @"试题解析";
        [self.contentView addSubview:label];
    }
    return self;
}

- (void)setTitleText:(NSString *)titleText {
    label.text = titleText;
}

- (void)dealloc
{
    _textDelegate = nil;
    _containingTableView = nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!self.superview)
    {
        return;
    }
    
    CGFloat neededContentHeight = [self contextViewHeightInTableView:_containingTableView];
    CGRect frame = CGRectMake(10, 30, SCREEN_WIDTH - 20, neededContentHeight);
    self.attributedTextContextView.frame = frame;
}

- (UITableView *)_findContainingTableView
{
    UIView *tableView = self.superview;
    while (tableView) {
        if ([tableView isKindOfClass:[UITableView class]]) {
            return (UITableView *)tableView;
        }
        tableView = tableView.superview;
    }
    return nil;
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    _containingTableView = [self _findContainingTableView];
    if (_containingTableView.style == UITableViewStyleGrouped) {
        if (NSFoundationVersionNumber < DTNSFoundationVersionNumber_iOS_7_0) {
            _attributedTextContextView.backgroundColor = [UIColor clearColor];
        }
    }
}

- (CGFloat)_groupedCellMarginWithTableWidth:(CGFloat)tableViewWidth
{
    CGFloat marginWidth;
    if(tableViewWidth > 20) {
        if(tableViewWidth < 400 || [UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPhone) {
            marginWidth = 10;
        }
        else {
            marginWidth = MAX(31.f, MIN(45.f, tableViewWidth*0.06f));
        }
    }
    else {
        marginWidth = tableViewWidth - 10;
    }
    return marginWidth;
}

- (CGFloat)requiredRowHeightInTableView:(UITableView *)tableView
{
    CGFloat contextViewHeight = [self contextViewHeightInTableView:tableView];
    return contextViewHeight + 40;
}

- (CGFloat)contextViewHeightInTableView:(UITableView *)tableView
{
    BOOL ios6Style = (NSFoundationVersionNumber < DTNSFoundationVersionNumber_iOS_7_0);
    CGFloat contentWidth = tableView.frame.size.width - 20;
    
    if (ios6Style && tableView.style == UITableViewStyleGrouped) {
        contentWidth -= [self _groupedCellMarginWithTableWidth:contentWidth] * 2;
    }
    
    switch (self.accessoryType) {
        case UITableViewCellAccessoryDisclosureIndicator:
            contentWidth -= ios6Style ? 20.0f : 10.0f + 8.0f + 15.0f;
            break;
        case UITableViewCellAccessoryCheckmark:
            contentWidth -= ios6Style ? 20.0f : 10.0f + 14.0f + 15.0f;
            break;
        case UITableViewCellAccessoryDetailDisclosureButton:
            contentWidth -= ios6Style ? 33.0f : 10.0f + 42.0f + 15.0f;
            break;
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
        case UITableViewCellAccessoryDetailButton:
            contentWidth -= 10.0f + 22.0f + 15.0f;
#endif
            break;
        case UITableViewCellAccessoryNone:
            break;
        default:
//            DDLogWarn(@"AccessoryType %d not implemented on %@", (int)self.accessoryType, NSStringFromClass([self class]));
            break;
    }
    
    CGSize neededSize = [self.attributedTextContextView suggestedFrameSizeToFitEntireStringConstraintedToWidth:contentWidth];
    return neededSize.height;
}

#pragma mark Properties

- (void)setHTMLString:(NSString *)htmlString
{
    NSUInteger newHash = [htmlString hash];
    
    if (newHash == _htmlHash)
    {
        return;
    }
    
    _htmlHash = newHash;
    
    NSString *html = [NSString topicHtmlWithString:htmlString];
    NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:nil documentAttributes:NULL];
    self.attributedTextContextView.attributedString = string;
    [self setNeedsLayout];
    
}

- (void)setTextDelegate:(id)textDelegate
{
    _textDelegate = textDelegate;
    _attributedTextContextView.delegate = _textDelegate;
}

- (DTAttributedTextContentView *)attributedTextContextView
{
    if (!_attributedTextContextView)
    {
        _attributedTextContextView = [[DTAttributedTextContentView alloc] initWithFrame:CGRectZero];
        _attributedTextContextView.edgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        _attributedTextContextView.layoutFrameHeightIsConstrainedByBounds = NO;
        _attributedTextContextView.delegate = _textDelegate;
        _attributedTextContextView.shouldDrawImages = YES;
        [self.contentView addSubview:_attributedTextContextView];
    }
    
    return _attributedTextContextView;
}


@end
