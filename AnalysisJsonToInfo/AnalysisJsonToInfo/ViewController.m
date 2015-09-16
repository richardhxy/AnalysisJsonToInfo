//
//  ViewController.m
//  AnalysisJson
//
//  Created by admin on 15/7/31.
//  Copyright (c) 2015年 iflytek. All rights reserved.
//

#import "ViewController.h"
#import "TopicInfo.h"

@interface ViewController ()
{
    NSArray *topicInfos;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *jsonPath = [[NSBundle mainBundle]pathForResource:@"周报测试" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    topicInfos = [MTLJSONAdapter modelsOfClass:[TopicInfo class] fromJSONArray:jsonDic[@"result"][@"topicList"] error:nil];
    
    UIButton *pushToTopicView = [UIButton buttonWithType:UIButtonTypeSystem];
    pushToTopicView.frame = CGRectMake(100, 100, 100, 60);
    [pushToTopicView setTitle:@"1111" forState:UIControlStateNormal];
    [pushToTopicView addTarget:self action:@selector(pushToTopicView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushToTopicView];
    
    //    NSLog(@"jsonDic %@",jsonDic);
    //    NSLog(@"%@",jsonDic[@"result"][@"topicList"][0][@"seqtNoOfTopicPack"][1]);
    
}

- (void)pushToTopicView {
    TopicViewController *viewController = [[TopicViewController alloc] init];
    viewController.hidesBottomBarWhenPushed = YES;
    viewController.showAnalysis = YES;
    viewController.dataSource = topicInfos;
    viewController.subjectCode = 0;
    viewController.subjectName = @"11111";
    viewController.bookCode = @"2222";
    
//    viewController.topicSetCategory = _topicSetCategory;
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController showTopicAtIndex:10];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
