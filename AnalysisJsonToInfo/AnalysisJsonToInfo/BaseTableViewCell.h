//
//  BaseTableViewCell.h
//  zhixue
//
//  Created by iflytek on 15/4/3.
//  Copyright (c) 2015年 iflytek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

+ (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;

+ (CGFloat)heightForRowWithModel:(id)model;

@end
