//
//  TopicAnalysisCell.h
//  zhixue
//
//  Created by iflytek on 15/4/28.
//  Copyright (c) 2015年 iflytek. All rights reserved.
//

#import "BaseTableViewCell.h"
#import <DTCoreText.h>

@interface TopicAnalysisCell : BaseTableViewCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@property (nonatomic, strong) NSAttributedString *attributedString;

@property (nonatomic, DT_WEAK_PROPERTY) id <DTAttributedTextContentViewDelegate> textDelegate;

- (CGFloat)requiredRowHeightInTableView:(UITableView *)tableView;

- (void)setHTMLString:(NSString *)htmlString;

- (void)setTitleText:(NSString *)titleText;

@end
