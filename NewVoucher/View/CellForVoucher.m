//
//  CellForVoucher.m
//  NewVoucher
//
//  Created by YHIOS002 on 16/6/21.
//  Copyright © 2016年 YHSoft. All rights reserved.
//

#import "CellForVoucher.h"
#import "YHActionSheet.h"

@implementation CellForVoucher

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellId = @"CellForVoucher";
    CellForVoucher *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        UINib *nib = [UINib nibWithNibName:@"CellForVoucher" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:cellId];
        cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
    }
    return cell;
}

-(void)setModel:(Model *)model{
    _model = model;
    [self.btnSummary setTitle:_model.summary forState:UIControlStateNormal];
     [self.btnSubject setTitle:_model.subject forState:UIControlStateNormal];
     [self.btnControl setTitle:_model.control forState:UIControlStateNormal];
    if (_model.type == borrow) {
        self.labelType.text = @"借方";
    }
    else{
        self.labelType.text = @"贷方";
    }
}

#pragma mark - Action

- (IBAction)onSummary:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(onSummaryInCell:)]) {
        [_delegate onSummaryInCell:self];
    }
}

- (IBAction)onSubject:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(onSubjectInCell:)]) {
        [_delegate onSubjectInCell:self];
    }
}
- (IBAction)onControl:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(onTypeInCell:)]) {
        [_delegate onTypeInCell:self];
    }
}

- (IBAction)onMore:(id)sender {
    
    if (self.indexPath.row == 0) {
        YHActionSheet *sheet = [[YHActionSheet alloc] initWithCancelTitle:@"取消" otherTitles:@[@"增行"]];
        [sheet dismissForCompletionHandle:^(NSInteger clickedIndex, BOOL isCancel) {
            if (!isCancel) {
                if (clickedIndex == 0) {
                    NSLog(@"增行");
                    if (_delegate && [_delegate respondsToSelector:@selector(addRowWithCell:)]) {
                        [_delegate addRowWithCell:self];
                    }
                }
            }
        }];
        [sheet show];
    }
    else{
        YHActionSheet *sheet = [[YHActionSheet alloc] initWithCancelTitle:@"取消" otherTitles:@[@"增行",@"减行"]];
        [sheet dismissForCompletionHandle:^(NSInteger clickedIndex, BOOL isCancel) {
            if (!isCancel) {
                if (clickedIndex == 0) {
                    NSLog(@"增行");
                    if (_delegate && [_delegate respondsToSelector:@selector(addRowWithCell:)]) {
                        [_delegate addRowWithCell:self];
                    }
                }
                else {
                    NSLog(@"减行");
                    if (_delegate && [_delegate respondsToSelector:@selector(deleteRowWithCell:)]) {
                        [_delegate deleteRowWithCell:self];
                    }
                }
            }
        }];
        [sheet show];
    }
   
    
}

@end
