//
//  ChatKeyBoardView.m
//  joinup_iphone
//
//  Created by shen_gh on 15/7/29.
//  Copyright (c) 2015年 com.joinup. All rights reserved.
//

#import "ChatKeyBoardView.h"
#import "ChatKeyBoardAnimationView.h"//聊天框底部contain
#import "ChatEmojiView.h"//表情键盘View
#import "EmojiObj.h"
#import "EmojiTextAttachment.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//标签栏的高度
#define kTabBarHeight  49.0
#define kFaceBtnWidth 35.0
#define kSendBtnWidth 50.0

@interface ChatKeyBoardView()
<ChatEmojiViewDelegate,UITextViewDelegate>
{
    NSArray *_icons;//表情、添加按钮集
    CGFloat hight_text_one;
    BOOL keyBoardTap;
    ChatEmojiView *_emojiView;//表情键盘
}

@property (nonatomic,strong) ChatKeyBoardAnimationView *bottomView;

@property (nonatomic,strong) UIButton *faceBtn;//表情按钮
@property (nonatomic,strong) UIButton *otherBtn;//其他按钮
@property (nonatomic,strong) UIButton *sendBtn; //发送按钮
@property (nonatomic,strong) UIView *otherVisibleView;
@end

@implementation ChatKeyBoardView

#pragma mark - Life
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 初始化 init
- (instancetype)initWithDelegate:(id)delegate superView:(UIView *)superView{
    
    self = [super init];
    if (self) {
        //布局View
        [self setUpView];
        [self addNotifations];
        [self addToSuperView:superView];
         self.delegate = delegate;
    }
    return self;
}



#pragma mark setUpView
- (void)setUpView{
    //聊天框及bottomView
    [self initChatBgView];
    //添加按钮
    [self addIcons];
    //表情视图和 图片，拍照
    [self initIconsContentView];
    
}
- (void)initChatBgView{
    //输入背景框
    [self addSubview:self.chatBgView];
    //EmojiView
    [self addSubview:self.bottomView];
}

//输入背景框
- (UIView *)chatBgView{
    
    if (!_chatBgView) {
        
        _chatBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kTabBarHeight+0.5)];
        [_chatBgView setBackgroundColor:[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0]];
        [_chatBgView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [_chatBgView.layer setBorderWidth:0.5];
        [_chatBgView addSubview:self.chatInputTextView];
        
    }
    return _chatBgView;
}

//EmojiView
- (ChatKeyBoardAnimationView *)bottomView{
    
    if (!_bottomView) {
        _bottomView = [[ChatKeyBoardAnimationView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.chatBgView.frame), SCREEN_WIDTH, ChatEmojiView_Hight)];
    }
    return _bottomView;
}

-(void)initIconsContentView{
    _emojiView = [[ChatEmojiView alloc]init];
    _emojiView.delegate = self;
    
}

- (UIView *)otherVisibleView{
    if (!_otherVisibleView) {
        _otherVisibleView = [UIView new];
    }
    return _otherVisibleView;
}

#pragma mark 添加表情、+按钮
- (void)addIcons{
    _icons = @[self.sendBtn];
    
    for (UIButton *btn in _icons) {
        [btn setImage:[UIImage imageNamed:@"chat_bottom_keyboard_nor"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(iconsAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.chatBgView addSubview:btn];
    }
}

//表情
- (UIButton *)faceBtn{
    if (!_faceBtn) {
        _faceBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_faceBtn setFrame:CGRectMake(CGRectGetMaxX(self.chatInputTextView.frame)+5, 0, kFaceBtnWidth, kTabBarHeight)];
        [_faceBtn setImage:[UIImage imageNamed:@"ic_emoji_blue"] forState:UIControlStateNormal];
        [_faceBtn setTag:1];
    }
    return _faceBtn;
}

-(UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_sendBtn setFrame:CGRectMake(CGRectGetMaxX(self.chatInputTextView.frame)+5, 6, kSendBtnWidth, kTabBarHeight-12)];
        _sendBtn.layer.cornerRadius = 3;
        _sendBtn.layer.masksToBounds = YES;
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_sendBtn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
        _sendBtn.backgroundColor = [UIColor blueColor];
        [_sendBtn setTag:111];
    }
    return _sendBtn;
}


//+
- (UIButton *)otherBtn{
    if (!_otherBtn) {
        _otherBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        
        CGFloat faceBtnx = self.faceBtn.frame.origin.x+self.faceBtn.frame.size.width;
        [_otherBtn setFrame:CGRectMake(faceBtnx, 0, 40, kTabBarHeight)];
        [_otherBtn setImage:[UIImage imageNamed:@"ic_add_blue"] forState:UIControlStateNormal];
        [_otherBtn setTag:2];
    }
    return _otherBtn;
}

//聊天输入
- (ChatInputTextView *)chatInputTextView{
    if (!_chatInputTextView) {
        _chatInputTextView=[[ChatInputTextView alloc]init];
        [_chatInputTextView setFont:[UIFont systemFontOfSize:16.0]];
        [_chatInputTextView setBackgroundColor:[UIColor whiteColor]];
        [_chatInputTextView.layer setBorderWidth:0.5];
        [_chatInputTextView.layer setBorderColor:[UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0].CGColor];
        [_chatInputTextView.layer setCornerRadius:4.0];
        [_chatInputTextView.layer setMasksToBounds:YES];
        [_chatInputTextView setReturnKeyType:UIReturnKeySend];
        [_chatInputTextView setEnablesReturnKeyAutomatically:YES];
        [_chatInputTextView setTextContainerInset:UIEdgeInsetsMake(10, 0, 5, 0)];
        [_chatInputTextView setDelegate:self];
        
        hight_text_one = [_chatInputTextView.layoutManager usedRectForTextContainer:_chatInputTextView.textContainer].size.height;
        
        [_chatInputTextView setFrame:CGRectMake(10, 5,[UIScreen mainScreen].bounds.size.width-kSendBtnWidth-20, hight_text_one+20)];
        
    }
    return _chatInputTextView;
}

#pragma mark 添加通知
- (void)addNotifations{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardHiden:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
}


#pragma mark - self delegate action

- (void)changeDuration:(CGFloat)duration{
    //动态调整tableView高度
    if (_delegate && [self.delegate respondsToSelector:@selector(keyBoardView:ChangeDuration:)]) {
        [self.delegate keyBoardView:self ChangeDuration:duration];
    }
}

#pragma mark - NSNotification

- (void)keyBoardHiden:(NSNotification*)noti{
    
    //隐藏键盘
    if (keyBoardTap==NO) {
        CGRect endF = [[noti.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
        CGFloat duration = [[noti.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
        CGRect fram = self.frame;
        fram.origin.y = (endF.origin.y - self.chatBgView.frame.size.height);
        [self duration:duration EndF:fram];
    }else{
        keyBoardTap = NO;
    }
}

- (void)duration:(CGFloat)duration EndF:(CGRect)endF{
    [UIView animateWithDuration:duration animations:^{
        keyBoardTap = NO;
        self.frame = endF;
    }];
    [self changeDuration:duration];
}


- (void)keyBoardShow:(NSNotification*)noti{
    //显示键盘
    CGRect endF = [[noti.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    if (keyBoardTap == NO) {
        for (UIButton * b in _icons) {
            b.selected = NO;
        }
        [self.bottomView addSubview:[UIView new]];
        
        NSTimeInterval duration = [[noti.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
        CGRect fram = self.frame;
        fram.origin.y = (endF.origin.y - _chatBgView.frame.size.height);
        [self duration:duration EndF:fram];
    }else{
        keyBoardTap = NO;
    }
}

#pragma mark addToSuperView
- (void)addToSuperView:(UIView *)superView{
    CGFloat s_h  = SCREEN_HEIGHT;
    CGRect frame = CGRectMake(0,s_h-0.5,[UIScreen mainScreen].bounds.size.width, s_h+0.5);
    self.frame = frame;
    [superView addSubview:self];
}

#pragma mark Event
- (void)iconsAction:(UIButton *)sender{
    
    if (sender.selected) {
        [self.chatInputTextView becomeFirstResponder];
        return;
    }else{
        keyBoardTap = YES;
        [self.chatInputTextView resignFirstResponder];
    }
    
    for (UIButton * b in _icons) {
        if ([b isEqual:sender]) {
            sender.selected = !sender.selected;
        }else{
            b.selected = NO;
        }
    }
    
    UIView * visiableView;
    
    CGRect endFrame = self.frame;
    
    
    switch (sender.tag) {
        case 1:
        {
            //表情
            visiableView = _emojiView;
            endFrame.origin.y = SCREEN_HEIGHT - (CGRectGetHeight(visiableView.frame) +self.chatBgView.bounds.size.height+64);
        }
            break;
        default:{
            visiableView = self.otherVisibleView;
            endFrame.origin.y = [UIScreen mainScreen].bounds.size.height+kTabBarHeight;
        }
            break;
    }
    
    [self.bottomView addSubview:visiableView];

    [self duration:DURTAION EndF:endFrame];
}

#pragma mark - Public
-(void)tapAction{
    UIButton * b = [[UIButton alloc]init];
    b.selected = NO;
    [self iconsAction:b];
}

- (void)tapShowInputTextView{
    UIButton * b = [[UIButton alloc]init];
    b.selected = YES;
    [self iconsAction:b];
//    [self textViewChangeText];
}


-(void)topLayoutSubViewWithH:(CGFloat)hight{
    CGRect frame = self.chatBgView.frame;
    CGFloat diff = hight - frame.size.height;
    frame.size.height = hight;
    self.chatBgView.frame = frame;
    
    frame = self.bottomView.frame;
    frame.origin.y = CGRectGetHeight(self.chatBgView.bounds);
    self.bottomView.frame = frame;
    
    frame = self.frame;
    frame.origin.y -= diff;
    
    [self duration:DURTAION EndF:frame];
}


#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    [self textViewChangeText];
}



-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if(![textView hasText] && [text isEqualToString:@""]) {
        return NO;
    }
    
    NSString *result;
    
    if (textView.text.length >= range.length)
    {
        result = [textView.text stringByReplacingCharactersInRange:range withString:text];
    }
    
    if (result.length > 300)
    {
        return NO;
    }
    
    if ([text isEqualToString:@"\n"]) {
        [self sendMessage];
        return NO;
    }
    return YES;
}

//动态调整textView的高度
-(void)textViewChangeText{
    CGFloat h = [self.chatInputTextView.layoutManager usedRectForTextContainer:self.chatInputTextView.textContainer].size.height;
    self.chatInputTextView.contentSize = CGSizeMake(self.chatInputTextView.contentSize.width, h+20);
    
    int numberOfRowsShow;
    if (!_maxNumberOfRows) {
        numberOfRowsShow = 4;
    }
    else{
        numberOfRowsShow = _maxNumberOfRows;
    }
    
    CGFloat rows_h = hight_text_one*numberOfRowsShow;
    h = h>rows_h?rows_h:h;
    CGRect frame = self.chatInputTextView.frame;
    CGFloat diff = self.chatBgView.frame.size.height - self.chatInputTextView.frame.size.height;
    if (frame.size.height == h+20) {
        if (h == rows_h) {
            [self.chatInputTextView setContentOffset:CGPointMake(0, self.chatInputTextView.contentSize.height - h - 20) animated:NO];
        }
        return;
    }
    
    frame.size.height = h+20;
    self.chatInputTextView.frame = frame;
    [self topLayoutSubViewWithH:(frame.size.height+diff)];
    [self.chatInputTextView setContentOffset:CGPointZero animated:YES];
}

#pragma mark - ChatEmojiViewDelegate

- (void)chatEmojiViewSelectEmojiIcon:(EmojiObj *)objIcon{
    //选择了某个表情
    EmojiTextAttachment *attach = [[EmojiTextAttachment alloc] initWithData:nil ofType:nil];
    attach.Top = -3.5;
    attach.image = [UIImage imageNamed:objIcon.emojiImgName];
    NSMutableAttributedString * attributeString =[[NSMutableAttributedString alloc]initWithAttributedString:self.chatInputTextView.attributedText];;
    if (attach.image && attach.image.size.width > 1.0f) {
        attach.emoName = objIcon.emojiString;
        [attributeString insertAttributedString:[NSAttributedString attributedStringWithAttachment:attach] atIndex:_chatInputTextView.selectedRange.location];
        
        NSRange range;
        range.location = self.chatInputTextView.selectedRange.location;
        range.length = 1;
        
        NSParagraphStyle *paragraph = [NSParagraphStyle defaultParagraphStyle];
        
        [attributeString setAttributes:@{NSAttachmentAttributeName:attach, NSFontAttributeName:self.chatInputTextView.font,NSBaselineOffsetAttributeName:[NSNumber numberWithInt:0.0], NSParagraphStyleAttributeName:paragraph} range:range];
    }
    self.chatInputTextView.attributedText = attributeString;
    [self textViewChangeText];
   
}

- (void)chatEmojiViewTouchUpinsideDeleteButton{
    //点击了删除表情
    NSRange range = self.chatInputTextView.selectedRange;
    NSInteger location = (NSInteger)range.location;
    if (location == 0) {
        return;
    }
    range.location = location-1;
    range.length = 1;
    
    NSMutableAttributedString *attStr = [self.chatInputTextView.attributedText mutableCopy];
    [attStr deleteCharactersInRange:range];
    self.chatInputTextView.attributedText = attStr;
    self.chatInputTextView.selectedRange = range;
    [self textViewChangeText];
   
}

- (void)chatEmojiViewTouchUpinsideSendButton{
    //表情键盘：点击发送表情
    [self sendMessage];

}

-(void)sendMessage{
    if (![self.chatInputTextView hasText]&&(self.chatInputTextView.text.length==0)) {
        return;
    }
    NSString *plainText = self.chatInputTextView.plainText;
    //空格处理
    plainText = [plainText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (plainText.length > 0) {
        [self sendMessage:plainText];
        self.chatInputTextView.text = @"";
        [self textViewChangeText];
    }
}

- (void)sendMessage:(NSString *)message{
    //发送消息
    if (_delegate && [self.delegate respondsToSelector:@selector(keyBoardView:sendMessage:)]) {
        [_delegate keyBoardView:self sendMessage:message];
    }
}


@end
