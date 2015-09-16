//
//  OptionCell.m
//  zhixue
//
//  Created by iflytek on 15/4/21.
//  Copyright (c) 2015年 iflytek. All rights reserved.
//



#import "OptionCell.h"

#define MIN_OPTION_CELL_HEIGHT 50

@implementation OptionCell
{
    UILabel *_optionId;
    
    DTAttributedTextContentView *_attributedTextContextView;
    
    DT_WEAK_VARIABLE id <DTAttributedTextContentViewDelegate> _textDelegate;
    
    NSUInteger _htmlHash; // preserved hash to avoid relayouting for same HTML
    
    DT_WEAK_VARIABLE UITableView *_containingTableView;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
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
    CGFloat cellHeight = [self requiredRowHeightInTableView:_containingTableView];
    CGRect frame = CGRectMake(CGRectGetMaxX(self.optionId.frame) + 10, (cellHeight - neededContentHeight)/2, SCREEN_WIDTH - CGRectGetMaxX(self.optionId.frame) - 20, neededContentHeight);
    self.attributedTextContextView.frame = frame;
    
    frame = self.optionId.frame;
    frame.origin.y = (cellHeight - frame.size.height)/2;
    self.optionId.frame = frame;
    [self setOptionType:_option.optionType];
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
    if (contextViewHeight < MIN_OPTION_CELL_HEIGHT) {
        contextViewHeight = MIN_OPTION_CELL_HEIGHT;
    }
    return contextViewHeight;
}

- (CGFloat)contextViewHeightInTableView:(UITableView *)tableView
{
    BOOL ios6Style = (NSFoundationVersionNumber < DTNSFoundationVersionNumber_iOS_7_0);
    CGFloat contentWidth = tableView.frame.size.width - CGRectGetMaxX(self.optionId.frame) - 20;
    
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (selected) {
        [self setOptionType:OptionType_Selected];
    }
    else {
        [self setOptionType:OptionType_Normal];
    }
}

//- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
//{
//    [super setHighlighted:highlighted animated:animated];
//    
//    if (highlighted) {
//        _optionId.textColor = [UIColor whiteColor];
//        _optionId.backgroundColor = RGB(62, 195, 165);
//        _optionId.layer.borderColor = [UIColor whiteColor].CGColor;
//    }
//    else {
//        _optionId.textColor = RGB(62, 195, 165);
//        _optionId.backgroundColor = [UIColor whiteColor];
//        _optionId.layer.borderColor = RGB(62, 195, 165).CGColor;
//    }
//}

- (void)setOptionType:(OptionType)type
{
    switch (type) {
        case OptionType_Right:
        case OptionType_Selected:
        {
            _optionId.textColor = [UIColor whiteColor];
            _optionId.backgroundColor = RGB(62, 195, 165);
            _optionId.layer.borderColor = [UIColor whiteColor].CGColor;
        }
            break;
        case OptionType_Error:
        {
            _optionId.textColor = [UIColor whiteColor];
            _optionId.backgroundColor = RGB(253, 163, 26);
            _optionId.layer.borderColor = [UIColor whiteColor].CGColor;
        }
            break;
        default:
        {
            _optionId.textColor = RGB(62, 195, 165);
            _optionId.backgroundColor = [UIColor whiteColor];
            _optionId.layer.borderColor = RGB(62, 195, 165).CGColor;
        }
            break;
    }
}

- (void)setOption:(Option *)option
{
    _option = option;
    
    self.optionId.text = option.optionId;
    
    NSUInteger newHash = [option.desc hash];
    
    if (newHash == _htmlHash)
    {
        return;
    }
    
    _htmlHash = newHash;
    
    NSString *html = [NSString topicHtmlWithString:option.desc];
    NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:nil documentAttributes:NULL];
    self.attributedTextContextView.attributedString = string;
    [self setNeedsLayout];
    
    [self setOptionType:option.optionType];
}

- (void)setTextDelegate:(id)textDelegate
{
    _textDelegate = textDelegate;
    _attributedTextContextView.delegate = _textDelegate;
}

- (UILabel *)optionId
{
    if (!_optionId) {
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
    }
    return _optionId;
}

- (DTAttributedTextContentView *)attributedTextContextView
{
    if (!_attributedTextContextView)
    {
        _attributedTextContextView = [[DTAttributedTextContentView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.optionId.frame) + 10, 0, SCREEN_WIDTH - CGRectGetMaxX(self.optionId.frame) + 20, self.contentView.frame.size.height - 20)];
        _attributedTextContextView.edgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        _attributedTextContextView.layoutFrameHeightIsConstrainedByBounds = NO;
        _attributedTextContextView.delegate = _textDelegate;
        _attributedTextContextView.shouldDrawImages = YES;
        [self.contentView addSubview:_attributedTextContextView];
    }
    
    return _attributedTextContextView;
}

@end
