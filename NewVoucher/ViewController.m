//
//  ViewController.m
//  NewVoucher
//
//  Created by YHIOS002 on 16/6/21.
//  Copyright © 2016年 YHSoft. All rights reserved.
//

#import "ViewController.h"
#import "CellForVoucher.h"
#import "Model.h"
#import "ChatKeyBoardView.h"

typedef NS_ENUM(int,EditType){
    EditType_Summary = 101,
    EditType_Subject ,
    EditType_ControlType
};

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,CellForVoucherDelegate,ChatKeyBoardViewDelegate>{
    NSIndexPath *_indexPath;
}


@property(nonatomic,strong) NSMutableArray *borrowArray;
@property(nonatomic,strong) NSMutableArray *loanArray;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) ChatKeyBoardView *chatKeyBoardView;
@property(nonatomic,assign) EditType editType;
@end

@implementation ViewController

//聊天框
- (ChatKeyBoardView *)chatKeyBoardView
{
    if (!_chatKeyBoardView)
    {
        _chatKeyBoardView = [[ChatKeyBoardView alloc] initWithDelegate:self superView:self.view];
    }
    return _chatKeyBoardView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    [self.view addSubview:self.tableView];
    
    [self.view insertSubview:self.chatKeyBoardView aboveSubview:self.view];
    self.chatKeyBoardView.delegate = self;
    
    self.borrowArray = [NSMutableArray array];
    self.loanArray   = [NSMutableArray array];
    
    Model *bmodel = [Model new];
    bmodel.control = @"";
    bmodel.summary = @"";
    bmodel.subject = @"";
    bmodel.type = borrow;
    [self.borrowArray addObject:bmodel];
  
    Model *lmodel = [Model new];
    lmodel.control = @"";
    lmodel.summary = @"";
    lmodel.subject = @"";
    lmodel.type = loan;
    [self.loanArray addObject:lmodel];
   
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return [_borrowArray count];
    }
    return [_loanArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        CellForVoucher *cell =  [CellForVoucher cellWithTableView:tableView];
        cell.delegate = self;
        cell.indexPath = indexPath;
        cell.model = self.borrowArray[indexPath.row];
        return cell;

    }
    else{
        CellForVoucher *cell =  [CellForVoucher cellWithTableView:tableView];
        cell.delegate = self;
        cell.indexPath = indexPath;
        cell.model = self.loanArray[indexPath.row];
        return cell;

    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark - CellForVoucherDelegate
- (void)addRowWithCell:(CellForVoucher *)cell{
    
    
    if (cell.indexPath.section == 0) {
        
        Model *bmodel = [Model new];
        bmodel.control = @"";
        bmodel.summary = @"";
        bmodel.subject = @"";
        bmodel.type = borrow;
        [self.borrowArray addObject:bmodel];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        

    }
    else{
        Model *lmodel = [Model new];
        lmodel.control = @"";
        lmodel.summary = @"";
        lmodel.subject = @"";
        lmodel.type = loan;
            
        [self.loanArray addObject:lmodel];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];

    }
}

- (void)deleteRowWithCell:(CellForVoucher *)cell{
    if (cell.indexPath.section == 0) {
        if (cell.indexPath.row < self.borrowArray.count) {
            
            [self.borrowArray removeObjectAtIndex:cell.indexPath.row];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
    else{
        if (cell.indexPath.row < self.loanArray.count) {
            
            [self.loanArray removeObjectAtIndex:cell.indexPath.row];
           [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}

- (void)onSummaryInCell:(CellForVoucher *)cell{
    _indexPath = cell.indexPath;
    _editType = EditType_Summary;
    [self.chatKeyBoardView tapShowInputTextView];
}

- (void)onSubjectInCell:(CellForVoucher *)cell{
    _indexPath = cell.indexPath;
    _editType = EditType_Subject;
    [self.chatKeyBoardView tapShowInputTextView];
}

- (void)onTypeInCell:(CellForVoucher *)cell{
    _indexPath = cell.indexPath;
    _editType = EditType_ControlType;
    [self.chatKeyBoardView tapShowInputTextView];
}

#pragma mark - ChatKeyBoardViewDelegate

- (void)keyBoardView:(ChatKeyBoardView *)keyBoard sendMessage:(NSString *)message
{
    if (_indexPath.section == 0) {
        if(_indexPath.row < self.borrowArray.count){
            
            Model *model = self.borrowArray[_indexPath.row];
            switch (_editType) {
                case EditType_Summary:{
                    model.summary = message;
                }
                    
                    break;
                case EditType_Subject:{
                    model.subject = message;
                }
                    
                    break;
                case EditType_ControlType:{
                    model.control = message;
                }
                    
                    break;
                default:
                    break;
            }
        }
    }
    else{
        if(_indexPath.row < self.loanArray.count){
            
            Model *model = self.loanArray[_indexPath.row];
            switch (_editType) {
                case EditType_Summary:{
                    model.summary = message;
                }
                    
                    break;
                case EditType_Subject:{
                    model.subject = message;
                }
                    
                    break;
                case EditType_ControlType:{
                    model.control = message;
                }
                    
                    break;
                default:
                    break;
            }
        }

    }
    //表情键盘收起
    [self.chatKeyBoardView tapAction];
    [self.tableView reloadData];

}

@end
