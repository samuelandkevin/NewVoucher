//
//  CellForVoucher.h
//  NewVoucher
//
//  Created by YHIOS002 on 16/6/21.
//  Copyright © 2016年 YHSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"

@class CellForVoucher;
@protocol CellForVoucherDelegate <NSObject>

- (void)addRowWithCell:(CellForVoucher *)cell;
- (void)deleteRowWithCell:(CellForVoucher *)cell;
- (void)onSubjectInCell:(CellForVoucher *)cell;
- (void)onSummaryInCell:(CellForVoucher *)cell;
- (void)onTypeInCell:(CellForVoucher *)cell;
@end

@interface CellForVoucher : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *btnSummary;
@property (weak, nonatomic) IBOutlet UIButton *btnSubject;
@property (weak, nonatomic) IBOutlet UIButton *btnControl; //借/贷
@property (weak, nonatomic) IBOutlet UILabel *labelType;
@property (weak, nonatomic) id<CellForVoucherDelegate>delegate;
@property (assign,nonatomic) NSIndexPath *indexPath;
@property (strong,nonatomic) Model *model;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
