//
//  TopicInfo.h
//  EnglishWeekly
//
//  Created by admin on 15/7/31.
//  Copyright (c) 2015年 iflytek. All rights reserved.
//

#import "BaseObject.h"

// TODO: 1111
// FIXME: 11111
// !!!: 11111
// ???: 1111

typedef NS_ENUM(NSInteger, OptionType) {
    OptionType_Normal,
    OptionType_Selected,
    OptionType_Error,
    OptionType_Right
};


@interface TopicLogOfUser : BaseObject
@property (nonatomic,assign) BOOL           collect;
@property (nonatomic,assign) BOOL           share;
@end

@interface Section : BaseObject
@property (nonatomic,strong) NSString       *code;
@property (nonatomic,strong) NSString       *name;
@property (nonatomic,strong) NSString       *categoryCode;
@property (nonatomic,strong) NSString       *categoryName;
@property (nonatomic,strong) NSString       *sort;
@property (nonatomic,assign) BOOL           isSubjective;
@property (nonatomic,strong) NSString       *score;
@end

@interface Phase : BaseObject
@property (nonatomic,strong) NSString       *code;
@property (nonatomic,strong) NSString       *name;
@end

@interface Grade : BaseObject
@property (nonatomic,strong) NSString       *code;
@property (nonatomic,strong) NSString       *name;
@end

@interface Subject : BaseObject
@property (nonatomic,strong) NSString       *code;
@property (nonatomic,strong) NSString       *name;
@end

@interface Difficulty : BaseObject
@property (nonatomic,strong) NSString       *code;
@property (nonatomic,strong) NSString       *name;
@property (nonatomic,strong) NSString       *value;
@end

@interface KnowledgeInfo : BaseObject
@property (nonatomic,strong) NSString       *code;
@property (nonatomic,strong) NSString       *name;
@end

@interface Option : BaseObject
@property (nonatomic,strong) NSString       *optionId;
@property (nonatomic,strong) NSString       *desc;
@property (nonatomic,assign) OptionType     optionType;
@end

@class UserAnswer;

@interface SubTopic : BaseObject
@property (nonatomic,strong) NSString       *desc;
@property (nonatomic,strong) NSArray        *options;
@property (nonatomic,strong) NSString       *answer;
@property (nonatomic,strong) UserAnswer     *userAnswer;
@property (nonatomic,strong) NSString       *knowledages;
@property (nonatomic,strong) NSNumber       *seqtNoOfTopicPack;
@end

@interface OptionAnswer : BaseObject
@property (nonatomic,assign) NSInteger      optionCount;
@property (nonatomic,strong) NSString       *answer;
@end


@interface TopicDetail : BaseObject
@property (nonatomic,strong) NSString       *topicId;
@property (nonatomic,strong) NSString       *version;
@property (nonatomic,strong) Section        *section;
@property (nonatomic,strong) NSString       *paperName;
@property (nonatomic,strong) Phase          *phase;
@property (nonatomic,strong) NSArray        *grades;
@property (nonatomic,strong) Subject        *subject;
@property (nonatomic,strong) Difficulty     *difficulty;
@property (nonatomic,strong) NSString       *rawHtml;
@property (nonatomic,strong) NSString       *answerHtml;
@property (nonatomic,strong) NSString       *analysisHtml;
@property (nonatomic,assign) NSInteger      questionCount;
@property (nonatomic,strong) NSArray        *knowledges;
@property (nonatomic,strong) NSArray        *optionAnswer;
@property (nonatomic,strong) NSArray        *subjectiveAnswerList;
@property (nonatomic,strong) NSString       *material;
@property (nonatomic,strong) NSArray        *subTopics;
@property (nonatomic,strong) NSString       *type;
@property (nonatomic,assign) BOOL           multiSubTopic;
@end

@interface Pic : BaseObject

@property (nonatomic,strong) NSString       *thumbnail;
@property (nonatomic,strong) NSString       *url;

@end


@interface UserAnswer : BaseObject

@property (nonatomic,strong) NSArray        *pic;
@property (nonatomic,strong) NSString       *text;

@end

@interface TopicInfo : BaseObject

@property (nonatomic,strong) TopicDetail    *topicDetail;
@property (nonatomic,assign) NSInteger      answerCount;
@property (nonatomic,strong) TopicLogOfUser *topicLogOfUser;
@property (nonatomic,strong) NSArray        *seqtNoOfTopicPack;
@property (nonatomic,strong) NSArray        *userAnswer;
@property (nonatomic,strong) NSString       *topicStatOfClass;

@end
