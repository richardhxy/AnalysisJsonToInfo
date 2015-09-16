//
//  OptionCell.h
//  zhixue
//
//  Created by iflytek on 15/4/21.
//  Copyright (c) 2015年 iflytek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DTCoreText.h>
#import "TopicInfo.h"
#import "NSString+TopicHtml.h"

@interface OptionCell : UITableViewCell

@property (strong, nonatomic) Option *option;


- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@property (nonatomic, strong) NSAttributedString *attributedString;

@property (nonatomic, DT_WEAK_PROPERTY) id <DTAttributedTextContentViewDelegate> textDelegate;

- (CGFloat)requiredRowHeightInTableView:(UITableView *)tableView;

@property (nonatomic, readonly) UILabel *optionId;
@property (nonatomic, readonly) DTAttributedTextContentView *attributedTextContextView;

@end
