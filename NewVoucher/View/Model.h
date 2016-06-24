//
//  Model.h
//  NewVoucher
//
//  Created by YHIOS002 on 16/6/21.
//  Copyright © 2016年 YHSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int,Type){
    borrow = 1,
    loan   = 2
};
@interface Model : NSObject

@property (nonatomic,copy) NSString *summary;
@property (nonatomic,copy) NSString *subject;
@property (nonatomic,copy) NSString *control;

@property (nonatomic,assign) Type type;
@end
