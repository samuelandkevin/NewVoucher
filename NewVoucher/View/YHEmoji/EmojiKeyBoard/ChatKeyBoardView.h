//
//  ChatKeyBoardView.h
//  joinup_iphone
//
//  Created by shen_gh on 15/7/29.
//  copyRight (c) 2015年 com.joinup(Beijing). All rights reserved.
//


/**
 *  聊天键盘
 */
#import <UIKit/UIKit.h>
#import "ChatInputTextView.h"

@class ChatKeyBoardView;

@protocol ChatKeyBoardViewDelegate <NSObject>

@optional
//根据键盘是否弹起，设置tableView frame
-(void)keyBoardView:(ChatKeyBoardView *)keyBoard ChangeDuration:(CGFloat)durtaion;
//发送消息
-(void)keyBoardView:(ChatKeyBoardView*)keyBoard sendMessage:(NSString*)message;

@end

@interface ChatKeyBoardView : UIView

@property (nonatomic,strong) UIView *chatBgView;//聊天框
@property (nonatomic,assign) id<ChatKeyBoardViewDelegate>delegate;
@property (nonatomic,strong) ChatInputTextView *chatInputTextView;//聊天输入
@property (nonatomic,assign) int maxNumberOfRows;//inputTextView最多显示多少行


//初始化init
- (instancetype)initWithDelegate:(id)delegate superView:(UIView *)superView;

//
- (void)tapAction;

- (void)tapShowInputTextView;
@end
