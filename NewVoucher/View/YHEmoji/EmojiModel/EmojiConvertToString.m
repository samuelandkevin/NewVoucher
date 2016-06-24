//
//  EmojiConvertToString.m
//  joinup_iphone
//
//  Created by shen_gh on 15/8/4.
//  copyRight (c) 2015年 com.joinup(Beijing). All rights reserved.
//

#import "EmojiConvertToString.h"
#import "ChatEmojiIcons.h"



@interface EmojiConvertToString()
@property (nonatomic,strong) NSDictionary *dict;

@end

@implementation EmojiConvertToString


- (NSDictionary *)dictWithTag:(NSInteger )tag{
    static NSMutableDictionary *_mdict;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 加载资源
        [_mdict setObject:@(0x1F60A) forKey:@"[em_1]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_2]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_3]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_4]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_5]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_6]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_7]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_8]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_9]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_10]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_11]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_12]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_13]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_14]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_15]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_16]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_17]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_18]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_19]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_20]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_21]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_22]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_23]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_24]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_25]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_26]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_27]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_28]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_29]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_30]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_31]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_32]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_33]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_34]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_35]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_36]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_37]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_38]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_39]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_40]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_41]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_42]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_43]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_44]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_45]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_46]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_47]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_48]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_49]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_50]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_51]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_52]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_53]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_54]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_55]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_56]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_57]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_58]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_59]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_60]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_61]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_62]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_63]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_64]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_65]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_66]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_67]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_68]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_69]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_70]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_71]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_72]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_73]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_74]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_75]"];
        [_mdict setObject:@(0x1F60A) forKey:@"[em_76]"];
        
    });
    return _mdict;
}


+ (NSString *)convertToCommonEmoticons:(NSString *)text{
    //表情数量
    NSInteger emojiCount = [ChatEmojiIcons getEmojiPopCount];
    NSMutableString *retText = [[NSMutableString alloc] initWithString:text];
    
    for(NSInteger i=1; i<= emojiCount; i++) {
        NSRange range;
        range.location = 0;
        range.length = retText.length;
       
        [retText replaceOccurrencesOfString:[NSString stringWithFormat:@",face.bundle/%@.png",@(i)]
                                 withString:[NSString stringWithFormat:@"[em_%@]",@(i)]
                                    options:NSLiteralSearch
                                      range:range];
        
    }
    
    return retText;
}

@end
