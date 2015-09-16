//
//  TopicViewController.m
//  zhixue
//
//  Created by iflytek on 15/4/16.
//  Copyright (c) 2015年 iflytek. All rights reserved.
//

#import "TopicViewController.h"
#import "TopicTableView.h"
#import "TopicView.h"
#import "TopicScrollView.h"
#import "TopicInfo.h"

@interface TopicViewController () <UIScrollViewDelegate, TopicScrollViewDelegate>
{
    NSMutableArray *sectionArray;
}

@property (strong, nonatomic) TopicTableView *tableView;
@property (strong, nonatomic) TopicScrollView *scrollView;

@property (nonatomic) NSInteger topicCount;

@property (strong, nonatomic) NSMutableArray *topicViews;

@property (strong, nonatomic) UIButton *saveButton;


@end

@implementation TopicViewController

#pragma mark - life circle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = YES;
    WS(ws);
    [SVProgressHUD showWithStatus:@"正在加载数据..." maskType:SVProgressHUDMaskTypeBlack];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        [ws initialization];
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            [ws setupSubviews];
            [SVProgressHUD dismiss];
        });
    });
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - initialization
// 初始化数据
- (void)initialization
{
    
    
//    if (!_showAnalysis) {
//        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar_back"] style:UIBarButtonItemStyleBordered target:self action:@selector(backAction:)];
//        self.navigationItem.leftBarButtonItem = backItem;
//    }
    
    //    UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
    //    [shareButton setImage:[UIImage imageNamed:@"topic_share_n"] forState:UIControlStateNormal];
    //    [shareButton setImage:[UIImage imageNamed:@"topic_share_h"] forState:UIControlStateHighlighted];
    //    [shareButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    
    //    _saveButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
    //    _saveButton.adjustsImageWhenHighlighted = NO;
    //    _saveButton.selected = YES;
    //    [_saveButton setImage:[UIImage imageNamed:@"topic_save_h"] forState:UIControlStateNormal];
    //    [_saveButton setImage:[UIImage imageNamed:@"topic_save_n"] forState:UIControlStateSelected];
    //    [_saveButton addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithCustomView:_saveButton];
    
    //    UIButton *answerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
    //    [answerButton setImage:[UIImage imageNamed:@"topic_sheet_n"] forState:UIControlStateNormal];
    //    [answerButton setImage:[UIImage imageNamed:@"topic_sheet_h"] forState:UIControlStateHighlighted];
    //    [answerButton addTarget:self action:@selector(answerAction:) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *answerItem = [[UIBarButtonItem alloc] initWithCustomView:answerButton];
    ////    self.navigationItem.rightBarButtonItems = @[shareItem, saveItem, answerItem];
    //    self.navigationItem.rightBarButtonItems = @[saveItem, answerItem];
    
    sectionArray = [[NSMutableArray alloc]initWithCapacity:1];
    
    NSLog(@"1111time %@",[NSDate date]);
    
    NSInteger topicCount = 0;
    for (NSInteger i = 0; i < _dataSource.count; i ++) {
        TopicInfo *topic = _dataSource[i];
        if ([topic.topicDetail.material isEqualToString:@"<p></p>"]) {
            topic.topicDetail.material = nil;
        }
//        if (topic.topicDetail.material)
        {
            if (_showAnalysis) {
                for (NSInteger j = 0; j < topic.topicDetail.subTopics.count; j ++) {
                    [sectionArray addObject:topic.topicDetail.section.name];
                    SubTopic *subTopic = topic.topicDetail.subTopics[j];
//                    if ([subTopic.options count] == 0) {
//                        continue;
//                    }
                    UserAnswer *userAnswer = (UserAnswer *)(topic.userAnswer[j]);
                    subTopic.userAnswer = userAnswer;
                    subTopic.seqtNoOfTopicPack = topic.seqtNoOfTopicPack[j];
                    NSLog(@"subTopic.seqtNoOfTopicPack %d",[subTopic.seqtNoOfTopicPack intValue]);
                    if (_showRightAnswer) {
                        for (NSInteger k = 0; k < [subTopic.options count]; k ++) {
                            Option *option = subTopic.options[k];
                            if (option.optionType != OptionType_Selected && option.optionType != OptionType_Error) {
                                option.optionType = [subTopic.answer rangeOfString:option.optionId].length != 0 ? OptionType_Right : OptionType_Normal;
                            }
                        }
                    }
                    if (topic.userAnswer.count == 0 || topic.userAnswer == nil || [userAnswer.text isEqualToString:@""]) {
                        continue;
                    }
                    if (topic.userAnswer[j] != nil) {
                        for (NSInteger k = 0; k < [subTopic.options count]; k ++) {
                            Option *option = subTopic.options[k];
                            if ([subTopic.userAnswer.text isEqualToString:option.optionId] && ![subTopic.userAnswer.text isEqualToString:subTopic.answer]) {
                                option.optionType = OptionType_Error;
                            }else if ([subTopic.userAnswer.text isEqualToString:option.optionId] && [subTopic.userAnswer.text isEqualToString:subTopic.answer]){
                                option.optionType = OptionType_Right;
                            }else {
                                //do nothing
                            }
                        }
                    }
                }
            }
            topicCount += topic.topicDetail.subTopics.count;
        }
        
        
//        else
//        {
//            if (_showAnalysis) {
//                [sectionArray addObject:topic.topicDetail.section.name];
//                SubTopic *subTopic = topic.topicDetail.subTopics[0];
//                for (NSInteger k = 0; k < [subTopic.options count]; k ++) {
//                    Option *option = subTopic.options[k];
//                    if (option.optionType != OptionType_Selected && option.optionType != OptionType_Error) {
////                        OptionAnswer *answer = topic.topicDetail.optionAnswer[0];
//                        option.optionType = [subTopic.answer rangeOfString:option.optionId].length != 0 ? OptionType_Selected : OptionType_Normal;
//                    }
//                }
//                UserAnswer *userAnswer = (UserAnswer *)(topic.userAnswer[0]);
//                if (topic.userAnswer.count == 0 || topic.userAnswer == nil || [userAnswer.text isEqualToString:@""]) {
//                    continue;
//                }
//                if (topic.userAnswer[0] != nil && ![userAnswer.text isEqualToString:subTopic.answer]) {
//                    for (NSInteger k = 0; k < [subTopic.options count]; k ++) {
//                        Option *option = subTopic.options[k];
//                        if ([userAnswer.text isEqualToString:option.optionId]) {
//                            option.optionType = OptionType_Error;
//                        }
//                    }
//                }
//                
//            }
//            topicCount ++;
//        }
    }
    
    //    TopicInfo *topic = _dataSource[0];
    //    _saveButton.selected = !topic.isCollect;
}

// 加载UIView
- (void)setupSubviews
{
    self.title = [NSString stringWithFormat:@"%@%d/%d", sectionArray[0], 1, (int)[sectionArray count]];
    CGFloat width = SCREEN_WIDTH;
    _scrollView = [[TopicScrollView alloc] initWithFrame:CGRectMake(0, 0, width, SCREEN_HEIGHT - 64) dataSource:_dataSource showAnalysis:_showAnalysis showRightAnswer:_showRightAnswer];
    _scrollView.topicScrollViewDelegate = self;
    [self.view addSubview:_scrollView];
}

#pragma mark - setter

#pragma mark - getter

#pragma mark - private

- (void)backAction:(UIButton *)sender
{
    WS(weakSelf);
    [WCAlertView showAlertWithTitle:@"提示" message:@"确定要退出练习？" customizationBlock:nil completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView) {
        if (buttonIndex == 1) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    } cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
}

//- (void)answerAction:(UIButton *)sender
//{
//    AnswerSheetViewController *viewController = [[AnswerSheetViewController alloc] init];
//    viewController.showAnalysis = _showAnalysis;
//    viewController.dataSource = _dataSource;
//    viewController.topicSetCategory = _topicSetCategory;
//    viewController.subjectCode = _subjectCode;
//    viewController.subjectName = _subjectName;
//    viewController.bookCode = _bookCode;
//    [self.navigationController pushViewController:viewController animated:YES];
//}

- (void)shareAction:(UIBarButtonItem *)sender
{
    
}

- (void)showTopicAtIndex:(NSInteger)index
{
    [_scrollView showTopicAtIndex:index];
}

#pragma mark - public

#pragma mark - delegate

#pragma mark - TopicScrollViewDelegate
- (void)topicScrollView:(TopicScrollView *)topicScrollView endSelected:(NSInteger)index
{
    //    [self answerAction:nil];
}

- (void)topicScrollView:(TopicScrollView *)topicScrollView clickImage:(UIImageView *)imageView
{
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    imageInfo.image = imageView.image;
    imageInfo.referenceRect = imageView.frame;
    imageInfo.referenceView = imageView.superview;
    
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc] initWithImageInfo:imageInfo mode:JTSImageViewControllerMode_Image backgroundStyle:JTSImageViewControllerBackgroundOption_None];
    [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
}

- (void)topicScrollView:(TopicScrollView *)topicScrollView topicCount:(NSInteger)count currentIndex:(NSInteger)index
{
    self.title = [NSString stringWithFormat:@"%@%d/%d", sectionArray[index],(int)index + 1, (int)[sectionArray count]];
    //    Topic *topic = _dataSource[_scrollView.currentIndex];
    //    _saveButton.selected = !topic.isCollect;
}

@end
