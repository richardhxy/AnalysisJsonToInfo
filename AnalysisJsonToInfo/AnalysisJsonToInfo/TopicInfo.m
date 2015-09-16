//
//  TopicInfo.m
//  EnglishWeekly
//
//  Created by admin on 15/7/31.
//  Copyright (c) 2015年 iflytek. All rights reserved.
//

#import "TopicInfo.h"

@implementation TopicLogOfUser
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{};
}
@end


@implementation Section
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{};
}
@end

@implementation Phase
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{};
}
@end

@implementation Grade
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{};
}
@end

@implementation Subject
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{};
}
@end

@implementation Difficulty
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{};
}
@end

@implementation KnowledgeInfo
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{};
}
@end

@implementation Option
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"optionId":@"id"};
}
@end

@implementation SubTopic
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{};
}

+ (NSValueTransformer *)optionsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[Option class]];
}

@end

@implementation OptionAnswer
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{};
}
@end


@implementation TopicDetail
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{};
}

+ (NSValueTransformer *)sectionJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Section class]];
}

+ (NSValueTransformer *)phaseJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Phase class]];
}

+ (NSValueTransformer *)gradesJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[Grade class]];
}

+ (NSValueTransformer *)subjectJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Subject class]];
}

+ (NSValueTransformer *)difficultyJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Difficulty class]];
}

+ (NSValueTransformer *)knowledgesJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSArray *array) {
        NSError *error = nil;
        NSMutableArray *knowledgeList = [NSMutableArray arrayWithCapacity:1];
        for (NSArray *tmpArray in array) {
            NSArray *knowledgeSubArray = [MTLJSONAdapter modelsOfClass:[KnowledgeInfo class] fromJSONArray:tmpArray error:&error];
            [knowledgeList addObject:knowledgeSubArray];
        }
        return [NSArray arrayWithArray:knowledgeList];
    } reverseBlock:^id(NSArray *array) {
        return [array description];
    }];
}

+ (NSValueTransformer *)optionAnswerJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSArray *array) {
        NSError *error = nil;
        NSArray *resultArray = [MTLJSONAdapter modelsOfClass:[OptionAnswer class] fromJSONArray:array error:&error];
        return resultArray;
    } reverseBlock:^id(NSArray *array) {
        return [array description];
    }];
}

+ (NSValueTransformer *)subTopicsJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSArray *array) {
        NSError *error = nil;
        NSArray *subTopics = [MTLJSONAdapter modelsOfClass:[SubTopic class] fromJSONArray:array error:&error];
        return subTopics;
    } reverseBlock:^id(NSArray *subTopics) {
        return [MTLJSONAdapter JSONArrayFromModels:subTopics];
    }];
}

@end


@implementation Pic
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{};
}

@end


@implementation UserAnswer
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{};
}

+ (NSValueTransformer *)picJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSArray *array) {
        NSError *error = nil;
        NSArray *pics = [MTLJSONAdapter modelsOfClass:[Pic class] fromJSONArray:array error:&error];
        return pics;
    } reverseBlock:^id(NSArray *pics) {
        return [MTLJSONAdapter JSONArrayFromModels:pics];
    }];
}

@end



@implementation TopicInfo
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{};
}

+ (NSValueTransformer *)topicDetailJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[TopicDetail class]];
}

+ (NSValueTransformer *)topicLogOfUserJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[TopicLogOfUser class]];
}

+ (NSValueTransformer *)seqtNoOfTopicPackJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSArray *array) {
        return array;
    } reverseBlock:^id(NSArray *array) {
        return [array description];
    }];
}

+ (NSValueTransformer *)userAnswerJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSArray *array) {
        NSError *error = nil;
        NSMutableArray *jsonArray = [[NSMutableArray alloc]initWithCapacity:[array count]];
        for (NSString *string in array) {
            NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:stringData options:NSJSONReadingMutableLeaves error:&error];
            [jsonArray addObject:dic];
        }
        NSArray *userAnswers = [MTLJSONAdapter modelsOfClass:[UserAnswer class] fromJSONArray:jsonArray error:&error];
        return userAnswers;
    } reverseBlock:^id(NSArray *array) {
        return [MTLJSONAdapter JSONArrayFromModels:array];
    }];
}

@end
